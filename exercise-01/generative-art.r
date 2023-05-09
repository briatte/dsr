# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2023
# |____/|_____|__|__|
#
# Generative aRt
#
# ============================= See README file for data sources and details ===

# required packages

# install.packages("tidyverse")
library(tidyverse)

# Source (slightly tweaked):
# https://twitter.com/aschinchon/status/1614707026415820800

seq(from = -5, to = 10, by = 0.05) %>%
  expand.grid(x = ., y = .) %>%
  ggplot(aes(x = (x + pi * sin(y)), y = (y + pi * sin(x)))) +
  geom_point(alpha = .1, shape = 20, size = 1, color = "darkred")+
  coord_polar() +
  theme_void()

# Source (very slightly tweaked):
# https://twitter.com/aschinchon/status/1615090579528118272

seq(1, 200, .0005) %>%
  tibble(x = exp(-0.006 * .) * sin(. * 3.01 + 1.68) + sin(. * 2.96 + 2.72),
         y = exp(-0.009 * .) * sin(. * 3.03 + 1.23) + sin(. * 2.98 + 1.28)) %>%
  ggplot(aes(x, y)) +
  geom_path(linewidth = 1/3, color = "steelblue")+
  coord_equal() +
  theme_void()

# more on Twitter: #rstats #generativeart
# kthxbye
