setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()

# required library
library(NLP)
library(tm)
library(openNLP)
library(qdap)
library(SnowballC) # Provides wordStem() for stemming
library(RWeka)
library(RColorBrewer) # Generate palette of colours for plots
library(ggplot2)

# tm 
getSources()
getReaders()
getTransformations()
getTokenizers()

# creating corpus using en-US documents
corpus.name <- file.path("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset",
                         "final",
                         "sample"
                         )

# corpus.name <- file.path("C:/Users/User/Downloads",
#                          "demo",
#                          "new"
#                          )


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

# get rid of ALL non UTF-8 characters
#swap out any problem character with an empty space
docs <-iconv(docs, "UTF-8", "UTF-8",sub='') 
inspect(docs)

doc.chunk <- head(docs[[1]]$content)
doc.chunk

# detecting sentence
sentences <- sent_detect(doc.chunk)
head(sentences)

# word counting
for (i in 1:length(docs[[3]]$content)) {
        #tokenizing and compute the length of the line
        x <- length(scan_tokenizer(docs[[3]]$content[i]))
        
        # print the line and number of word in that respected line
        print(docs[[3]]$content[i])
        print(x)                
}


# inspect into the docs
inspect(docs[1])
to.space <- content_transformer(function(x) sent_detect(x))
corpus.tmp <- tm_map(docs, to.space)  

clean.corpus <- function(docs) {
        
        # detecting sentence
        to.space <- content_transformer(function(x) sent_detect(x))
        corpus.tmp <- tm_map(docs, to.space)  
        
        # special transformation
        to.space <- content_transformer(function(x, pattern) gsub(pattern, "", x))
        corpus.tmp <- tm_map(docs, to.space, "/|@|\\|'|"|")  
        
        # removing bad character
        #corpus.tmp <- gsub('[])(;:#%$^*\\~{}[&+=@/"`|<>_]+"', " ", corpus.tmp)
        
        # removing punctuation
        corpus.tmp <- tm_map(corpus.tmp, removePunctuation)
        
        # converting to lower-case letter - CONFLICT WITH UTF-8
        corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
        
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

#inspect(clean.corpus(docs[3]))
cleaned <- clean.corpus(docs)
inspect(cleaned[3])


# Tokenization
tokens <- scan_tokenizer(cleaned)

head(tokens, 20)
tokens

# N-gram tokenization
ngram = 1
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min=ngram,max=ngram))

BigramTokenizer(as.character(cleaned))

# create document matrix
tdm <- TermDocumentMatrix(clean.corpus(docs), 
                          control = list(tokenize = BigramTokenizer
                                         
                                         )
                          )

inspect(tdm)

df.tdm <- as.data.frame(as.matrix(tdm))
View(df.tdm)


# create document matrix
doc.mat <- TermDocumentMatrix(cleaned,
                              control = list(weighting = weightTfIdf, 
                                             minWordLength = 2,
                                             minDocFreq = 5
                                             )
                              )

dim(doc.mat)

inspect(doc.mat)

