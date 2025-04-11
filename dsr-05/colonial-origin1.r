# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Spring 2025
# |____/|_____|__|__|
#
# Colonialism, democracy, life expectancy and wealth, Part 1
#
# An example inspired by research into the historical legacy of colonialism,
# using the Quality of Government cross-sectional dataset.
#
# N.B. This script also includes some more advanced data manipulation code that
# illustrates (1) how to handle labelled variables imported from Stata or SPSS
# datasets, and (2) how to create factor variables. You might need to read from
# your handbooks to make sure that you understand how factor variables work.
#
# ============================= See README file for data sources and details ===

# required packages

library(haven)   # functions for working with Stata datasets
library(MASS)    # functions for fitting distributions
library(moments) # functions for skewness and kurtosis
library(tidyverse)

# library(e1071) # more functions for skewness and kurtosis (optional)

# ------------------------------------------------------------------------------
# Step 1: import the dataset
# ------------------------------------------------------------------------------

d <- haven::read_dta("data/qog_std_cs_jan23_stata14.dta")

# inspect the result
glimpse(d)

# inspect the result (first 10 columns/variables)
glimpse(d[, 1:10 ])

nrow(d) # sample size

# this is a very large dataset with dozens of variables, but it comes with
# excellent documentation: make sure to refer to the codebook when relevant

# also note that thanks to the dataset having been imported in Stata format,
# some of its variables have labels, as is the case for colonial origin:
table(d$ht_colonial)

# the variable is numerically encoded, but the values carry labels for ease of
# use when coding; values are also listed in the codebook, with more details
haven::print_labels(d$ht_colonial)

# the easiest way to access those labels is to convert the variable into a
# factor variable, which is a variable type that you should have read about in
# your handbooks:
head(haven::as_factor(d$ht_colonial), 9) # first 9 observations/values
levels(haven::as_factor(d$ht_colonial))  # levels of the factor variable

# ------------------------------------------------------------------------------
# Step 2: describe life expectancy
# ------------------------------------------------------------------------------

# summarize a continuous variable
summary(d$wdi_lifexp)

sum(is.na(d$wdi_lifexp))  # number of missing values
sum(!is.na(d$wdi_lifexp)) # number of nonmissing observations

# the missing values will force us to use `na.rm = TRUE` in other functions to
# obtain summary statistics, such as the function to obtain quantiles:
quantile(d$wdi_lifexp, na.rm = TRUE)

# without that argument, missing values will propagate and the result of those
# functions will itself be a missing value
median(d$wdi_lifexp)
median(d$wdi_lifexp, na.rm = TRUE)

# other measures of dispersion
range(d$wdi_lifexp, na.rm = TRUE)
var(d$wdi_lifexp, na.rm = TRUE)
sd(d$wdi_lifexp, na.rm = TRUE)

# histogram
ggplot(d, aes(x = wdi_lifexp)) +
  geom_histogram(bins = 10, color = "white")

# density curve
ggplot(d, aes(x = wdi_lifexp)) +
  geom_density()

# cumulative distribution
ggplot(d, aes(y = wdi_lifexp)) +
  geom_step(stat = "ecdf") + # empirical cumulative distribution function
  labs(x = "percentile")

# ------------------------------------------------------------------------------
# Step 3: describe regime type
# ------------------------------------------------------------------------------

# summarise a categorical (dummy) variable
table(d$br_dem, exclude = NULL)

# percentage of democratic countries (excluding missing values)
prop.table(table(d$br_dem))

# same result, expressed as the mean of the variable
mean(d$br_dem, na.rm = TRUE)

# the variable can be made more explicit by converting it to a factor, and by
# giving names (labels) to its levels (0/1)
d$democratic <- factor(d$br_dem, labels = c("Nondemocratic", "Democratic"))
str(d$democratic)
levels(d$democratic) # level 1 = former value 0, level 2 = former value 1

# again, refer to your handbook readings to make sure that you understand how
# to handle factors, as they will be useful at later stages of analysis

# ------------------------------------------------------------------------------
# Step 4: describe colonial origin
# ------------------------------------------------------------------------------

# check for missing values
table(d$ht_colonial, exclude = NULL)

# remind yourself of the coding
haven::print_labels(d$ht_colonial)

# show the value labels and their counts (i.e. raw/absolute frequencies)
count(d, haven::as_factor(ht_colonial))

# add percentages (i.e. relative frequencies)
count(d, haven::as_factor(ht_colonial)) %>% 
  mutate(percent = 100 * n / sum(n))

# let's recode the variable as a dummy through various methods
d$former_colony1 <- d$ht_colonial != 0
d$former_colony2 <- as.integer(d$ht_colonial != 0)
d$former_colony3 <- if_else(d$ht_colonial == 0, "No", "Yes")

