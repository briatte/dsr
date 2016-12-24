## =============================================================================
## NEW YORK TIMES BREXIT COVERAGE
## =============================================================================

library(dplyr)   # data manipulation (group_by, summarise, mutate...)
library(ggplot2) # plots
library(readxl)  # read Excel format
library(tidyr)   # tidy data (gather, spread)

## =============================================================================
## DATA
## =============================================================================
##
## Source: Nives Dolsak and Aseem Prakash. 2016. "The New York Times' Coverage 
## of the Brexit Vote."
## URL: http://faculty.washington.edu/nives/replication_data.html

u = "https://faculty.washington.edu/nives/New_York_Times_Brexit_coverage.xlsx"
f = basename(u) # New_York_Times_Brexit_coverage.xlsx

if (!file.exists(f))
  download.file(u, f, mode = "wb")

# import data rectangle
d = read_excel(f, sheet = 1, skip = 12)[ 1:195, 1:4 ]

# rename variables
names(d) = c("date", "negative", "neutral", "positive")

# reshape to long format...
d = gather(d, tone, title, negative:positive) %>%
  na.omit # ... and remove missing values

table(d$tone)

## =============================================================================
## PLOT
## =============================================================================

ggplot(d, aes(x = date, fill = tone)) +
  geom_bar() # by default, the bars will be stacked and will represent counts

# show more dates on the x-axis
ggplot(d, aes(x = date, fill = tone)) +
  geom_bar() +
  scale_x_datetime(date_breaks = "3 days", date_labels = "%b %d")

ggplot(d, aes(x = date, fill = tone)) +
  geom_bar() +
  facet_wrap(~ tone, ncol = 1) # vertical small multiples

## =============================================================================
## AGGREGATE
## =============================================================================

group_by(d, date, tone) %>%
  summarise(n_articles = n()) %>%  # number of articles by day
  arrange(-n_articles) # sort by descending order

# same thing, shorter code
group_by(d, date, tone) %>%
  tally(sort = TRUE)

# how can we split the data to 'tone' columns?
# the code below works, but it is inefficient

# group_by(d, date) %>%
#   summarise(
#     n_neg = sum(tone == "negative"),
#     n_neu = sum(tone == "neutral"),
#     n_pos = sum(tone == "positive")
#   )

group_by(d, date, tone) %>%
  summarise(n_articles = n()) %>%
  spread(tone, n_articles, fill = 0) %>%
  mutate(ratio = as.integer(negative / positive))

# kthxbye
