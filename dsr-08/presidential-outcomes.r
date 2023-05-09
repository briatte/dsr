# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2023
# |____/|_____|__|__|
#
# U.S. presidential election outcomes and income growth (Bartels)
#
# An example of how to model electoral performance from just two political
# fundamentals: economic growth and time in office.
#
# ============================= See README file for data sources and details ===

# required packages

library(broom)       # model summaries
library(ggrepel)
library(performance) # model performance
library(tidyverse)
library(texreg)      # regression tables

# set global {ggplot2} theme for all plots
theme_set(theme_linedraw())

# ------------------------------------------------------------------------------
# Step 1: import the dataset
# ------------------------------------------------------------------------------

# data shared by Larry Bartels (thanks)
d <- readr::read_csv("data/bartels4812.csv")

glimpse(d)

p <- readr::read_csv("data/presidents4820.csv")

glimpse(p)

d <- left_join(d, p, by = "year") %>% 
  mutate(
    incumbent = as.logical(incumbent),
    incumbent = if_else(incumbent, president, challenger)
  )

# linear fit
ggplot(d, aes(inc1415, incm)) +
  geom_hline(yintercept = 0, lty = "dashed") +
  geom_smooth(method = "lm") +
  geom_point() +
  geom_text(aes(label = str_c(incumbent, "\n", year))) +
  labs(
    y = "Incumbent party popular vote margin (%)",
    x = "Q14/Q15 growth in real disposable income per capita (%)"
  ) +
  theme_linedraw()

# visual explanation
ggplot(broom::augment(lm(incm ~ inc1415, data = d), newdata = d), 
       aes(inc1415, incm)) +
  geom_rug() +
  # regression line
  # geom_abline(intercept = coef(M1)[1], slope = coef(M1)[2]) +
  geom_smooth(method = "lm", fill = "steelblue", alpha = 1/4) +
  # residuals
  geom_segment(
    aes(y = .fitted, yend = incm, xend = inc1415, color = .resid > 0),
    lty = "dashed"
  ) +
  # fitted values
  geom_point(aes(y = .fitted, x = inc1415), color = "steelblue") +
  # data points
  geom_point() +
  ggrepel::geom_text_repel(aes(label = str_c(incumbent, "\n", year))) +
  scale_color_brewer(palette = "Set1") +
  labs(
    y = "Incumbent party popular vote margin (%)",
    x = "Q14/Q15 growth in real disposable income per capita (%)"
  )

# ------------------------------------------------------------------------------
# Step 2: simple linear regression
# ------------------------------------------------------------------------------

M1 <- lm(incm ~ inc1415, data = d)
summary(M1)

# model objects contain many, many results
str(M1)

# default extraction methods (1) parameters and uncertainty
coef(M1)
confint(M1)

# ... or, with the {texreg} package
texreg::screenreg(M1)
texreg::screenreg(M1, ci.force = TRUE) # with confidence intervals

# ... or, with the {broom} package

# coefficients and standard errors
broom::tidy(M1)    
broom::tidy(M1, conf.int = TRUE) # with confidence intervals

# goodness-of-fit, e.g. R-squared, RMSE (sigma), BIC
broom::glance(M1)

# default extraction methods (2) predicted values and residuals
fitted(M1)
residuals(M1)

# ... or, with the `broom` package

broom::augment(M1)
broom::augment(M1, newdata = d) # original data + fitted values + residuals
broom::augment(M1, data = d)    # original data + additional model results

# Note -- the latter function requires that the data frame passed to the `data`
# argument has exactly the same number of rows as the one used by the model.
# This means that in the presence of missing values, the dataset should first
# be trimmed of observations that were not included in the model.

# ------------------------------------------------------------------------------
# Step 3: regression diagnostics
# ------------------------------------------------------------------------------

# distribution of residuals
hist(resid(M1))
plot(density(residuals(M1)))

# ... or, with the {ggplot2} package
ggplot(broom::augment(M1), aes(x = .resid)) +
  geom_rug(aes(x = .resid)) +
  geom_density(aes(x = .resid))

# residuals-versus-fitted values
plot(fitted(M1), residuals(M1))

# ... or, with the {ggplot2} package
ggplot(broom::augment(M1, newdata = d)) +
  geom_text(aes(y = .resid, x = .fitted, label = year)) +
  geom_hline(yintercept = 0, lty = "dashed")

# ------------------------------------------------------------------------------
# Step 4: multiple linear regression
# ------------------------------------------------------------------------------

M2 <- lm(incm ~ inc1415 + tenure, data = d)
summary(M2)

M3 <- lm(incm ~ inc1415 + tenure + unelected, data = d)
summary(M3)

# compare to simple model
texreg::screenreg(list(M1, M2, M3))

# coefficients plot for Model 2
ggplot(filter(broom::tidy(M2), term != "(Intercept)")) +
  geom_pointrange(
    aes(
      x = term,
      y = estimate,
      ymin = estimate - 1.96 * std.error,
      ymax = estimate + 1.96 * std.error
    )
  ) +
  geom_hline(yintercept = 0, lty = "dashed") +
  coord_flip() # invert y/x axes

# coefficients plot for all models
ggplot(map_dfr(list(M1, M2, M3), broom::tidy, .id = "model") %>% 
         mutate(model = str_c("M", model)) %>% 
         filter(term != "(Intercept)")) +
  geom_pointrange(
    aes(
      x = term,
      y = estimate,
      ymin = estimate - 1.96 * std.error,
      ymax = estimate + 1.96 * std.error,
      color = model
    ),
    position = position_dodge(width = 0.5)
  ) +
  geom_hline(yintercept = 0, lty = "dashed") +
  coord_flip() # invert y/x axes

# compare residuals
ggplot() +
  geom_density(aes(x = resid(M1), fill = "M1", color = "M1"), alpha = 1/3) +
  geom_density(aes(x = resid(M2), fill = "M2", color = "M2"), alpha = 1/3) +
  geom_density(aes(x = resid(M3), fill = "M3", color = "M3"), alpha = 1/3) +
  scale_color_discrete("Model") +
  scale_fill_discrete("Model")

# compute tenure-adjusted effect of real disposable income
d$inc1415_adjusted <- d$inc1415 + coef(M2)[ "tenure" ] * d$tenure / 4

# replicate Larry Bartels' Monkey Cage figure (with correct adjustment)
ggplot(d, aes(inc1415_adjusted, incm)) +
  geom_hline(yintercept = 0, lty = "dashed") +
  geom_smooth(method = "lm") +
  geom_point() +
  geom_text(aes(label = str_c(incumbent, "\n", year))) +
  labs(y = "Incumbent party popular vote margin (%)",
       x = str_c("Tenure-adjusted (-1.76 per term) Q14/Q15 growth", "\n",
                 "in real disposable income per capita (%)")) +
  theme_linedraw()

# ------------------------------------------------------------------------------
# Step 5: further model diagnostics
# ------------------------------------------------------------------------------

# model performance, using the `performance` package
performance::model_performance(M2)
performance::compare_performance(M1, M2, metrics = "common")

# diagnose possible model issues (equivalent to the `car::vif` function)
performance::check_collinearity(M2)
performance::check_heteroscedasticity(M2)
performance::check_outliers(M2)

# ... or, for even more diagnostics plots (requires installing extra packages)
# install.packages(c("see", "patchwork"))
performance::check_model(M2)

# kthxbye
