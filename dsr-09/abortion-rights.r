# ------------------------------------------------------------------------------
# Opposition to abortion in Canada, 2021
#
# An example of how to model binary responses, a.k.a. probabilities.
# ------------------------------------------------------------------------------

library(broom)       # model summaries
library(ggeffects)   # predicted probabilities
library(ggmosaic)
library(performance) # model performance
library(tidyverse)
library(texreg)      # regression tables

# ------------------------------------------------------------------------------
# Step 1: import the dataset
# ------------------------------------------------------------------------------

ces <- readr::read_tsv("data/ces21-extract.tsv") %>%
  mutate(
    education = factor(
      education,
      levels = c("Less than HS", "HS", "Some PS", "College", "BA", "MA+")
    ),
    religion = factor(
      religion,
      levels = c("Not important at all", "Not very important",
                 "Somewhat important", "Very important")
    )
  )

glimpse(ces)

# dependent variable
prop.table(table(ces$ban_abortion))

# categorical predictor: education
count(ces, education) %>%
  mutate(prop = n / sum(n))

with(ces, round(prop.table(table(education, ban_abortion), 1), 2)) # row %

# categorical predictor: religion
count(ces, religion) %>%
  mutate(prop = n / sum(n))

with(ces, round(prop.table(table(religion, ban_abortion), 1), 2)) # row %

# same result, graphically
ggplot(ces) +
  geom_mosaic(aes(product(ban_abortion, religion), fill = ban_abortion),
              na.rm = TRUE) +
  scale_fill_manual(values = c("0" = "grey75", "1" = "grey25")) +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

# ------------------------------------------------------------------------------
# Step 2: fit linear probability models
# ------------------------------------------------------------------------------

lpm0 <- lm(ban_abortion ~ age, data = ces)
summary(lpm0)

lpm1 <- lm(ban_abortion ~ age + female + urban + education, data = ces)
summary(lpm1)

# spot the issue by inspecting residuals
ggplot(data = NULL, aes(x = resid(lpm1))) +
  geom_histogram()

# understand why the residuals are distributed that way
broom::augment(lpm1, newdata = ces) %>%
  drop_na(ban_abortion) %>%
  select(respid, ban_abortion, .fitted, .resid) %>%
  sample_n(10)

# ------------------------------------------------------------------------------
# Step 3: fit generalized linear models
# ------------------------------------------------------------------------------

# 'null model' (intercept-only)
m0 <- glm(ban_abortion ~ 1, data = ces, family = binomial(link = "logit"))
summary(m0)

# reverse the log-odds transformation
exp(coef(m0)) / (1 + exp(coef(m0)))
prop.table(table(ces$ban_abortion))

# logistic regression model 1
m1 <- glm(
  ban_abortion ~ age + female + urban + education,
  data = ces,
  family = binomial(link = "logit")
)

# logistic regression model 2
m2 <- glm(
  ban_abortion ~ age + female + urban + education + religion,
  data = ces,
  family = binomial(link = "logit")
)

# compare results
texreg::screenreg(list(m0, m1, m2))

# exponentiate Model 2 coefficients to read log-odds
broom::tidy(m2, exponentiate = TRUE)

# predicted probability of Pr ( ban abortion = Yes )
p <- predict(m2, type = "response", newdata = ces)
summary(p)
# prediction success, using p = 0.5 (confusion table)
(t <- table(ces$ban_abortion, p > 0.5, exclude = NULL))
# model accuracy at the 0.5 threshold
100 * sum(diag(t)) / sum(t)

# another way to obtain and visualize predicted probabilities
ggplot(
  broom::augment(m2, newdata = ces, type.predict = "response"),
  aes(y = ban_abortion, x = religion)
) +
  geom_jitter(aes(color = .fitted > 0.5), alpha = 1/3, height = 0.1) +
  scale_y_continuous(breaks = c(0, 0.5, 1), labels = c("0 (N)", 0.5, "1 (Y)"))

# regression diagnostics (compare to those of linear models)
performance::check_collinearity(m2)
performance::check_heteroscedasticity(m2)

# ------------------------------------------------------------------------------
# Step 4: interact gender and urban residency
# ------------------------------------------------------------------------------

m3 <- glm(
  ban_abortion ~ age + female * urban + education + religion,
  data = ces,
  family = binomial
)

m4 <- glm(
  ban_abortion ~ age + female:urban + education + religion,
  data = ces,
  family = binomial
)

texreg::screenreg(list(m2, m3, m4))

# ------------------------------------------------------------------------------
# Step 5: plot predicted probabilities
# ------------------------------------------------------------------------------

# predicted probabilities
ggeffects::ggpredict(m2, ~ female + education)

# average marginal effects (AMEs)
ggeffects::ggeffect(m2, terms = ~ female + education)

# visualize the AMEs
ggeffects::ggeffect(m2, terms = ~ education + religion)  %>%
  plot()

# kthxbye
