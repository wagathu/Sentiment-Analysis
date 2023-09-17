
# Importing the packages---------------------------------------------------

library(pacman)
p_load(gutenbergr, ggplot2, tm, tidytext, dplyr, stringi, stringr, MASS, fitdistrplus)


# Importing the dictionary ------------------------------------------------

dictionary <-gutenberg_download(gutenberg_id = 29765)
head(dictionary)
write.csv(dictionary, "E:/Desktop/Sentiment Analysis/dictionary.csv")

# Unnest tokens -----------------------------------------------------------

dictionary <- dictionary %>% 
  unnest_tokens(word, text) %>%
  mutate(word = str_extract(word, "[a-z]+")) %>% 
  na.omit()

# Calculating the length of words -----------------------------------------

dictionary <- dictionary %>% 
  mutate(duplicated = duplicated(word)) %>% 
  filter(duplicated == FALSE) %>% 
  select(,"word") %>% 
  mutate(length = str_length(word)) %>% 
  filter(length <= 22)
  

# Plotting the word length ----------------------------------------------------------------

dictionary %>% 
  ggplot(aes(x = as.factor(length))) +
  geom_bar(fill = "royalblue") +
  theme_minimal() +
  theme(axis.line = element_line(),
        plot.title = element_text(hjust = .5)) +
  labs(title = "Word length Distribution")+
  xlab("word length")

# Modelling -------------------------------------------------------------------------
# Gamma Distribution

fit <- fitdist(dictionary$length, "gamma")
summary(fit)

dictionary %>% 