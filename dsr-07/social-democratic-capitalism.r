# ------------------------------------------------------------------------------
# Social democratic capitalism
#
# Replication of selected figures from Lane Kenworthy's book, illustrating
# linear (and nonlinear) correlation, and why linear correlation is not enough
# for petty much any form of analysis.
# ------------------------------------------------------------------------------

library(countrycode)
library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: understand linear correlation coefficients
# ------------------------------------------------------------------------------

# Fig. 2.5: relative poverty and welfare states, 2010-2016
fig25 <- readr::read_tsv("data/sdc-fig2.5.tsv")
head(fig25, 10)

# data preparation
fig25 <- fig25 %>% 
  mutate(
    iso3c = countrycode::countrycode(country, "country.name", "iso3c"),
    region = countrycode::countrycode(country, "country.name", "region"),
    nordic = str_detect(countryabbr_nordic, "\\*"),
    europe = str_detect(region, "^Europe"),
    location = case_when(
      nordic ~ "Nordic",
      europe ~ "Europe",
      TRUE ~ "World"
    )
  ) %>% 
  select(country, iso3c, region, europe, nordic, location,
         poverty = relativepoverty_2010to2016,
         welfare = publicsocexpends_1980to2015_adj2)

# distinguishing Nordic countries
ggplot(fig25, aes(y = poverty, x = welfare)) +
  geom_smooth(method = "lm") +
  geom_text(aes(label = iso3c, colour = nordic)) +
  scale_color_manual(values = c("TRUE" = "steelblue", "FALSE" = "black"))

# distinguishing Nordic and European countries
ggplot(fig25, aes(y = poverty, x = welfare)) +
  geom_smooth(method = "lm") +
  geom_text(aes(label = iso3c, colour = location)) +
  scale_color_brewer(palette = "Set1")

# Pearson correlation coefficients
cor(fig25$poverty, fig25$welfare)
with(fig25, cor(poverty, welfare)) # equivalent syntax

# correlations for subgroups
with(filter(fig25, !nordic), cor(poverty, welfare))
with(filter(fig25, location == "Europe"), cor(poverty, welfare))
with(filter(fig25, location != "World"), cor(poverty, welfare))

# note that in presence of missing data, you will need to use options to select
# between pairwise and listwise deletion; what we used above equates to this:
cor(fig25$poverty, fig25$welfare, use = "pairwise.complete.obs")

# ------------------------------------------------------------------------------
# Step 2: understand pairwise v. listwise case deletion
# ------------------------------------------------------------------------------

# Fig. 8.11: US Democratic party affiliation advantage by generation, 1972-2016
fig811 <- readr::read_tsv("data/sdc-fig8.11.tsv")
print(fig811, n = Inf)

# remove 'Democratic advantage' abbreviation from column names
fig811 <- rename_all(fig811, ~ str_remove(.x, "_dem_adv"))

# visualize the actual time series
ggplot(pivot_longer(fig811, -year, names_to = "generation") %>% 
         mutate(generation = str_remove(generation, "_dem_adv")),
       aes(year, value, colour = generation)) +
  geom_hline(yintercept = 0, lty = "dashed") +
  geom_point() +
  geom_smooth(method = "loess", se = FALSE)

# correlate all series
round(cor(fig811), 2)
round(cor(fig811, use = "pairwise"), 2) # pairwise case deletion
round(cor(fig811, use = "complete"), 2) # listwise case deletion

# ------------------------------------------------------------------------------
# Step 3: compare linear v. nonlinear trends
# ------------------------------------------------------------------------------

# Fig. 2.23: public social expenditure in Denmark, 1890-2016
fig223 <- readr::read_tsv("data/sdc-fig2.23.tsv")
  select(country, year, socex = publicsocexpends) %>% 
  drop_na(socex)

fig223
cor(fig223$year, fig223$socex)

# linear and nonlinear trends
ggplot(fig223, aes(year, socex)) +
  geom_point() +
  geom_smooth(method = "loess") +
  geom_smooth(method = "lm", se = FALSE, color = "black")

# separate years by historical period
fig223$period <- cut(fig223$year, c(1889, 1959, 1979, 2016), dig.lab = 4)
table(fig223$period)

# redraw, showing the periods
ggplot(fig223, aes(year, socex)) +
  geom_smooth(method = "loess", color = "black") +
  geom_point(aes(colour = period))

# 'local' correlations coefficients for each historical period
group_by(fig223, period) %>% 
  summarise(n = n(), rho = cor(year, socex))

# linear trends for each historical period
ggplot(fig223, aes(year, socex, colour = period)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, fullrange = TRUE) +
  geom_smooth(method = "loess", colour = "black") +
  scale_y_continuous(lim = c(0, 40))

# this last graph anticipates on linear regression, since the different slopes
# here are not correlation coefficients but linear regression coefficients

# no-intercept linear model
summary(lm(socex ~ year - 1, data = fig223))

# breakdown by historical period
group_by(fig223, period) %>% 
  # 'restart' year at 0 in each historical period
  mutate(year = year - min(year)) %>% 
  # coefficients of no-intercept linear models
  summarise(n = n(), beta = coef(lm(socex ~ year - 1)))

# kthxbye
