setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()

setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/sample")
dir()

# required library
library(NLP)
library(tm)
library(openNLP)
library(stylo)
library(stringr)
library(qdap)
library(SnowballC) # Provides wordStem() for stemming
library(RWeka)
library(RColorBrewer) # Generate palette of colours for plots
library(ggplot2)

con <- file("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/sample/en_US.news.sample.txt", "rb")

twitter <- readLines("en_US.twitter.sample.txt", skipNul = TRUE)
news <- readLines(con)
blogs <- readLines("en_US.blogs.sample.txt")

length(twitter)
length(news)
length(blogs)

# converting to lower case
twitter <- tolower(twitter)
blogs <- tolower(blogs)
news <- tolower(news)

twitter.1 <- twitter[1:30000]
twitter.2 <- twitter[30001:60000]
twitter.3 <- twitter[60001:90000]
twitter.4 <- twitter[90001:120000]
twitter.5 <- twitter[120001:150000]

length(twitter.5)

write(twitter.1, "1_en_US.twitter.sample.txt")
write(twitter.2, "2_en_US.twitter.sample.txt")
write(twitter.3, "3_en_US.twitter.sample.txt")
write(twitter.4, "4_en_US.twitter.sample.txt")
write(twitter.5, "5_en_US.twitter.sample.txt")


news.1 <- news[1:10000]
news.2 <- news[10001:20000]
news.3 <- news[20001:30000]
news.4 <- news[30001:40000]
news.5 <- news[40001:50000]

length(news.5)

write(news.1, "1_en_US.news.sample.txt")
write(news.2, "2_en_US.news.sample.txt")
write(news.3, "3_en_US.news.sample.txt")
write(news.4, "4_en_US.news.sample.txt")
write(news.5, "5_en_US.news.sample.txt")


blogs.1 <- blogs[1:10000]
blogs.2 <- blogs[10001:20000]

length(blogs.2)

write(blogs.1, "1_en_US.blogs.sample.txt")
write(blogs.2, "2_en_US.blogs.sample.txt")


# *******************************************************************
# load the corpus for Requirement #2
# creating corpus using en-US documents
corpus.name <- file.path("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset",
                         "final",
                         "sample.version1"
                         )

# number of docs
length(dir(corpus.name))
dir(corpus.name)


# load the corpus
docs <- Corpus(DirSource(corpus.name,
                         encoding="UTF-8"),
               readerControl = list(language = "en")
               )

summary(docs)
str(docs)
class(docs)

# length of the document 
docs[[1]]$meta
docs[[1]]$meta
docs[[1]]$meta

length(docs[[1]]$content)
length(docs[[2]]$content)
length(docs[[3]]$content)

# take care of the DOT
# 1. Apply standard remove 
# 2. create data frame
abbr <- read.csv("abbr.csv")
replacement <- function(x) {
        replace.abbr <- content_transformer(function(x) replace_abbreviation(x, abbreviation = abbr))
        corpus.tmp <- tm_map(docs, replace.abbr)
}

docs <- replacement(docs)
# > x <- replacement(docs[[1]]$content[1])
# > x[[1]]$content[1]
# [1] "just so you know it, it was feb all worth it :d"
# > docs[[1]]$content[1]
# [1] "just so you know it, it was feb. all worth it. :d"


# detecting sentence
sentences <- function(x) {
        to.space <- content_transformer(function(x) sent_detect(x))
        corpus.tmp <- tm_map(docs, to.space)
}

docs <- sentences(docs)

# n-gram tokenizer
#
# 2-gram
nGramTokenizer <- function(x) NGramTokenizer(x,
                                             Weka_control(min = ngram,
                                                          max = ngram,
                                                          delimiters = " \\r\\n\\t.,;:\"()?!"
                                             )
                                             )

tokens <- nGramTokenizer(docs)
length(tokens)

# Profinity filtering
bad.or.offensive <- readLines("bad_or_offensive_word_v1.txt")
clean.corpus <- function(docs) {        
        # special transformation
        to.space <- content_transformer(function(x) str_replace_all(x, "[^[:alnum:][:space:]']", ""))
        corpus.tmp <- tm_map(docs, to.space)  
        
        #corpus.tmp <- tm_map(corpus.tmp, to.space)
        
        # removing bad character
        #corpus.tmp <- gsub('[])(;:#%$^*\\~{}[&+=@/"`|<>_]+"', " ", corpus.tmp)
        
        # removing punctuation
        #corpus.tmp <- tm_map(corpus.tmp, removePunctuation)
        
        # removeing the number
        corpus.tmp <- tm_map(corpus.tmp, removeNumbers)
        
        # removing stop words
        corpus.tmp <- tm_map(corpus.tmp, removeWords, bad.or.offensive)
        
        # striping whitespace
        corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
        
        # stemming the documents
        #corpus.tmp <- tm_map(corpus.tmp, stemDocument)
        
        return (corpus.tmp)
}

