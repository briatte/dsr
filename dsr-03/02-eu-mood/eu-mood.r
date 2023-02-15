# ------------------------------------------------------------------------------
# Visualizing the 'EU Mood' indicator
#
# A demo of how to clean up, summarise and visualize a small dataset, using
# functions from various {tidyverse} packages.
# ------------------------------------------------------------------------------

library(countrycode)
library(tidyverse) # {dplyr}, {ggplot2}, {readxl}, {stringr}, {tidyr}, etc.

# ------------------------------------------------------------------------------
# Load and clean up the data
# ------------------------------------------------------------------------------

d <- readxl::read_excel("data/S0007123416000776sup001.xlsx", sheet = 2) %>%
  rename(year = `...1`) %>%
  # remove first row
  filter(!is.na(year)) %>%
  # reshape from wide to long
  tidyr::pivot_longer(-year, names_to = "country", values_to = "mood") %>%
  # keep only rows where ...
  filter(
    # `year` starts with a 4-digit number
    str_detect(year, "^\\d{4}"),
    # `country` starts with a character
    str_detect(country, "^\\w"),
    # `mood` is non-missing
    !is.na(mood)
  ) %>%
  mutate(
    # convert `mood` to numeric
    mood = as.numeric(mood),
    # convert `year` to year + 0.5 if the value marks Semester 2
    year = str_replace(year, "_1", ".0"),
    year = str_replace(year, "_2", ".5"),
    year = as.numeric(year),
    # semesters and decades
    semester = if_else(year == round(year), 1, 2),
    decade = 10 * as.integer(year) %/% 10,
    # fix country name for Bulgaria
    country = if_else(country == "Bulgarian", "Bulgaria", country)
    )

# View(d)

# ------------------------------------------------------------------------------
# Summary statistics by decade
# ------------------------------------------------------------------------------

# decade-level summary for all countries
group_by(d, decade) %>%
  summarise(
    mu_mood = mean(mood),
    sd_mood = sd(mood)
  )

# decade-level summary by country
group_by(d, country, decade) %>%
  summarise(
    mu_mood = mean(mood),
    sd_mood = sd(mood)
  )

# change from one decade to the next
group_by(d, country, decade) %>%
  summarise(mu_mood = mean(mood)) %>%
  mutate(
    previous_decade = dplyr::lag(mu_mood, 1),
    delta = mu_mood - previous_decade
  ) %>%
  # show only changes between 2000 and 2010
  filter(decade == 2010) %>%
  # show all EU-27 countries
  print(n = 27)

# ------------------------------------------------------------------------------
# Visualization
# ------------------------------------------------------------------------------

# get ISO3-C country codes
d$country <- countrycode::countrycode(d$country, "country.name", "iso3c")

# mark EP election years
e <- c(1979, 1984, 1989, 1994, 1999, 2004, 2009, 2014, 2019)
d$ep_election <- if_else(d$year %in% e, d$mood, NA_real_)

# line plot, faceted by country
ggplot(d, aes(year, mood)) +
  geom_line() +
  geom_point(aes(y = ep_election), color = "steelblue") +
  facet_wrap(~ country) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank()
  )

# ggsave("eu-mood.png")

# have a nice day
