# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2024
# |____/|_____|__|__|
#
# Feelings towards politicians in France (CNEP 2017)
#
# ============================= See README file for data sources and details ===

# required packages

library(corrr)
library(factoextra)
library(ggrepel)
library(tidyverse)

# ------------------------------------------------------------------------------
# Step 1: import the data (CNEP French survey)
# ------------------------------------------------------------------------------

d <- haven::read_sav("data/CN4France2017.Fin-27j6q27.zip")

table(d$Q14)
table(d$Q19a_a)

# select 'thermometer' (feelings towards...) variables
p <- select(d, starts_with("Q19"))

# average feeling scores
apply(p, 2, mean, na.rm = TRUE)

# rename columns
names(p) <- sapply(names(p), function(x) attr(p[[x]], "label"))
names(p) <- str_remove(names(p), ".*group - ")
# View(p)

# ------------------------------------------------------------------------------
# Step 2: correlations
# ------------------------------------------------------------------------------

# heatmap
cor(p, use = "pairwise.complete.obs") %>%
  ggcorrplot::ggcorrplot() +
  scale_fill_viridis_b()

# network
cor(p, use = "pairwise.complete.obs") %>%
  corrr::network_plot(curved = FALSE)

# ------------------------------------------------------------------------------
# Step 3: principal components
# ------------------------------------------------------------------------------

pca_fit <- p %>%
  na.omit() %>%
  scale(center = TRUE, scale = TRUE) %>%
  prcomp()

summary(pca_fit)

# variance explained per component
variance <- tibble(
  var = pca_fit$sdev^2,
  var_exp = var / sum(var),
  cum_var_exp = cumsum(var_exp)
) %>%
  mutate(pc = row_number())

# proportion of variance explained (PVE)
ggplot(variance, aes(pc, var_exp)) +
  geom_point() +
  geom_line() +
  geom_label_repel(aes(label = pc), size = 4) +
  labs(x = "Principal Component", y = "PVE") +
  scale_y_continuous(labels = scales::percent)

# same plot ('scree plot') using {factoextra}
fviz_screeplot(pca_fit, addlabels = TRUE, choice = "variance")

# 'biplot'
fviz_pca_biplot(pca_fit, label = "var", col.var = "black", col.ind = "grey80")

# feature loadings/contributions ("contrib")
pca_fit %>%
  fviz_pca_var(col.var = "contrib") +
  scale_color_gradient(low = "grey50", high = "tomato") +
  labs(color = "Contribution", title = "") +
  theme_minimal()+
  theme(axis.title = element_text(size=15),
        axis.text = element_text(size=17))

# show relationship to ideology
tibble(
  `PC 1` = pca_fit$x[, 1],
  `PC 2` = pca_fit$x[, 2],
  `Left-Right` = as.integer(d$Q14[ -attr(na.omit(p), "na.action") ])
) %>%
  ggplot(aes(`PC 1`, `PC 2`, color = `Left-Right`)) +
  geom_point() +
  scale_color_viridis_b()

# ... or, in combination to biplot
fviz_pca_biplot(
  pca_fit,
  label = "var",
  col.var = "black",
  col.ind = as.integer(d$Q14[ -attr(na.omit(p), "na.action") ]),
  alpha.ind = 0.5
) +
  scale_color_viridis_b()

# have a tremendously nice day
