# README

__Data source:__ [`datasets::anscombe`][anscombe] (R package by the R Core Team), which cites Tufte (1989) as its source, and Anscombe (1973) as the initial source:

> Tufte, Edward R. (1989). _The Visual Display of Quantitative Information_, Graphics Press, pp. 13–14.

> Anscombe, Francis J. (1973). Graphs in statistical analysis. _The American Statistician_, 27, 17–21. [doi:10.2307/2682899](https://doi.org/10.2307/2682899).

[anscombe]: https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html

The R code to produce the ‘tidy’ version of the dataset was not preserved, but probably looked somewhat like this:

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

## Rationale #1: plotting systems

The point of this demo is to show you the existence of [different plotting systems][peng1] in R. We cover only the `ggplot2` one in class, called so in reference to the ‘grammar of graphics’ logic that it follows, but there are at least two other systems:

- The ['base'][peng2] system, which comes with R.
- The ['lattice'][lattice] system, provided by the `lattice` package.

[peng1]: https://bookdown.org/rdpeng/exdata/plotting-systems.html
[peng2]: https://bookdown.org/rdpeng/exdata/the-base-plotting-system-1.html
[lattice]: https://jtr13.github.io/cc21fall1/introduction-to-the-lattice-package.html

You'll be fine learning just the `ggplot2` one, which has also been ported to the Python language.

## Rationale #2: Anscombe's quartet

There is also a reason why I am including the 'Anscombe quartet' in this course. Read this article about it: ‘[What This Graph of a Dinosaur Can Teach Us about Doing Better Science][murtagh].’

[murtagh]: https://www.scientificamerican.com/article/what-this-graph-of-a-dinosaur-can-teach-us-about-doing-better-science/
