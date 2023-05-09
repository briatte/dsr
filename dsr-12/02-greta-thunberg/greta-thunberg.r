# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2023
# |____/|_____|__|__|
#
# Mining into Greta Thunberg's speeches
#
# ============================= See README file for data sources and details ===

# required packages

library(igraph)
library(ggraph)
library(pdftools)
library(tidytext)
library(tidyverse)

# ------------------------------------------------------------------------------
# Prelude 1: reading text from a PDF file (taken from ESM 244 Lab Week 8)
# ------------------------------------------------------------------------------

# extract text from PDF source
thunberg_text <- pdftools::pdf_text("data/greta-thunberg-speech-2018.pdf")

# inspect first 500 characters
str_sub(thunberg_text, 1, 500)

# get one sentence per item, the manual way
str_split(thunberg_text, "\\.") %>% 
  unlist() %>% 
  # replace line breaks with spaces
  str_replace_all("\\n+", " ") %>% 
  # remove extra whitespace
  str_squish()

# ------------------------------------------------------------------------------
# Prelude 2: tokenize and remove stop words (taken from ESM 244 Lab Week 8)
# ------------------------------------------------------------------------------

sentences <- str_split(thunberg_text, "\\.") %>% 
  unlist() %>% 
  str_replace_all("\\n+", " ") %>% 
  str_squish()

sentences

# tokenize words
words <- sentences %>% 
  as_tibble_col(column_name = "sentence") %>% 
  tidytext::unnest_tokens(word, sentence, token = "words")

words

# stop words, loaded by {tidytext}
data(stop_words) 
stop_words

# remove stop words from text
words <- words %>% 
  anti_join(stop_words, by = "word")

# identify most frequent words
words %>% 
  count(word, sort = TRUE)

# ------------------------------------------------------------------------------
# Step 1: import a multi-text corpus
# ------------------------------------------------------------------------------

# list all text files in data folder
fs::dir_ls("data", glob = "*txt") %>% 
  # import as a list
  map(readr::read_lines) %>% 
  # print first 10 lines of each text
  map(head, 10)

speeches <- fs::dir_ls("data", glob = "*txt") %>% 
  # import each speech and identify them
  map_df(~ tibble(speech = .x, text = readr::read_lines(.x))) %>% 
  # recode double and 'curly' quotes
  mutate(text = str_replace_all(text, "\"|’", "'")) %>% 
  # identify each text by city
  mutate(speech = str_extract(speech, "Brussels|Katowice|Milan")) %>% 
  # remove empty lines
  filter(str_length(text) > 0)

# inspect first lines
speeches %>% 
  group_by(speech) %>% 
  group_split()

# ------------------------------------------------------------------------------
# Step 2: tokenize and remove stop words
# ------------------------------------------------------------------------------

# tokenize words and remove stop words
words <- speeches %>% 
  tidytext::unnest_tokens(word, text) %>% 
  anti_join(stop_words, by = "word")

# inspect first lines
words %>% 
  group_by(speech) %>% 
  group_split()

# inspect top 5 most frequent words per speech
words %>% 
  group_by(speech, word) %>%
  count(sort = TRUE) %>% 
  group_by(speech) %>% 
  group_split() %>% 
  map(head, 5)

# inspect words that do not recur across speeches
words %>% 
  group_by(speech, word) %>% 
  add_count() %>% 
  # TF-IDF: term frequency (TF) * inverse document frequency (IDF)
  tidytext::bind_tf_idf(word, speech, n) %>% 
  group_by(speech) %>%
  arrange(-tf_idf) %>% 
  group_split()

# ------------------------------------------------------------------------------
# Step 3: sentiment by sentence
# ------------------------------------------------------------------------------

# AFINN dictionary: positive/negative word valence
head(get_sentiments("afinn"))
tail(get_sentiments("afinn"))

# examples of highly positive words
get_sentiments("afinn") %>% 
  filter(value %in% 4:5) %>% 
  head(20)

