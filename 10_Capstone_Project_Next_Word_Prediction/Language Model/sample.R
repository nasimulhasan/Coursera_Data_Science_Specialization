setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()

setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/en_US")

# required library
library(NLP)
library(tm)
library(openNLP)
library(qdap)
library(SnowballC) # Provides wordStem() for stemming
library(RWeka)
library(RColorBrewer) # Generate palette of colours for plots
library(ggplot2)

con <- file("F:/Taufeeq/ML/Data Science/10. Capstone/Dataset/final/en_US/en_US.news.txt", "rb")

twitter <- readLines("en_US.twitter.txt", skipNul = TRUE)
news <- readLines(con)
blogs <- readLines("en_US.blogs.txt")


# Q1
print(object.size(blogs), units="Gb")

# Q2
length(twitter)
length(news)
length(blogs)

# Q3
max(nchar(twitter))
max(nchar(blogs))
max(nchar(news))


# Q4
love <- grep("love", twitter)
length(love)
love.line <- twitter[love]
head(love.line)


hate <- grep("hate", twitter)
length(hate)
hate.line <- twitter[hate]
head(hate.line)

ratio <- length(love) / length(hate)


# Q5
biostats <- grep("biost", twitter)
biostats.line <- twitter[biostats]
biostats.line


# Q6
match.line <- grep("A computer once beat me at chess, but it was no match for me at kickboxing",
                   twitter)
length(match.line)
twitter[match.line]


# **********************************************************
# converting to lower case
twitter <- tolower(twitter)
blogs <- tolower(blogs)
news <- tolower(news)

head(news)

twitter.sample <- sample(twitter, length(twitter) * .25)
length(twitter.sample)
print(object.size(twitter.sample), units="Mb")

blogs.sample <- sample(blogs, length(blogs) * .005)
length(blogs.sample)
print(object.size(blogs.sample), units = "MB")


news.sample <- sample(news, length(news) * .25)
length(news.sample)
print(object.size(news.sample), units = "MB")


head(twitter.sample)
head(blogs.sample)
head(news.sample)


write(twitter.sample, "en_US.twitter.sample.txt")
write(blogs.sample, "en_US.blogs.sample.txt")
write(news.sample, "en_US.news.sample.txt")





# ********************************************

#Q1
Q1 <- grep("The guy in front of me", twitter)
Q1 <- grep("The guy in front of me", news)
length(Q1)
Q1
twitter[Q1]
news[Q1]



# Q2

Q2 <- grep("You're the reason why I smile everyday", twitter)
length(Q2)


# Q4
love <- grep("with his little", twitter)
love.2 <- grep("with his little", blogs)
love.3 <- grep("with his little ears", news)

length(love)
length(love.2)
length(love.3)
love.line <- twitter[love]
head(love.line)

love.2.line <- blogs[love.2]
head(love.2.line)

love.3.line <- news[love.3]
love.3.line


# **************************************************************
Q2 <- grep("You're the reason why I smile everyday", twitter)
length(Q2)


# Q4
love <- grep("hadn't time to take a mintue", twitter)

length(love)
love.line <- twitter[love]
head(love.line)

love.2 <- grep("hadn't time to take a mintue", blogs)
length(love.2)
love.2.line <- blogs[love.2]
head(love.2.line)

love.3 <- grep("hadn't time to take a mintue", news)
length(love.3)
love.3.line <- news[love.3]
love.3.line

