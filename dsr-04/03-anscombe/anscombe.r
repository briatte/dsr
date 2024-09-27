# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2024
# |____/|_____|__|__|
#
# Anscombe's quartet
#
# ============================= See README file for data sources and details ===

# required packages

library(tidyverse)

# read Anscombe's quartet data
anscombe <- readr::read_tsv("data/anscombe.tsv")

# note how X and Y are similar!
group_by(anscombe, set) %>% 
  summarise(
    mu_x = mean(x),
    var_x = var(x),
    mu_x = mean(y),
    var_x = var(y)
  )

# note how X and Y are different!
ggplot(anscombe, aes(x, y)) +
  geom_point() + 
  facet_wrap(~ set)

# ------------------------------------------------------------------------------
# Fundamentals of the ggplot2 plotting system
# ------------------------------------------------------------------------------

# R has 'base graphics'...
plot(density(anscombe$x))

# ... but ggplot2 just looks better
ggplot(anscombe, aes(x)) +
  geom_density()

# 'Base graphics' will get you everywhere...
plot(anscombe$x, anscombe$y)

# ... but ggplot2 has a consistent syntax
ggplot(anscombe, aes(x, y)) +
  geom_point()

# ggplot2 can modify the 'appearance' of your data points...
ggplot(anscombe, aes(x, y)) +
  geom_point(size = 5, color = "tomato", fill = "gold", shape = 21)

# ... but what you really want to modify is their 'aesthetics'
ggplot(anscombe, aes(x, y, color = factor(set))) +
  geom_point()

## see how this won't work properly, and understand why

# ggplot(anscombe, aes(x, y, color = set)) +
#   geom_point()

# let's go back to using facets (small multiples)
ggplot(anscombe, aes(x, y)) +
  geom_point() + 
  facet_wrap(~ set, nrow = 1) +
  coord_equal()

# and let's finally add another geometry
ggplot(anscombe, aes(x, y)) +
  geom_point() + 
  geom_smooth(method = "lm", fill = NA, fullrange = TRUE) + 
  facet_wrap(~ set)

## try removing `geom_smooth` options to see what happens

# have a nice day
