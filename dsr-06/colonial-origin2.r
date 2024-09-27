# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2024
# |____/|_____|__|__|
#
# Colonialism, democracy, life expectancy and wealth, Part 2
#
# An example inspired by research into the historical legacy of colonialism,
# using the Quality of Government cross-sectional dataset.
#
# N.B. Brush up on your introductory statistics course if you forgot all about
# association tests! The course readings will help you with that.
#
# ============================= See README file for data sources and details ===

# required packages

library(ggmosaic)
library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: import the dataset
# ------------------------------------------------------------------------------

# same data as last week, with an additional (geographic) `region` variable
d <- readr::read_tsv("data/qog2023-extract.tsv")

# data preparation, replicating the steps we took last week
d <- d %>% 
  mutate(
    former_colony = as.integer(ht_colonial != 0),
    democratic = factor(br_dem, labels = c("Nondemocratic", "Democratic")),
    log_gdpc = log(wdi_gdpcappppcur)
  )

# ------------------------------------------------------------------------------
# Step 2: cross-tabulation
# ------------------------------------------------------------------------------

# bar plot
ggplot(d, aes(x = democratic, fill = democratic)) +
  geom_bar() +
  facet_wrap(~ former_colony)

# mosaic plot
ggplot(d) +
  geom_mosaic(aes(product(democratic, former_colony), fill = democratic))

# note: `geom_mosaic` can take `na.rm = TRUE` if you do not need to visualize
# the missing values

# regime type by (conditional on) colonial origin
table(d$former_colony, d$democratic)
table(d$former_colony, d$democratic, exclude = NULL)

# let's save this (without missing values)
t <- table(d$former_colony, d$democratic)

# ... and look at percentages
prop.table(t)
round(100 * prop.table(t), 1)

prop.table(t, 1) # row percentages
prop.table(t, 2) # column percentages

# and finally, a Chi-squared test of the association
chisq.test(t)

# ... how did we get there?

# inspect again the relative frequencies of both variables
prop.table(table(d$democratic))
prop.table(table(d$former_colony))

chisq.test(t)$observed # this is what you observe in your data
chisq.test(t)$expected # this is what it would look like at random

# Pearson's residuals
chisq.test(t)$residuals

# Fisher's exact test also works for 2 x 2 count data
fisher.test(t)

# a proportions test would also work
prop.test(t)

# ------------------------------------------------------------------------------
# Step 3: comparison of means
# ------------------------------------------------------------------------------

# life expectancy by (conditional on) regime type
group_by(d, democratic) %>%
  summarise(
    n = n(),
    mean_le = mean(wdi_lifexp, na.rm = TRUE),
    sd_le   =   sd(wdi_lifexp, na.rm = TRUE)
  )

# or alternatively
tapply(d$wdi_lifexp, d$democratic, mean, na.rm = TRUE)
tapply(d$wdi_lifexp, d$democratic,   sd, na.rm = TRUE)

# visually (expanding on code included in our last workshop)
ggplot(drop_na(d, democratic), aes(x = wdi_lifexp)) +
  geom_density(aes(fill = democratic), alpha = 0.5) +
  geom_rug() +
  scale_fill_brewer("Regime", palette = "Set1") +
  facet_wrap(~ democratic, ncol = 1)

# now for a two-tailed test of the association
t.test(wdi_lifexp ~ democratic, data = d)

# the result is complex, so breaking it down might help
result <- t.test(wdi_lifexp ~ democratic, data = d)
str(result)

# difference in means
result$estimate
diff(result$estimate)

# t statistic
result$statistic
diff(result$estimate) / result$stderr

# null hypothesis significance test
result$conf.int
result$p.value
result$p.value < 0.05

# kthxbye