# get one sentence per item, the {tidytext} way (results will be lowercase)
sentences <- speeches %>%
  tidytext::unnest_tokens(sentence, text, token = "sentences")

sentences

words_from_sentences <- sentences %>% 
  # enumerate sentences
  group_by(speech) %>% 
  mutate(index = 1:n()) %>% 
  group_by(speech, index) %>% 
  # tokenize words
  tidytext::unnest_tokens(word, sentence, token = "words", drop = FALSE)

words_from_sentences

# merge speech corpus to AFINN dictionary (removes non-matched words)
words_from_sentences <- words_from_sentences %>% 
  select(-sentence) %>%
  inner_join(get_sentiments("afinn"), by = "word")

words_from_sentences

# aggregate by sentence and visualize
words_from_sentences %>% 
  group_by(speech, index) %>% 
  summarise(
    positive = sum(value[ value > 0]),
    negative = sum(value[ value < 0])
  ) %>% 
  ggplot(aes(x = index)) +
  geom_col(aes(y = positive), fill = "forestgreen") +
  geom_col(aes(y = negative), fill = "darkred") +
  facet_grid(. ~ speech, scales = "free_x", space = "free_x") +
  labs(y = "positive/negative sentiment", x = "sentence index")

# 1st highly negative passage from Milan 2021
words_from_sentences %>% 
  filter(speech == "Milan", index > 5, index < 20) %>% 
  print(n = 50)

filter(sentences, speech == "Milan") %>% 
  slice(9:18) # sentences 9 to 18

# 2nd highly negative passage from Milan 2021
words_from_sentences %>% 
  filter(speech == "Milan", index > 20, index < 30) %>% 
  print(n = 50)

filter(sentences, speech == "Milan") %>% 
  pull(sentence) %>% 
  pluck(26) # particularly negative 26th sentence

# ------------------------------------------------------------------------------
# Step 4: detailed sentiment analysis
# ------------------------------------------------------------------------------

# NRC dictionary: classify words by (positive/negative) sentiment
get_sentiments("nrc") %>%
  count(sentiment)

detailed_sentiments <- words_from_sentences %>% 
  inner_join(get_sentiments("nrc"), by = "word") %>% 
  filter(!sentiment %in% c("positive", "negative")) %>% 
  mutate(positive = sentiment %in% c("anticipation", "joy", "trust"))

# inspect first lines
detailed_sentiments %>% 
  group_by(speech) %>% 
  group_split()

detailed_sentiments %>% 
  group_by(speech, index, positive, sentiment) %>% 
  count() %>% 
  ggplot(aes(index, n)) +
  geom_col(aes(fill = positive)) +
  scale_y_continuous(breaks = scales::breaks_width(1)) +
  facet_grid(sentiment ~ speech, scales = "free_x", space = "free_x")

# ------------------------------------------------------------------------------
# Step 5: n-grams
# ------------------------------------------------------------------------------

# bigrams: pairs of words
bigrams <- speeches %>% 
  tidytext::unnest_tokens(bigram, text, token = "ngrams", n = 2)

# inspect (bigrams found on) first lines
bigrams %>% 
  group_by(speech) %>% 
  group_split()

# inspect most common bigrams across all speeches
bigrams_frequency <- bigrams %>%
  tidyr::separate(bigram, c("word1", "word2"), sep = " ") %>%
  # remove bigrams that include stop words
  filter(!word1 %in% stop_words$word, !word2 %in% stop_words$word) %>%
  count(word1, word2, sort = TRUE)

bigrams_frequency

# convert frequent bigrams to a weighted graph (network)
bigrams_network <- bigrams_frequency %>%
  filter(!is.na(word1), !is.na(word2), n > 1, n < 20) %>%
  igraph::graph_from_data_frame()

bigrams_network

# network of most common 2-word (bigram) associations
ggraph(bigrams_network, layout = "kk") +
  geom_edge_link0(aes(width = n)) +
  geom_node_label(aes(label = name)) +
  theme_void()

# kthxbye
