
# Importing the necessary packages ----------------------------------------

library(pacman)
p_load(readxl, dplyr, ModelMetrics, tm, gmodels, ggplot2,gutenbergr ,tidytext, wordcloud, knitr)


# Getting the index of the specific Novel ----------------------------------


robertson_books <- gutenberg_works(author == "Robertson, Morgan")


# Downloading the novel after identifyig the ID of the novel --------------

titanic <- gutenberg_download(24880)


# The nrc lexicon ---------------------------------------------------------

get_sentiments("nrc") %>% 
  head() %>% 
  kable()


# The AFINN lexicon -------------------------------------------------------

get_sentiments("afinn") %>% 
  head() %>% 
  kable()


# The  bing lexicon -------------------------------------------------------

get_sentiments("bing") %>% 
  head() %>% 
  kable()


# Creating the corpus -----------------------------------------------------

novelCorpus <- Corpus(VectorSource(titanic))


# Cleaning the corpus -----------------------------------------------------

novelCorpus <- tm_map(novelCorpus, tolower) # Puttin to lowercase
novelCorpus <- tm_map(novelCorpus, removeNumbers) # Removing numbers
novelCorpus <- tm_map(novelCorpus, removePunctuation) # Remove punctuation
novelCorpus <- tm_map(novelCorpus, removeWords, stopwords()) # Removing stop words
novelCorpus <- tm_map(novelCorpus, stripWhitespace) # Removing the white spaces

inspe 