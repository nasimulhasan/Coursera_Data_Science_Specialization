setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()
dir()

library(markovchain)

load("train.token.RData")
t <- train.token[1:10]
length(t)

model.fit <- markovchainFit(data = t,
                            method = "mle"
                            )

prediction <- function(phrase) {
        phrase <- as.vector(unlist(strsplit(tolower(phrase), " ", fixed = TRUE)))
        
        if (phrase[length(phrase)] %in% t) {
                prediction <- predict(model.fit$estimate,
                                      newdata = phrase, 
                                      n.ahead = 1
                                      )
        } else {
                prediction <- "the"
        }
        
        prediction
}


prediction("I Taufeeq")
