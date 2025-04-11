# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Spring 2025
# |____/|_____|__|__|
#
# Industrial disputes and left-wing seat shares (CWS 2020)
#
# ============================= See README file for data sources and details ===

# required packages
library(tidyverse)

# load data
cws <- readxl::read_excel("data/CWS-data-2020.xlsx")

# inspect all variables
glimpse(cws)

# inspect visually (uncomment next line and execute)
# View(cws)

# inspect selected variables
glimpse(select(cws, id, year, nld, leftseat))

# get the sample size (number of observations)
nrow(cws)

# count the values of a categorical variable
table(cws$id)

# summarise a continuous variable (parliamentary left seat shares)
summary(cws$leftseat)

# summarise a continuous variable (industrial disputes) by decade
filter(cws, !is.na(nld)) %>%
  mutate(decade = 10 * year %/% 10) %>%
  group_by(decade) %>%
  summarise(
    n = n(),
    mu = mean(nld, na.rm = TRUE),
    sd = sd(nld, na.rm = TRUE)
  )

# compute average industrial disputes and left seat shares by decade
by_decade <- filter(cws, !is.na(nld)) %>%
  mutate(decade = 10 * year %/% 10) %>%
  group_by(id, decade) %>%
  summarise(
    n = n(),
    nld = mean(nld, na.rm = TRUE),
    leftseat = mean(leftseat, na.rm = TRUE)
  )

# visualize linear relationships
ggplot(by_decade, aes(y = nld, x = leftseat)) +
  geom_smooth(method = "lm", fullrange = TRUE) +
  geom_text(aes(label = id, alpha = n)) +
  facet_wrap(~ decade, scales = "free")

# kthxbye
