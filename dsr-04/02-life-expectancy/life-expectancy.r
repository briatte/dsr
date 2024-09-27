# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2024
# |____/|_____|__|__|
#
# Mapping life expectancy worldwide
#
# ============================= See README file for data sources and details ===

# required packages

library(sf)
library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: import the shapefile
# ------------------------------------------------------------------------------

geo <- sf::st_read("data/WB_countries_Admin0_lowres.geojson")

# ------------------------------------------------------------------------------
# Step 2: CRS projections and bounding boxes
# ------------------------------------------------------------------------------

# the data look like a data frame, but contain spatial geometries
glimpse(geo)

# world map, with land and country administrative borders
ggplot(geo) +
  geom_sf() +
  coord_sf(crs = 4326)

# the previous plot uses the standard WGS84 CRS projection
sf::st_crs("EPSG:4326")

# Denmark -- finding the 'bounding box' (min/max lat/lon coordinates)
#
filter(geo, NAME_EN == "Denmark") %>% 
  sf::st_bbox()

# Denmark -- manually defining the 'bounding box'
#
ggplot(filter(geo, NAME_EN == "Denmark")) +
  geom_sf() +
  coord_sf(ylim = c(54.6, 57.8), # y = latitude = horizontal
           xlim = c(8.1, 15.2))  # x = longitude = vertical

# U.S. -- default projection
#
ggplot(filter(geo, NAME_EN == "United States of America")) +
  geom_sf()

# U.S. -- Arctic Polar Stereographic projection
#
ggplot(filter(geo, NAME_EN == "United States of America") %>% 
         sf::st_transform(crs = "EPSG:3995")) +
  geom_sf()

# ------------------------------------------------------------------------------
# Step 3: import life expectancy
# ------------------------------------------------------------------------------

lexp <- readr::read_tsv("data/life-expectancy.tsv")
glimpse(lexp)

# sanity check: only one measure per country
stopifnot(!duplicated(lexp$country))

# merge to geographic data (after exploring the country codes a bit...)
d <- full_join(geo, lexp, by = c("WB_A3" = "iso3c"))

# ------------------------------------------------------------------------------
# Step 4: project onto choropleth map
# ------------------------------------------------------------------------------

# fiddling with many plot parameters to show how scales and themes work
ggplot(d, aes(fill = SP.DYN.LE00.IN)) +
  geom_sf() +
  coord_sf(crs = 4326) +
  # legend color, title and shape
  scale_fill_viridis_c("Years", guide = guide_legend()) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "#b3cee5"), # pale light blue
    legend.position = "bottom",
    legend.key.width = unit(1.5, "cm"),
    plot.title = element_text(face = "bold"),
    plot.margin = margin(1 ,1 , 1, 1, "cm")
  ) +
  labs(title = "Life expectancy at birth",
       subtitle = "Data: World Development Indicators, 2020")

# export with specific dimensions
ggsave("life-expectancy.png", width = 8, height = 4.5)

# kthxbye