clean.docs <- clean.corpus(docs)
clean.docs[[1]]$content[1:3]

# Profaning offensive or bad word
#bad.or.offensive.words <- read.csv("bad_or_offensive_word.csv")
#dim(bad.or.offensive.words)

#clean.docs <- tm_map(clean.docs, removeWords, bad.or.offensive.words)
#docs <- tm_map(docs, removeWords, bad.or.offensive.words)

class(clean.docs)
clean.docs[[1]]$content[1:5]
docs[[1]]$content[1:5]


ngram <- 4
dtm.3 <- DocumentTermMatrix(clean.docs, 
                            control = list(tokenize = nGramTokenizer)
                            )

frequency.dtm.3 <- sort(colSums(as.matrix(dtm.3)), decreasing = TRUE)

gram.4 <- data.frame(term = names(frequency.dtm.3),
                     frequency = frequency.dtm.3
                     )
dim(gram.4)
head(gram.4)
View(gram.4)

dir()
write.csv(gram.4, "4_gram_2_en_US.blogs.csv", row.names = FALSE)


# ***************************************************
#
#twitter
twitter.1 <- fread("4_gram_1_en_US.twitter.csv")
dim(twitter.1)
colnames(twitter.1)

twitter.2 <- fread("4_gram_2_en_US.twitter.csv")
dim(twitter.2)
colnames(twitter.2)

twitter.3 <- fread("4_gram_3_en_US.twitter.csv")
dim(twitter.3)
colnames(twitter.3)

twitter.4 <- fread("4_gram_4_en_US.twitter.csv")
dim(twitter.4)
colnames(twitter.4)

twitter.5 <- fread("4_gram_5_en_US.twitter.csv")
dim(twitter.5)
colnames(twitter.5)


twitter.4.gram <- rbind(twitter.1,
                        twitter.2,
                        twitter.3,
                        twitter.4,
                        twitter.5
                        )
dim(twitter.4.gram)
colnames(twitter.4.gram)
View(twitter.4.gram)

twitter.4.gram <- twitter.4.gram[order(twitter.4.gram$frequency, decreasing = T), ]
dim(twitter.4.gram)
head(twitter.4.gram)
View(twitter.4.gram)

write.csv(twitter.4.gram,
          "twitter.4.gram.csv",
          row.names = F)


# news 
news.1 <- fread("4_gram_1_en_US.news.csv")
dim(news.1)
colnames(news.1)

news.2 <- fread("4_gram_2_en_US.news.csv")
dim(news.2)
colnames(news.2)

news.3 <- fread("4_gram_3_en_US.news.csv")
dim(news.3)
colnames(news.3)

news.4 <- fread("4_gram_4_en_US.news.csv")
dim(news.4)
colnames(news.4)

news.5 <- fread("4_gram_5_en_US.news.csv")
dim(news.5)
colnames(news.5)


news.4.gram <- rbind(news.1,
                     news.2,
                     news.3,
                     news.4,
                     news.5
                     )
dim(news.4.gram)
colnames(news.4.gram)
View(news.4.gram)

news.4.gram <- news.4.gram[order(news.4.gram$frequency, decreasing = T), ]
dim(news.4.gram)
head(news.4.gram)
View(news.4.gram)

write.csv(news.4.gram,
          "news.4.gram.csv",
          row.names = F)


# blogs
library(data.table)

blogs.1 <- fread("4_gram_1_en_US.blogs.csv")
dim(blogs.1)
colnames(blogs.1)

blogs.2 <- fread("4_gram_2_en_US.blogs.csv")
dim(blogs.2)
colnames(blogs.2)

blogs.4.gram <- rbind(blogs.1, blogs.2)
dim(blogs.4.gram)
colnames(blogs.4.gram)
View(blogs.4.gram)

blogs.4.gram <- blogs.4.gram[order(blogs.4.gram$frequency, decreasing = T), ]
dim(blogs.4.gram)
head(blogs.4.gram)
View(blogs.4.gram)

write.csv(blogs.4.gram,
          "blogs.4.gram.csv",
          row.names = F)
