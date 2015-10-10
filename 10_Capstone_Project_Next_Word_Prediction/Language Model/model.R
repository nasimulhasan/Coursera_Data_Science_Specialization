setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()

# required library
library(data.table)
library(parallel)
library(tm)
library(stringr)
library(SnowballC) # Provides wordStem() for stemming
library(RWeka)
library(stylo)
library(markovchain)

dir()

options(mc.cores = 2) 
# ***************************************************
# 
# Building 4-gram model

gram.4 <- fread("4_gram.csv")

gram.4 <- data.frame(gram.4)
dim(gram.4)
colnames(gram.4)
View(gram.4)


train.gram.4 <- gram.4[gram.4$frequency >= 2, ]
dim(train.gram.4)

train.gram.4 <- as.vector(train.gram.4$term)

# create single token from quad token
train.token <- scan_tokenizer(train.gram.4)
head(train.token)

length(train.token)
train.token

save(train.token, file = "train.token.RData")

load("train.token.RData")
length(train.token)
# *******************************************************
twitter <- fread("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/gram_4/twitter.4.gram.csv")
twitter <- data.frame(twitter)
dim(twitter)
colnames(twitter)


twitter.v1 <- twitter[twitter$frequency >= 2, ]
dim(twitter.v1)

news <- fread("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/gram_4/news.4.gram.csv")
news <- data.frame(news)
dim(news)
colnames(news)

news.v1 <- news[news$frequency >= 2, ]
dim(news.v1)

blogs <- fread("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/gram_4/blogs.4.gram.csv")
blogs <- data.frame(blogs)
dim(blogs)
colnames(blogs)

blogs.v1 <- blogs[blogs$frequency > 2, ]
dim(blogs.v1)

gram.4 <- rbind(twitter.v1,
                news.v1,
                blogs.v1
                )
dim(gram.4)

# ******************************************************
train.gram.4 <- as.vector(gram.4$term)

# create single token from quad token
train.token <- scan_tokenizer(train.gram.4)
head(train.token)

length(train.token)


# *******************************************************
#prediction model
model.fit <- markovchainFit(data = train.token,
                            method = "laplace", 
                            laplacian = .01
                            )



# spliting the prediction text
x <- "I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each  "
prediction.text <- as.vector(unlist(strsplit(x, " ", fixed = TRUE)))

prediction <- "the"
prediction <- predict(model.fit$estimate,
                      newdata = prediction.text, 
                      n.ahead = 1)
prediction

