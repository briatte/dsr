# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Spring 2025
# |____/|_____|__|__|
#
# Covid-19 and global income inequality (Deaton)
#
# ============================= See README file for data sources and details ===

# required packages

library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: load the three data sources
# ------------------------------------------------------------------------------

# load and prepare COVID-19 deaths data -----------------------------------

f <- "data/covid-deaths-daily-vs-total-per-million.csv"

deaths <- readr::read_csv(f, locale = locale(encoding = "latin1")) %>%
  filter(Date <= as.Date("2020-12-31")) %>%
  group_by(Code) %>%
  filter(Date == max(Date)) %>%
  select(
    country = Entity,
    ccode = Code,
    date = Date,
    deaths = `Total confirmed deaths due to COVID-19 per million people`
  ) %>%
  mutate(log_deaths = log(deaths))

# steps taken:
#
# 1. read CSV file at file path `f`, using Windows ISO-8859-1 Latin-1 encoding
# 2. remove rows/observations that go beyond December 31, 2020
# 3. group the data by 'Code' (country code)
# 4. within each group (country code), subset to the row with the latest date
# 5. select relevant columns/variables, renaming them simultaneously
# 6. log-transform one of the measurements

# load and prepare population data ----------------------------------------

f <- "data/API_SP.POP.TOTL_DS2_en_excel_v2_1926530.xls"

pop <- readxl::read_excel(f, skip = 2) %>%
  select(
    country = `Country Name`,
    ccode = `Country Code`,
    pop2019 = `2019`
  ) %>%
  mutate(log_pop = log(pop2019))

# steps taken:
#
# 1. read Excel file at file path `f`, skipping first 2 rows
# 2. select relevant columns/variables, renaming them simultaneously
# 3. log-transform one of the measurements

# load and prepare GDP/capita data ----------------------------------------

f <- "data/API_NY.GDP.PCAP.PP.KD_DS2_en_excel_v2_1930672.xls"

gdpc <- readxl::read_excel(f, skip = 2) %>%
  select(
    country = `Country Name`,
    ccode = `Country Code`,
    gdpc2019 = `2019`
  ) %>%
  mutate(log_gdpc = log(gdpc2019))

# steps taken: (same as above)

# ------------------------------------------------------------------------------
# Step 2: merge all data sources and finalise dataset
# ------------------------------------------------------------------------------

# merge WDI indicators together -------------------------------------------

wdi <- full_join(pop, gdpc, by = c("country", "ccode"))

# note:
#
# the merge above is a 'full join' that will keep all observations from both
# datasets, and there are two identifier variables (`country` and `ccode`)

# see what happens if you leave out one of the identifying columns/variables
full_join(pop, gdpc, by = "country")

# merge WDI indicators to Covid-19 deaths ---------------------------------

d <- inner_join(deaths, wdi, by = c("country", "ccode"))

# note:
#
# the merge above is an 'inner join' that will keep only observations present
# in both datasets, with identical country names and country codes

# see which rows of `deaths` have no match in `wdi`
anti_join(deaths, wdi, by = c("country", "ccode"))

# see which rows of `wdi` have no match in `deaths`
anti_join(wdi, deaths, by = c("country", "ccode"))

# note:
#
# by merging on country names and country codes, we assumed that all three data
# sources used the same country names and codes... which might or might not be
# the case: as you can see, COD (Democratic Republic of Congo) gets dropped due
# to a mismatched country name
#
# this is good enough for our purposes, but a safer and better merge would have
# used only country codes, and would have harmonised those first with the help
# of the {countrycode} package, for instance, plus some manual checks; lesson:
# spend enough time learning about your data

# inspect result ----------------------------------------------------------

# uncomment or type to run
# View(d)

# you should be checking your results from time to time, either visually, as
# shown here, or through more thorough/systematic checks

# check the first rows
head(d)

# check the last rows
tail(d)

# another way to check on your dataset, as provided by the {dplyr} package
glimpse(d)

# another way yet, provided by base R, which will reveal technical details
str(d)

# a more thorough check that will 'break' your code (stop execution) if there
# are duplicated country codes, which should not be the case in this dataset,
# since the data are cross-sectional
stopifnot(!duplicated(d$ccode))

# identify OECD countries -------------------------------------------------

oecd <- c("AUS", "AUT", "BEL", "CAN", "CHL", "CZE", "DNK", "EST", "FIN",
          "FRA", "DEU", "GRC", "HUN", "ISL", "IRL", "ISR", "ITA", "JPN",
          "KOR", "LVA", "LTU", "LUX", "MEX", "NLD", "NZL", "NOR", "POL",
          "PRT", "SVK", "SVN", "ESP", "SWE", "CHE", "TUR", "GBR", "USA")

d$oecd <- d$ccode %in% oecd

# note:
#
# the steps from that section and the previous one could have been written as
# a single sequence of instructions:
#
# full_join(pop, gdpc, by = c("country", "ccode")) %>%
#   inner_join(deaths, by = "ccode") %>%
#   mutate(oecd = ccode %in% oecd)

# ------------------------------------------------------------------------------
# Step 3: visualize
# ------------------------------------------------------------------------------

# redraw Deaton's Fig. 1, or at least something close enough to it

ggplot(d, aes(x = log_gdpc, y = log_deaths, color = oecd, size = pop2019)) +
  # label China and India
  geom_text(
    data = filter(d, ccode %in% c("CHN", "IND")),
    aes(label = country, color = oecd),
    size = 5
  ) +
  # draw linear trend
  geom_smooth(
    method = "lm", mapping = aes(color = NULL, weight = pop2019), se = FALSE,
    lty = "dashed", size = 2/3
  ) +
  # draw actual data points
  geom_point(shape = 1, stroke = 1) +
  # control colours
  scale_color_manual(values = c("TRUE" = "black", "FALSE" = "#aa0000")) +
  # control point size
  scale_size_continuous(range = c(2, 20)) +
  # final cosmetics
  theme_light() +
  theme(legend.position = "none", panel.grid.minor = element_blank())

# note:
#
# {ggplot2} plot syntax is the topic of our next session together, so feel
# free to just ignore the code above when revising what we learnt today

# kthxbye
