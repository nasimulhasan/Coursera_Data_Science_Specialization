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
library(stylo)
library(topicmodels)
library(wordcloud)

# *******************************************************************
# load the origina data set for Requirement #1
con <- file("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/en_US/en_US.news.txt", "rb")

twitter <- readLines("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/en_US/en_US.twitter.txt", skipNul = TRUE)
news <- readLines(con)
blogs <- readLines("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/en_US/en_US.blogs.txt")

File <- c("en_US_twitter", "en_US_news", "en_US_blogs")

# Size of the file
size <- c(print(object.size(twitter), units = "MB"),
          print(object.size(news), units = "MB"),
          print(object.size(blogs), units = "MB")
          )
size <- size

# counting line
line.count <- c(length(twitter),
                length(news),
                length(blogs)
                )



# counting word
word.count <- c(length(txt.to.words(twitter)),
                length(txt.to.words(news)),
                length(txt.to.words(blogs))
                )


# Longest line
longest.line <- c(max(nchar(twitter)),
                  max(nchar(news)),
                  max(nchar(blogs))
                  )


# create a data table 
table <- data.frame(File_name = File, 
                    File_size = round(size, 0), 
                    Number_of_line = line.count, 
                    Number_of_word = word.count,
                    Longest_line = longest.line
                    )
dim(table)
table


# **************************************************************
# load the corpus for Requirement #2
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

docs <- replacement(docs[2])
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



# *****************************************************

# ------------------------------------------------------------
# create document matrix
ngram <- 2
dtm.1 <- DocumentTermMatrix(clean.docs, 
                            control = list(tokenize = nGramTokenizer)
                            )

frequency.dtm.1 <- sort(colSums(as.matrix(dtm.1)), decreasing = TRUE)
gram.2 <- data.frame(term = names(frequency.dtm.1),
                     frequency = frequency.dtm.1
                     )
dim(gram.2)
head(gram.2)


# ---------------------------------------------------------
ngram <- 3
dtm.2 <- DocumentTermMatrix(clean.docs, 
                            control = list(tokenize = nGramTokenizer)
)

frequency.dtm.2 <- sort(colSums(as.matrix(dtm.2)), decreasing = TRUE)

gram.3 <- data.frame(term = names(frequency.dtm.2),
                     frequency = frequency.dtm.2
                     )
dim(gram.3)
head(gram.3)


# ------------------------------------------------------------
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

write.csv(gram.2, "2_gram.csv", row.names = FALSE)
write.csv(gram.3, "3_gram.csv", row.names = FALSE)
write.csv(gram.4, "4_gram.csv", row.names = FALSE)

# -----------------------------------------------------------------

# ***********************************************************************
# create document matrix
ngram <- 2
tdm.1 <- TermDocumentMatrix(clean.docs, 
                            control = list(tokenize = nGramTokenizer)
                            )

df.tdm.1 <- as.data.frame(as.matrix(tdm.1))
View(df.tdm.1)

write.csv(df.tdm.1, "1_gram_term_document_matrix_v2.csv")
# ---------------------------------------------------------
ngram <- 2
tdm.2 <- TermDocumentMatrix(clean.docs, 
                          control = list(tokenize = nGramTokenizer)
                          )

df.tdm.2 <- as.data.frame(as.matrix(tdm.2))
View(df.tdm.2)

write.csv(df.tdm.2, "2_gram_term_document_matrix_v2.csv")

# ------------------------------------------------------
ngram <- 3
tdm.3 <- TermDocumentMatrix(clean.docs, 
                            control = list(tokenize = nGramTokenizer)
                            )

df.tdm.3 <- as.data.frame(as.matrix(tdm.3))
View(df.tdm.3)

write.csv(df.tdm.3, "3_gram_term_document_matrix_v2.csv")



dim(df.tdm)
View(df.tdm)
print(object.size(df.tdm), units = "Mb")

write.csv(df.tdm, "term_document_matrix_v2.csv")


# ****************************************************
# Exploratory analsis of the corpus

# Term frequency
dtm.blog <- DocumentTermMatrix(clean.docs[1])
class(dtm.blog)
dim(dtm.blog)

dtm.blog.v1 <- removeSparseTerms(dtm.blog, .5)
dim(dtm.blog.v1)

blog.frequency <- sort(colSums(as.matrix(dtm.blog.v1)), decreasing = TRUE)
head(blog.frequency, 10)

