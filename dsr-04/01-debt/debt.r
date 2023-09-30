# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2023
# |____/|_____|__|__|
#
# Economic growth and public debt (Reinhart and Rogoff)
#
# ============================= See README file for data sources and details ===

# required packages

library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: import the two datasets
# ------------------------------------------------------------------------------

# read the 'growth' dataset
growth <- readr::read_csv("data/growth.csv")

# inspect the result
glimpse(growth)

# read the 'debt' dataset
debt <- readr::read_csv("data/debt.csv")

# inspect the result
glimpse(debt)

# ------------------------------------------------------------------------------
# Step 2: join them by country-year
# ------------------------------------------------------------------------------

# note that there are two identifying columns: `country` and `year`
full_join(growth, debt, by = c("country", "year"))

# if you forget the `year` one, chaos will ensue -- you will get two `year`
# columns that really should be only one
full_join(growth, debt, by = "country")

# if you forget the `country` one, chaos will ensue -- same problem as above,
# but with countries instead of years
full_join(growth, debt, by = "year")

# let's save the (correctly) merged dataset
rr <- full_join(growth, debt, by = c("country", "year"))

# list countries above the 90% ratio, by decade
filter(rr, ratio >= 90) %>% 
  group_by(decade) %>% 
  group_split()

# ------------------------------------------------------------------------------
# Step 3: explore the data
# ------------------------------------------------------------------------------

# right now, what you have in your dataset are two time series -- here's the
# one for debt-to-GDP ratio:
ggplot(rr, aes(x = year, y = ratio, group = country)) +
  geom_line()

# however, the relationship we are interested in is how this ratio relates to
# the other series, economic growth, so we should be looking at both series
# together:
ggplot(rr, aes(x = ratio, y = growth, group = country)) +
  geom_point()

# visualizing all data points together is inefficient, so let's break it down
# by decade by adding this to the data:
rr$decade <- 10 * rr$year %/% 10

# this allows to break down the plot into small multiples (facets)
ggplot(rr, aes(x = ratio, y = growth, group = country)) +
  geom_point() +
  facet_wrap(~ decade)

# we're getting somewhere, but if you inspect the data, you will find missing
# values -- which can be excluded by using the `tidyr::drop_na` function, which
# will exclude all rows that hold any missing values (more on that later):
ggplot(tidyr::drop_na(rr), aes(x = ratio, y = growth, group = country)) +
  geom_point() +
  facet_wrap(~ decade)

# let's reformulate the two steps above (creating decades and excluding rows
# with missing values) into a 'chain' of functions that does the same thing:
rr <- rr %>% 
  mutate(decade = 10 * year %/% 10) %>% 
  tidyr::drop_na(growth, ratio)

# the reformulation is syntactically more compact, and also more careful than
# what we did earlier, as we specify which variables should be used by the
# `drop_na` function to remove missing values: this makes sure that no other
# variable present in the dataset gets accidentally taken into account at that
# step, which could have led to excessive data loss
#
# another way to write that step safely is to use `filter`:
#
# filter(!is.na(growth), !is.na(ratio))

# now, here's a reformulation of the last plot, where we slightly tweak the
# facets in order to get a horizontalized plot, with separate x-axis scales:
ggplot(rr, aes(ratio, growth)) +
  geom_point() +
  facet_wrap(~ decade, nrow = 1, scales = "free_x")

# ... a final variation, where we add a nonlinear approximation of the expected
# relationship, along with some colour to distinguish countries below and above
# the 90% threshold mentioned in the study:
ggplot(rr, aes(ratio, growth)) +
  geom_point(aes(color = ratio < 90)) +
  geom_smooth(color = "black", se = FALSE) +
  facet_wrap(~ decade, nrow = 1, scales = "free_x") +
  theme_linedraw()

# (the final `theme` element is purely cosmetic)

# ------------------------------------------------------------------------------
# Step 4: highlight EU member states
# ------------------------------------------------------------------------------

# we're getting where we want to be...
ggplot(rr, aes(ratio, growth)) +
  geom_point(color = "grey50", alpha = 3/4) +
  geom_smooth(color = "black", se = FALSE) +
  facet_wrap(~ decade, nrow = 1, scales = "free_x")

# ... but let's go an extra step and highlight EU member states, using a third
# dataset that actually comes in TSV, not CSV format:
eu <- readr::read_tsv("data/eu-membership.tsv")
eu

# this dataset contains only EU countries, so this time, we use `left_join` in
# order to preserve the rows with non-EU countries in our primary dataset:
left_join(rr, eu, by = "country")

# see the results for e.g. Belgium:
left_join(rr, eu, by = "country") %>% 
  filter(country == "Belgium")

# since EU membership has a start date (accession), let's create a variable to
# identify the rows where the country has joined the EU:
left_join(rr, eu, by = "country") %>% 
  filter(country == "Belgium") %>% 
  mutate(joined_eu = !is.na(accession) & year >= accession)

# perfect -- that's what we need, so let's save it
rr <- left_join(rr, eu, by = "country") %>% 
  mutate(
    # mark EU membership as TRUE or FALSE
    joined_eu = !is.na(accession) & year >= accession,
    # replace `TRUE` with "EU", `FALSE` with "Non-EU"
    joined_eu = if_else(joined_eu, "EU", "Non-EU")
  )

# ------------------------------------------------------------------------------
# Step 5: visualize
# ------------------------------------------------------------------------------

# ... and here's the plot with EU member states highlighted
ggplot(rr, aes(ratio, growth)) +
  geom_point(aes(color = joined_eu), alpha = 3/4) +
  geom_smooth(color = "black", se = FALSE) +
  facet_wrap(~ decade, nrow = 1, scales = "free_x") +
  scale_color_manual("", values = c("EU" = "steelblue", "Non-EU" = "grey50")) +
  theme_linedraw() +
  labs(y = "GDP growth (%)", x = "debt-to-GDP ratio")

# ... and a variation that splits the data by EU membership
ggplot(rr, aes(ratio, growth)) +
  geom_point(color = "grey50", alpha = 3/4) +
  geom_smooth(color = "black", se = TRUE) +
  facet_grid(joined_eu ~ decade, scales = "free_x") +
  theme_linedraw() +
  labs(y = "GDP growth (%)", x = "debt-to-GDP ratio")

# have a nice day
