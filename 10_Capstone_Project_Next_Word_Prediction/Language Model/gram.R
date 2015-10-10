setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()


# required library
library(data.table)
library(tm)
library(stringr)
library(SnowballC) # Provides wordStem() for stemming
library(RWeka)
library(stylo)
library(markovchain)


dir()

gram.2 <- fread("2_gram.csv")
gram.3 <- fread("3_gram.csv")
gram.4 <- fread("4_gram.csv")

gram.4 <- data.frame(gram.2)
dim(gram.4)
colnames(gram.2)

gram.4 <- gram.4[13:204307, ]
# ****************************************************
x <- gram.4[1:20, ]
dim(x)
x

x$term
word <- unlist (strsplit (x$term, split = " ", fixed = TRUE))
word

tail (word, length(word)-1)


as.character(unlist(sapply(x$term), 
                    function(x) unlist(strsplit(x,split=" "))[2]))



# *****************************************************
gram.freq <- gram.4[gram.4$frequency >= 3, ]
dim(gram.freq)
View(gram.freq)


word <- as.vector(gram.freq$term)
head(word)

high.freq <- gram.freq[gram.freq$frequency >= 8, ]
dim(high.freq)
low.freq <- gram.freq[gram.freq$frequency < 8, ]
dim(low.freq)

frequency.1 <- round((high.freq$frequency / 8), 0)

frequency.2 <- round((low.freq$frequency / 3), 0)
head(frequency)

frequency <- c(frequency.1, frequency.2)
length(frequency)

rep.word <- rep(word, frequency)
head(rep.word)
length(rep.word)

token <- scan_tokenizer(rep.word)
token
length(token)
train.token <- token
save(train.token, file = "train.token.RData")

head(token)

fit <- markovchainFit(data = word[1:500])

n <- "of the"
predict(fit$estimate,
        newdata = as.vector(unlist(strsplit("the", " ", fixed = TRUE))),
        n.ahead = 1)
