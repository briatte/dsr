# ------------------------------------------------------------------------------
# Industrial disputes and parliamentary left seat shares, 1960-2010
#
# Data: Comparative Welfare States (CWS) dataset, 2020
# https://www.lisdatacenter.org/news-and-events/comparative-welfare-states-dataset-2020/
# ------------------------------------------------------------------------------

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