table(d$former_colony1, exclude = NULL) # logical
table(d$former_colony2, exclude = NULL) # integer (numeric)
table(d$former_colony3, exclude = NULL) # character

# percentage of formerly colonized countries
prop.table(table(d$former_colony1, exclude = NULL))

# ... or better, using `dplyr::count` as shown earlier
count(d, former_colony1) %>% 
  mutate(percent = 100 * n / sum(n))

# next, a (lowly informative) bar plot of the frequencies of that variable
ggplot(d, aes(x = former_colony1)) +
  geom_bar()

# ... or better, percentages, using `dplyr::count` as shown earlier
count(d, former_colony1) %>% 
  mutate(percent = 100 * n / sum(n)) %>% 
  ggplot(aes(x = former_colony1, y = percent)) +
  geom_bar(stat = "identity")

# and last, another example of creating a factor variable
d$former_colony <- factor(d$ht_colonial != 0)
str(d$former_colony)
levels(d$former_colony) <- c("Never colonized", "Former colony")

# final result
table(d$former_colony, exclude = NULL)

# ... or as percentages, using base R
round(100 * prop.table(table(d$former_colony)), 2)

# ------------------------------------------------------------------------------
# Step 5: normality assessment and logarithmic transformations
# ------------------------------------------------------------------------------

# distribution of GDP/capita
ggplot(d, aes(x = wdi_gdpcappppcur)) +
  geom_density() +
  geom_rug()

# this variable is very unevenly distributed, with many outliers, which are
# easier to spot when the data are broken down by geographic region:
ggplot(d, aes(x = wdi_gdpcappppcur)) +
  geom_boxplot(aes(y = haven::as_factor(ht_region)))

# normality assessment (numerical)
moments::skewness(d$wdi_gdpcappppcur, na.rm = TRUE)
moments::kurtosis(d$wdi_gdpcappppcur, na.rm = TRUE)

# note that there are multiple ways of computing the statistics above, as shown
# by the functions of the {e1071} functions package, which each provide three
# different methods:
#
# `moments::skewness` matches `type = 1`
# map(1:3, ~ e1071::skewness(d$wdi_gdpcappppcur, na.rm = TRUE, type = .x))
#
# `moments::kurtosis` (Pearson's measure) differs from all methods below
# map(1:3, ~ e1071::kurtosis(d$wdi_gdpcappppcur, na.rm = TRUE, type = .x))

# at that stage, it makes sense to look for a transformation of the unit of
# measurement of the variable, in order to better approach normality; the most
# obvious candidate is often logarithmic units:
d$log_gdpc <- log(d$wdi_gdpcappppcur)

# the improvement will be visually obvious
ggplot(d, aes(x = log_gdpc)) +
  geom_density()

# also showing an over-imposed normal distribution
fitted_normal <- MASS::fitdistr(na.omit(d$log_gdpc), "normal")$estimate
ggplot(d, aes(x = log_gdpc)) +
  geom_density() +
  stat_function(
    fun = dnorm,
    args = list(mean = fitted_normal[ "mean" ], sd = fitted_normal[ "sd" ]),
    color = "red"
  )

# ------------------------------------------------------------------------------
# Step 6: confidence intervals and standard errors
# ------------------------------------------------------------------------------

# why bother with normality? because when a variable is close enough to being
# normally distributed, the properties of the normal distribution will enable
# us to compute confidence bounds around its mean (or proportion), through
# hypothesis tests such as the t-test:
t.test(d$wdi_lifexp)$conf.int

# the result above is not a t-test so to speak: it only shows the '95% CI'
# (confidence interval) for life expectancy, under the assumption that our data
# form a random sample of all life expectancy values, and therefore, that its
# missing values are missing at random

# the computation of the interval uses the mean of the variable, its standard
# deviation, and the sample size, which are used to compute the standard error
# of the mean (the 'margin of error' of average life expectancy):
t.test(d$wdi_lifexp)$stderr

# (there are more formal ways than those above to compute confidence intervals
# and standard errors in R, which will provide very slightly different results,
# but 'hacking' the `t.test` function is arguably the quickest way to do so)

# confidence intervals and hypothesis tests are everywhere in statistics; for
# instance, there are statistical tests for whether a variable is normally
# distributed with regards to its skewness and kurtosis:
#
# moments::agostino.test(d$log_gdpc) # test of skewness
# moments::anscombe.test(d$log_gdpc) # test of kurtosis

# the overall logic of hypothesis testing is on the menu for next week, and we
# might, later on, go deep enough in survey analysis to explore confidence
# intervals and standard errors with survey-weighted data

# kthxbye