# create data frame of word and corresponding frequency
blog.word.frequency <- data.frame(Word = names(blog.frequency), Frequency = blog.frequency)
head(blog.word.frequency)

# plot the word frequency
subset(blog.word.frequency, Frequency > 1000)        %>%
        ggplot(aes(Word, Frequency))            +
        geom_bar(stat = "identity")             +
        theme(axis.text.x=element_text(angle=45, hjust=1)) +
        labs(x = "Mostly written word in blog posts",
             y = "Word frequency",
             title = "Word frequency plot of blog data")

# ---------------------------------------------
dtm.news <- DocumentTermMatrix(clean.docs[2])
class(dtm.news)
dim(dtm.news)

dtm.news.v1 <- removeSparseTerms(dtm.news, .5)
dim(dtm.news.v1)

news.frequency <- sort(colSums(as.matrix(dtm.news.v1)), decreasing = TRUE)
head(news.frequency, 10)

# create data frame of word and corresponding frequency
news.word.frequency <- data.frame(Word = names(news.frequency), Frequency = news.frequency)
head(news.word.frequency)

# plot the word frequency
subset(news.word.frequency, Frequency > 500)        %>%
        ggplot(aes(Word, Frequency))            +
        geom_bar(stat = "identity")             +
        theme(axis.text.x=element_text(angle=45, hjust=1)) +
        labs(x = "Mostly written word in news articles",
             y = "Word frequency",
             title = "Word frequency plot of news articles")


# ------------------------------------------
dtm.twitter <- DocumentTermMatrix(clean.docs[3])
#class(dtm.blog)
#dim(dtm.twitter)

dtm.twitter.v1 <- removeSparseTerms(dtm.twitter, .5)
#dim(dtm.twitter.v1)

twitter.frequency <- sort(colSums(as.matrix(dtm.twitter.v1)), decreasing = TRUE)
#head(blog.frequency, 10)

# create data frame of word and corresponding frequency
twitter.word.frequency <- data.frame(Word = names(twitter.frequency), Frequency = twitter.frequency)
#head(blog.word.frequency)

# plot the word frequency
subset(twitter.word.frequency, Frequency > 200)        %>%
        ggplot(aes(Word, Frequency))            +
        geom_bar(stat = "identity")             +
        theme(axis.text.x=element_text(angle=45, hjust=1)) +
        labs(x = "Mostly written word in twitter tweets",
             y = "Word frequency",
             title = "Word frequency plot of twitter data")




# plot the word cloud
set.seed(142)
wordcloud(names(frequency),
          frequency,
          min.freq = 100,
          scale = c(12, .1),
          colors=brewer.pal(6, "Dark2")
          )


# Frequent term
frequent.term <- findFreqTerms(tdm.1, lowfreq = 1000)
class(frequent.term)
length(frequent.term)
head(frequent.term, 7)

# frequent term in 2-gram
frequent.term.2.gram <- findFreqTerms(tdm.2, lowfreq = 100)
class(frequent.term.2.gram)
length(frequent.term.2.gram)
head(frequent.term.2.gram, 7)

# frequent term in 3 - gram
frequent.term.3.gram <- findFreqTerms(tdm.3, lowfreq = 100)
class(frequent.term.3.gram)
length(frequent.term.3.gram)
head(frequent.term.3.gram, 7)


df.frequent.gram <- data.frame(Frequent_term_in_1_gram = head(frequent.term, 7),
                               Frequent_term_in_2_gram = head(frequent.term.2.gram, 7),
                               Frequent_term_in_3_gram = head(frequent.term.3.gram, 7))




# *****************************************************
# November 15, 2014
df.frequent.1.gram <- data.frame(term = names(frequency.dtm.1),
                               frequency = frequency.dtm.1
                               )
dim(df.frequent.1.gram)
head(df.frequent.1.gram)

write.csv(df.frequent.1.gram,
          "1_gram.csv", row.names = F)


df.frequent.2.gram <- data.frame(term = names(frequency.dtm.2),
                                 frequency = frequency.dtm.2
                                 )
dim(df.frequent.2.gram)

df.frequent.3.gram <- data.frame(term = names(frequency.dtm.3),
                                 frequency = frequency.dtm.3
                                 )
dim(df.frequent.3.gram)
head(df.frequent.3.gram)


write.csv(df.frequent.3.gram,
          "3_gram.csv", row.names = FALSE)
