# README

__Data source:__ Lane Kenworthy, _[Social Democratic Capitalism][kenworthy20]_, Oxford University Press, 2020.

[kenworthy20]: https://lanekenworthy.net/cv/

## R code to generate the `sdc-*` datasets

The data come directly from Lane Kenworthy's website, where it is available [as an Excel spreadsheet][src] with many tabs.

[src]: https://lanekenworthy.files.wordpress.com/2019/10/sdc-data.xlsx

```r
# Example 1 -- Fig. 2.5
readxl::read_excel("data/sdc-data.xlsx", sheet = "Fig 2.5") %>% 
  write_tsv("data/sdc-fig2.5.tsv")

# Example 2 -- Fig. 8.11
readxl::read_excel("data/sdc-data.xlsx", sheet = "Fig 8.11") %>% 
  write_tsv("data/sdc-fig8.11.tsv")

# Example 3 -- Fig. 2.23
readxl::read_excel("data/sdc-data.xlsx", sheet = "Fig 2.23") %>% 
  write_tsv("data/sdc-fig2.23.tsv")
```

Unfortunately, the code to replicate either the actual figures of the book, or the data aggregations that underlie many of the plotted series, is not available. The data sources are well detailed in the book, however.
