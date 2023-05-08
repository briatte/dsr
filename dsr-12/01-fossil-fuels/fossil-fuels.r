# ------------------------------------------------------------------------------
# Mapping support for fossil fuel taxation
#
# A more complex data visualization example that combines survey weighting and
# spatial interpolation.
# ------------------------------------------------------------------------------

library(gstat)
library(sf)
library(stars)
library(tidyverse)

# download NUTS shapefiles ------------------------------------------------

shp_link <- "https://gisco-services.ec.europa.eu/distribution/v2/nuts/shp/NUTS_RG_03M_2016_3035.shp.zip"
shp_file <- fs::path("data", fs::path_file(shp_link))

# download file if missing
if (!fs::file_exists(shp_file)) {
  download.file(shp_link, shp_file, mode = "wb", quiet = FALSE)
}

# identify shapefile within zipped archive
shp_file <- str_subset(unzip(shp_file, exdir = tempdir()), "NUTS_RG(.*)shp$")

# read (`st_read` will automatically identify the 'NUTS_RG_03M_2010' layer)
shp_data <- sf::st_read(dsn = shp_file)

# shapefile contents
head(shp_data, 4)

# contains NUTS levels 0 (countries) to 3 (smallest administrative units)
tail(shp_data, 4)

# read ESS survey extract -------------------------------------------------

ess <- readr::read_tsv("data/ESS8e02_2_extract.tsv")

# inctxff -- Favour increase taxes on fossil fuels to reduce climate change
# 1 = strongly in favour, 5 = strongly against
table(ess$inctxff)

# country-level averages
group_by(ess, cntry) %>%
  summarise(
    n = n(),
    n_na = sum(is.na(inctxff)),
    mean = 5 - mean(inctxff, na.rm = TRUE) # unweighted
  ) %>%
  arrange(-mean) %>%
  print(n = Inf) # higher mean = more support

# create survey object ----------------------------------------------------

ess_svy <- ess %>%
  srvyr::as_survey_design(
    ids = idno,     # clusters (respondents)
    strata = cntry, # sampling stratum (country)
    nest = TRUE,    # nest clusters within each stratum (see note)
    probs = pspwght # cluster sampling probabilities
  )

# NOTE: `nest = TRUE` required because `idno` repeats across countries and
# therefore does not uniquely identify respondents

# estimate proportion of variable of interest per European region
ess_stats <- ess_svy %>%
  group_by(cntry, region) %>%
  summarise(n = n(), mean = srvyr::survey_mean(5 - inctxff, na.rm = TRUE)) %>%
  mutate(mean_rse = mean_se / mean)

head(arrange(ess_stats, -mean)) # high support
tail(arrange(ess_stats, -mean)) # high opposition

# small areas and possible issues with large SEs
warning(sum(ess_stats$n < 50), " regions with n < 50 observations")
warning(sum(ess_stats$mean_rse > 0.3), " regions with high relative SEs")

# merge survey data and map data ------------------------------------------

map_data <- left_join(ess_stats, shp_data, by = c("region" = "NUTS_ID"))

# all ESS8 countries, using Lambert Azimuthal Equal Area projection
# https://epsg.io/3035
ggplot(map_data, aes(fill = mean)) +
  geom_sf(aes(geometry = geometry)) +
  scale_fill_viridis_b("%", option = "D") +
  coord_sf(crs = "EPSG:3035") +
  theme_void()

# France only, using Lambert-93 projection (suitable for metropolitan France)
# https://epsg.io/2154
ggplot(filter(map_data, str_detect(region, "FR")), aes(fill = mean)) +
  geom_sf(aes(geometry = geometry)) +
  scale_fill_viridis_b("%", option = "D") +
  coord_sf(crs = "EPSG:2154") +
  theme_void()

# crop and project --------------------------------------------------------

shp_europe <- filter(shp_data, NUTS_ID %in% unique(map_data$region)) %>%
  filter(NUTS_ID != "ES70") %>% # remove Canary Islands
  sf::st_transform("EPSG:3035")

# find centroids ----------------------------------------------------------

shp_centroids <- sf::st_centroid(shp_europe)

ggplot(shp_europe) +
  geom_sf() +
  geom_sf(data = shp_centroids) +
  theme_void()

# interpolate -------------------------------------------------------------

# add survey stats to centroids
shp_centroids <- shp_centroids %>%
  left_join(ess_stats, by = c("NUTS_ID" = "region"))

# create regular 10 km x 10 km grid over map
shp_grid <- sf::st_bbox(shp_europe) %>%
  stars::st_as_stars(dx = 10000) %>%
  sf::st_crop(shp_europe)

# inverse distance weighted interpolation
shp_idw <- gstat::idw(mean ~ 1, shp_centroids, shp_grid)
shp_idw # `var1.pred` is the interpolated result

# view final map
ggplot() +
  stars::geom_stars(data = shp_idw, aes(fill = var1.pred, x = x, y = y)) +
  geom_sf(data = sf::st_cast(shp_europe, "MULTILINESTRING")) +
  scale_fill_viridis_c("", option = "H", na.value = "white",
                       breaks = range(shp_idw$var1.pred, na.rm = TRUE),
                       labels = c("Oppose", "Support")) +
  theme_void() +
  theme(plot.background = element_rect(fill = "white", linewidth = NA)) +
  labs(
    title = "Increasing taxes taxes on fossil fuels to reduce climate change",
    subtitle = "Data: European Social Survey Round 8, 2016"
  )

# export as square image
ggsave("fossil-fuels.png", width = 2100, height = 2100, units = "px")

# kthxbye
