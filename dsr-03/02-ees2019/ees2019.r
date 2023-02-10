# ------------------------------------------------------------------------------
# European Election Study 2019
#
# A demo of (slightly complex) data management, also showing how to use
# regular expressions and apply survey weights.
# ------------------------------------------------------------------------------

library(survey)
library(srvyr)
library(tidyverse)

# ------------------------------------------------------------------------------
# Load European Election Studies (EES) Voter Study 2019
# ------------------------------------------------------------------------------

dta <- haven::read_dta("data/ZA7581_v1-0-0.dta")

glimpse(dta)

# country sample sizes
group_by(dta, countrycode) %>%
  count()

# inspect Questions 10_* (probability to vote for given party)
select(dta, starts_with("Q10_"))

# inspect coding
haven::print_labels(dta$q10_7)

# preview a reshape from 'wide' to 'long'
select(dta, starts_with("Q10_")) %>%
  tidyr::pivot_longer(everything(), names_to = "party", values_to = "q10")

# apply the transformation
d <- dta %>%
  # select respondent and country identifiers, plus Q10_* responses
  select(respid:countrycode, starts_with("Q10_")) %>%
  # reshape from 'wide' to 'long' format
  pivot_longer(starts_with("Q10"), names_to = "party", values_to = "q10") %>%
  # recode response items above 10 as missing
  mutate(q10 = if_else(q10 > 10, NA_real_, as.numeric(q10)))

# total number of observations per country/party
group_by(d, countrycode, party) %>%
  count() %>%
  print(n = 100)

# percentages of non-missing Q10_* responses
group_by(d, countrycode, party) %>%
  arrange(party) %>%
  summarise(
    n_total = n(),
    p_nonmissing = 100 * sum(!is.na(q10)) / n_total
  ) %>%
  filter(p_nonmissing > 0) %>%
  print(n = Inf)

# ------------------------------------------------------------------------------
# Load Party List dataset
# ------------------------------------------------------------------------------

p <- readr::read_csv("data/ZA7581_cp.csv")

glimpse(p)

# show parties for which Q10 is non-missing
p <- p %>%
  # rename and rename variables (columns)
  select(
    country = Coutnry_short,
    countrycode,
    partyname = `English name`, # Party_name_questionnaire
    party = Q10_PTV,
    partycode = Q9_Q25_EES,
    ends_with("_EES")
  ) %>%
  # subset to rows with non-missing countries
  filter(!is.na(countrycode)) %>%
  # keep only unique rows
  distinct()

# View(p)
p <- filter(p, !is.na(party))

# quick demos of matching on regular expressions (regex) ------------------

filter(p, stringr::str_detect(partyname, "[Gg]reen|[Ee]colog")) %>%
  print(n = Inf)

filter(p, stringr::str_detect(partyname, "[Gg]reen")) %>%
  select(country, partyname) %>%
  mutate(what = stringr::str_extract(partyname, "Green\\s\\w+")) %>%
  filter(!is.na(what))

# ------------------------------------------------------------------------------
# Harmonize party codes
# ------------------------------------------------------------------------------

select(d, countrycode, party, q10) # we want to merge this...
select(p, countrycode, party, partyname, partycode) # ... with that

# # demo, keeping all parties on both sides (full join)
# select(d, countrycode, party) %>%
#   group_by(countrycode, party) %>%
#   count() %>%
#   full_join(select(p, countrycode, party, partyname)) %>%
#   View() # ... shows a problem

# inspect country codes
unique(d$countrycode)
unique(p$countrycode)

# parties
unique(p$party) # some of those will be dropped when merging
unique(d$party) # some of those are have only missing values and will also go

# solution to problem
d$party <- stringr::str_to_upper(d$party)

# ------------------------------------------------------------------------------
# Remove Belgium: party names are not attached to a unique Q10_* identifier
# Reason: Wallonia and Flanders
# Merging would cause duplicated rows in the result
# ------------------------------------------------------------------------------

group_by(p, country, countrycode, party) %>%
  count() %>%
  filter(n > 1)

p <- filter(p, !country %in% "BE")

# ------------------------------------------------------------------------------
# Merge datasets and summarise Pr( Vote ) by country/party
# ------------------------------------------------------------------------------

# merge party names with Q10 answers
ptv <- inner_join(d, p, by = c("countrycode", "party")) %>%
  # group by country-party dyad
  group_by(country, countrycode, party, partyname, partycode) %>%
  # compute mean probability to vote, with sd
  summarise(
    mu_ptv = mean(q10, na.rm = TRUE),
    sd_ptv = sd(q10, na.rm = TRUE)
  ) %>%
  # sort by country and then PTV by descending order
  arrange(country, -mu_ptv)

# ------------------------------------------------------------------------------
# Check data for France
# ------------------------------------------------------------------------------

# data from respondent answers
with(filter(d, hCountry == 11), table(party, q10, exclude = NULL))
## same result, longer code:
# table(d$party[ d$hCountry == 11 ], d$q10[ d$hCountry == 11 ], exclude = NULL)

# data from party dataset
filter(p, country == "FR")

# merged results for French parties
filter(ptv, country == "FR")

# As a slightly more complex exercise, you could merge that data to the ParlGov
# table for political parties (view_party.csv), which would give you dozens of
# additional variables to use. In that case, the party id on which to merge is
# the `partycode` variable that we preserved all throughout without using it.

# ------------------------------------------------------------------------------
# Demo of survey weighting
# ------------------------------------------------------------------------------

# French respondents, voted in last (EU) election
filter(dta, hCountry == 11) %>%
  count(Q6)

# French respondents, party list voted for
filter(dta, hCountry == 11) %>%
  count(Q7)

# survey weights (EES documentation Appendix 3)
select(dta, starts_with("WGT"))

# WGT5 adjusts weights to age/sex, urbanity, region, education
# + turnout (Q6) + recall (Q7)

# create a survey design object for French respondents
fra <- filter(dta, hCountry == 11) %>%
  # replace party codes with party names (labels)
  mutate(Q7 = droplevels(haven::as_factor(Q7))) %>%
  # weight using WGT5 (ids ~ 1 means that there is no PSU or strata)
  survey::svydesign(ids = ~ 1, weights = ~ WGT5, data = .)

# weighted vote responses, using the {survey} package
survey::svytotal(~ Q7, fra)

# weighted vote responses, using the {srvyr} package
srvyr::as_survey(fra) %>%
  srvyr::survey_count(Q7)

# have a nice day
