# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2023
# |____/|_____|__|__|
#
# Protein consumption in European countries, 1973
#
# ============================= See README file for data sources and details ===

# required packages (yes, there are a lot)

library(car)
library(corrr)
library(factoextra)
library(ggcorrplot)
library(ggfortify)
library(plotly)
library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: import the data
# ------------------------------------------------------------------------------

d <- read_tsv("data/protein.txt") %>%
  rename(FrVeg = `Fr&Veg`)

print(d, n = 15)

# distributions
pivot_longer(d, -Country) %>%
  ggplot(aes(x = value)) +
  geom_density() +
  geom_rug() +
  facet_wrap(~ name, scales = "free")

# raw values
pivot_longer(d, -Country) %>%
  ggplot(aes(x = name, y = Country, fill = value)) +
  geom_tile() +
  scale_fill_viridis_b()

# ------------------------------------------------------------------------------
# Step 2: correlations
# ------------------------------------------------------------------------------

# scatterplot matrix
car::scatterplotMatrix(select(d, -Country), smooth = FALSE)

# pairwise correlations
cor(select(d, -Country), use = "pairwise.complete.obs")

# same result as a tidy data frame
r <- corrr::correlate(select(d, -Country))
corrr::fashion(r, decimals = 1)

# strong correlations to red meat
filter(r, abs(RedMeat) > .5) %>%
  select(term, RedMeat)

# rearrange correlation matrix (uses PCA in the background)
corrr::rearrange(r, absolute = FALSE) %>%
  corrr::shave()

# heatmap
select(d, -Country) %>%
  cor() %>%
  ggcorrplot::ggcorrplot() +
  scale_fill_viridis_b()

# correlation network
corrr::network_plot(r, curved = FALSE)

# ------------------------------------------------------------------------------
# Step 3: hierarchical clustering
# ------------------------------------------------------------------------------

# rescale the features
rescaled_d <- select(d, -Country) %>%
  scale()

# add country names on rows
rownames(rescaled_d) <- d$Country
rescaled_d

# get Euclidean distances
distance_m <- dist(rescaled_d, method = "euclidean")
distance_m

# hierarchical clustering
clusters_d <- hclust(distance_m, method = "ward.D")
clusters_d
str(clusters_d)

# dendrogram with k = 2 clusters
factoextra::fviz_dend(clusters_d, k = 2, rect = TRUE)

# dendrogram with k = 3 clusters
factoextra::fviz_dend(clusters_d, k = 3, rect = TRUE)

# dendrogram with k = 4 clusters
factoextra::fviz_dend(clusters_d, k = 4, rect = TRUE)

# dendrogram with k = 5 clusters
factoextra::fviz_dend(clusters_d, k = 5, rect = TRUE)

# base R heatmap for dendrograms on both sides
heatmap(rescaled_d)

# ------------------------------------------------------------------------------
# Step 4: k-means
# ------------------------------------------------------------------------------

# use the rescaled data
k <- kmeans(rescaled_d, centers = 3, iter.max = 10)
str(k)

# cluster assignments
k$cluster
# distances to each centroid
k$centers
# sum-of-squares of each cluster
k$withinss

# plot clusters (using PCA for axes)
autoplot(k, data = rescaled_d, frame = TRUE, frame.type = "t", label = TRUE)

# [NOTE] the function above works through two packages: {ggplot2} provides the
# `autoplot` function, which looks for a plotting method suitable for objects
# of class `kmeans`, because that's the class of the `k` object; the plotting
# method itself is provided by the {ggfortify} package.

# experiment with fewer/more clusters
autoplot(kmeans(rescaled_d, 2), data = rescaled_d, frame = TRUE, label = TRUE)
autoplot(kmeans(rescaled_d, 4), data = rescaled_d, frame = TRUE, label = TRUE)

# combine clusters to rescaled data
k <- bind_cols(rescaled_d, Country = d$Country, cluster = factor(k$cluster))

# 2-dimensional view, using red meat and cereals
ggplot(k, aes(x = RedMeat, y = Cereals, color = cluster)) +
  geom_text(aes(label = Country))

# 3-dimensional view, adding milk
plotly::plot_ly(
  data = k,
  x = ~ RedMeat,
  y = ~ Cereals,
  z = ~ Milk,
  color = ~ cluster,
  type = "scatter3d",
  mode = "markers"
)

# [NOTE]: {plotly} is an R interface to the Plotly JavaScript visualization
# library, which has its own features and syntax: https://plotly.com/r/

# have a nice day
