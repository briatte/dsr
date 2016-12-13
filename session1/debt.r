## A simple example of how to plot time series with ggplot2.
## 2016-12-13

# load packages
library(readr)   # functions provided: read_csv
library(ggplot2) # functions provided: ggplot, geom_line, facet_wrap

# load data
u = "http://www.stat.cmu.edu/~cshalizi/uADA/13/hw/11/debt.csv"
d = read_csv(u)

# help: how does read_csv operate?
# ?read_csv

# create a decade variable
d$decade = factor(10 * d$Year %/% 10)

# help: what does %/% stands for?
# ?`%/%`

# plot
ggplot(d, aes(y = growth, x = Year, color = decade)) + 
  geom_line() +
  facet_wrap(~ Country)

# help: how does ggplot work?
# ?ggplot

# kthxbye
