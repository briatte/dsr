# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2024
# |____/|_____|__|__|
#
# Cholera deaths in London, 1854 (John Snow)
#
# ============================= See README file for data sources and details ===

# required packages
library(tidyverse)

# read in the cholera deaths data
fatalities <- readr::read_csv("data/cholera-fatalities.csv")
fatalities

# how many deaths listed?
nrow(fatalities)

# read in the London streets data
streets <- readr::read_csv("data/cholera-streets.csv")
streets

# let's plot the streets
ggplot(data = streets, aes(x = x, y = y, group = street)) +
  geom_line(color = "grey50") +
  coord_equal()

# let's plot both the streets and the deaths
ggplot(data = fatalities, aes(x = x, y = y)) +
  geom_line(data = streets, aes(group = street), color = "grey50") +
  geom_point() +
  coord_equal()

# read in the water pumps data
pumps <- readr::read_csv("data/cholera-pumps.csv")

# let's plot the deaths, pumps and streets
plot <- ggplot(data = fatalities, aes(x = x, y = y)) +
  geom_line(data = streets, aes(group = street), color = "grey50") +
  geom_point() +
  geom_point(data = pumps, color = "darkred", size = 10, alpha = 1/2) +
  coord_equal()

plot

# add density curves, remove extra plot elements
plot +
  geom_density2d(bins = 7) +
  theme_void()

# kthxbye
