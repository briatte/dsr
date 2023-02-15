# Solution to EASY homework activity from Session 5
#
# Data: Our World in Data [1], World Bank Indicators [2]
# [1]: https://ourworldindata.org/grapher/covid-deaths-daily-vs-total-per-million
# [2]: https://data.worldbank.org/

library(tidyverse)
library(memberstates) # remotes::install_github("cjyetman/memberstates")

# COVID-19 deaths
f <- "data/covid-deaths-daily-vs-total-per-million.csv"
deaths <- read_csv(f, locale = locale(encoding = "latin1")) %>%
  filter(Date <= as.Date("2020-12-31")) %>%
  group_by(Entity) %>%
  filter(Date == max(Date)) %>%
  select(
    country = Entity,
    ccode = Code,
    date = Date,
    deaths = `Total confirmed deaths due to COVID-19 per million people`
  ) %>%
  mutate(log_deaths = log(deaths))

# population
f <- "data/API_SP.POP.TOTL_DS2_en_excel_v2_1926530.xls"
pop <- readxl::read_excel(f, skip = 2) %>%
  select(
    country = `Country Name`,
    ccode = `Country Code`,
    pop2019 = `2019`
  ) %>%
  mutate(log_pop = log(pop2019))

# GDP/capita
f <- "data/API_NY.GDP.PCAP.PP.KD_DS2_en_excel_v2_1930672.xls"
gdpc <- readxl::read_excel(f, skip = 2) %>%
  select(
    country = `Country Name`,
    ccode = `Country Code`,
    gdpc2019 = `2019`
  ) %>%
  mutate(log_gdpc = log(gdpc2019))

# merge data sources
wdi <- full_join(pop, gdpc, by = c("country", "ccode"))
d <- inner_join(deaths, wdi, by = "ccode")

# quick check
# View(d)

# identify OECD countries
oecd <- memberstates::memberstates$oecd$iso3c %>%
  countrycode::countrycode("iso3c", "wb")

d$oecd <- d$ccode %in% oecd

# something close enough to Deaton's Fig. 1
ggplot(d, aes(x = log_gdpc, y = log_deaths, color = oecd, size = pop2019)) +
  geom_text(
    data = filter(d, ccode %in% c("CHN", "IND")),
    aes(label = country.x, color = oecd),
    size = 5
  ) +
  geom_smooth(
    method = "lm", mapping = aes(color = NULL, weight = pop2019), se = F,
    lty = "dashed", size = 2/3
  ) +
  geom_point(shape = 1, stroke = 1) +
  scale_color_manual(values = c("TRUE" = "black", "FALSE" = "#aa0000")) +
  scale_size_continuous(range = c(2, 20)) +
  theme_light() +
  theme(legend.position = "none", panel.grid.minor = element_blank())

# kthxbye
