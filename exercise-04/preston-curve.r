# ------------------------------------------------------------------------------
# Exercise 4: Draw the Preston curve
# ------------------------------------------------------------------------------

library(countrycode)
library(tidyverse)
library(WDI)

# ------------------------------------------------------------------------------
# Step 1: import the data
# ------------------------------------------------------------------------------

what <- c(
  "lexp" = "SP.DYN.LE00.IN",
  "gdpc" = "NY.GDP.PCAP.PP.CD",
  "pop" = "SP.POP.TOTL"
)
wdi <- WDI::WDI(indicator = what, start = 2019)

wdi <- wdi %>%
  mutate(
    # remove non-country ISO-3C does
    iso3c = countrycode::countrycode(iso3c, "iso3c", "iso3c"),
    region = countrycode::countrycode(iso3c, "iso3c", "region")
  ) %>%
  # drop rows with missing values
  tidyr::drop_na() %>%
  # subset to most recent year
  group_by(iso3c) %>%
  filter(year == max(year)) %>% 
  as_tibble()

# countries with largest populations
filter(wdi, pop > 200 * 10^6)

# ------------------------------------------------------------------------------
# Step 2: draw the owl
# ------------------------------------------------------------------------------

# ...

# export final result
# ggsave("preston-curve.png", width = 9, height = 6)

# kthxbye
