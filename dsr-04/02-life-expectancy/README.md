# README

__Data source for shapefiles:__ [World Bank Official Boundaries][owb].

[owb]: https://datacatalog.worldbank.org/search/dataset/0038272/World-Bank-Official-Boundaries

__Data source for life expectancy:__ World Bank [World Development Indicators][wdi].

[wdi]: https://databank.worldbank.org/source/world-development-indicators

The latter were retrieved with `WDI` (R package by Vincent Arel-Bundock):

```r
library(WDI)
WDI::WDI(country = "all", indicator = "SP.DYN.LE00.IN", latest = 1) %>% 
  write_tsv("data/life-expectancy.tsv")
```
