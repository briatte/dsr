## =============================================================================
## FATAL ATTACKS ON JOURNALISTS
## =============================================================================

library(countrycode) # country names/codes
library(dplyr)       # data manipulation  (group_by, summarise, mutate...)
library(ggplot2)     # plots
library(lubridate)   # date manipulation
library(readxl)      # read Excel format
library(stringr)     # string manipulation

## =============================================================================
## DATA
## =============================================================================
##
## Source: Committee to Protect Journalists. 2016. "[Journalists] Deaths by Type
## Worldwide Since 1992."
## URL: https://www.cpj.org/killed/

u = "https://www.cpj.org/killed/cpj-database.xls"
f = basename(u) # New_York_Times_Brexit_coverage.xlsx

if (!file.exists(f))
  download.file(u, f, mode = "wb")

# import data rectangle
d = read_excel(f, sheet = 1, skip = 1) %>%
  filter(!is.na(Date))

# rename variables
names(d) = str_to_lower(names(d)) %>%
  str_replace_all("\\s", "_")

glimpse(d)

## =============================================================================
## PARSE DATES
## =============================================================================

# see ?parse_date_time for %date symbols
d$ymd = parse_date_time(d$date, "%b %d, %y")

# # inspect failed conversions
# filter(d, is.na(ymd)) %>%
#   select(date, ymd) %>%
#   View

d$year = year(d$ymd)

table(d$month, exclude = NULL)

# # inspect (failed | suspicious) conversions
# filter(d, is.na(year) | year < 1992) %>%
#   select(date, ymd, year) %>%
#   View

# different strategy: extract years
d$year = str_extract(d$date, "\\d{4}")

table(d$year, exclude = NULL)

# different strategy: extract months
m = month(1:12, label = TRUE, abbr = FALSE) %>%
  as.character

d$month = str_extract(d$date, str_c(m, collapse = "|")) %>%
  factor(levels = m) %>%
  as.integer # months as single or double digits (1, 2, ..., 11, 12)

table(d$month, exclude = NULL)

# # inspect suspicious cases
# filter(d, month != month(ymd, label = FALSE)) %>%
#   select(date, month) %>%
#   View

# different strategy, end: dates at year-month precision
d$ym = str_c(d$month, d$year, sep = " ") %>%
  parse_date_time(orders = "%m %y")

table(d$ym, exclude = NULL)

# # inspect suspicious cases
# filter(d, is.na(ym)) %>%
#   select(date, year, month) %>%
#   View

## =============================================================================
## PARSE COUNTRIES
## =============================================================================

d$cty = countrycode(
  d$country_killed, 
  origin = "country.name", # source format: 'raw' country names
  destination = "iso3c"    # destination: ISO-3C abbrevations (e.g. IRQ)
)

n_distinct(d$cty) # number of different countries

# # inspect (failed | missing) conversions cases
# filter(d, is.na(cty)) %>%
#   select(date, country_killed) %>%
#   View

# countrycode can also get the continent or region...
table(countrycode(d$cty, "iso3c", "continent"), exclude = NULL)
table(countrycode(d$cty, "iso3c", "region"), exclude = NULL)

# ... but Yougoslavia will be missing from the results
table(d$cty[ is.na(countrycode(d$cty, "iso3c", "continent")) ], exclude = NULL)
table(d$cty[ is.na(countrycode(d$cty, "iso3c", "region")) ], exclude = NULL)

## =============================================================================
## AGGREGATE
## =============================================================================

group_by(d, cty) %>%
  summarise(n_killed = n()) %>%  # number of deaths by country
  arrange(-n_killed) # sort by descending order

# same thing, shorter code
group_by(d, cty) %>%
  tally(sort = TRUE)

group_by(d, cty, year) %>%
  summarise(n_killed = n()) %>%  # number of deaths by country-year
  arrange(-n_killed) # sort by descending order

# same thing, shorter code
group_by(d, cty, year) %>%
  tally(sort = TRUE)

# countries with 15+ journalists killed in the same year
group_by(d, cty, year) %>%
  tally(sort = TRUE) %>%
  filter(n >= 15)
