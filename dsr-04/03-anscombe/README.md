# README

__Data source:__ [`datasets::anscombe`][anscombe], which cites Tufte (1989) as its source, and Anscombe (1973) as the initial source:

> Tufte, Edward R. (1989). _The Visual Display of Quantitative Information_, Graphics Press, pp. 13–14.

> Anscombe, Francis J. (1973). Graphs in statistical analysis. _The American Statistician_, 27, 17–21. [doi:10.2307/2682899](https://doi.org/10.2307/2682899).

[anscombe]: https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html

The R code to produce the 'tidy' version of the dataset was not preserved, but probably looked somewhat like this:

```r
library(tidyverse)
datasets::anscombe %>%
  tidyr::pivot_longer(everything()) %>%
  mutate(coord = str_sub(name, 1, 1), set = str_sub(name, 2, 2)) %>%
  select(-name, set, coord, value) %>%
  tidyr::pivot_wider(names_from = "coord", values_from = "value") %>%
  tidyr::unnest(everything()) %>%
  readr::write_tsv("data/anscombe.tsv")
```
