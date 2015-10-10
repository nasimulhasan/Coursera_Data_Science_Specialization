setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()

# required library
library(NLP)
library(tm)
library(openNLP)
library(qdap)
library(stringr)
library(SnowballC) # Provides wordStem() for stemming
library(RWeka)
library(RColorBrewer) # Generate palette of colours for plots
library(ggplot2)

# parallel computation
options(mc.cores=1)


# creating corpus using en-US documents
corpus.name <- file.path("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset",
                         "final",
                         "sample"
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

length(docs[[1]]$content[1:4])
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
nGramTokenizer <- function(x) NGramTokenizer(x,
                                             Weka_control(min = ngram,
                                                          max = ngram,
                                                          delimiters = " \\r\\n\\t.,;:\"()?!"
                                                          )
                                             )

tokens <- nGramTokenizer(docs)
length(tokens)

# Profinity filtering
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
        #corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
        
        # striping whitespace
        corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
        
        # stemming the documents
        #corpus.tmp <- tm_map(corpus.tmp, stemDocument)
        
        return (corpus.tmp)
}

clean.docs <- clean.corpus(docs)
clean.docs[[1]]$content[10:15]

# Profaning offensive or bad word
bad.or.offensive.words <- read.csv("bad_or_offensive_word.csv")
dim(bad.or.offensive.words)

clean.docs <- tm_map(clean.docs, removeWords, bad.or.offensive.words)
class(clean.docs)
clean.docs[[1]]$content[1:5]

# create document matrix
ngram <- 2
tdm <- TermDocumentMatrix(clean.docs, 
                          control = list(tokenize = nGramTokenizer)
                          )

inspect(tdm)

df.tdm <- as.data.frame(as.matrix(tdm))

dim(df.tdm)
View(df.tdm)

write.csv(df.tdm, "term_document_matrix_v2.csv")
