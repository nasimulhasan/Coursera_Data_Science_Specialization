setwd("F:/Taufeeq/ML/Data Science/10. Capstone/Task0")
getwd()


library(markovchain)
library(VLMC)
library(data.table)

sequence<-c("a", "b", "a", "a", "a", "a", "b", "a", "b", "a", "b", "a", "a",
            "b", "b", "b", "a")
sequence

sequenceMatr<-createSequenceMatrix(sequence,sanitize=FALSE)
sequenceMatr

mcFitMLE<-markovchainFit(data=sequence)
mcFitMLE


# **********************************************


mcFitBSP<-markovchainFit(data=sequence,method="bootstrap",nboot=5, name="Bootstrap Mc")
mcFitBSP


statesNames=c("a","b","c")
statesNames

mcB<-new("markovchain", states=statesNames, transitionMatrix=matrix(c(0.2,0.5,0.3,
                                                                      0,0.2,0.8,0.1,0.8,0.1),nrow=3, byrow=TRUE, dimnames=list(statesNames,statesNames)
))
mcB

outs<-markovchainSequence(n=100,markovchain=mcB, t0="a")
outs

outs2<-rmarkovchain(n=20, object=mcB)
outs2

predict(mcFitMLE)


showClass("markovchainList")
statesNames=c("a","b")
statesNames

mcA<-new("markovchain",name="MCA", transitionMatrix=matrix(c(0.7,0.3,0.1,0.9),
                                                           byrow=TRUE, nrow=2, dimnames=list(statesNames,statesNames)))
mcA


mcB<-new("markovchain", states=c("a","b","c"), name="MCB",
         transitionMatrix=matrix(c(0.2,0.5,0.3,0,1,0,0.1,0.8,0.1),
                                 nrow=3, byrow=TRUE))
mcB


mcC<-new("markovchain", states=c("a","b","c","d"), name="MCC",
         transitionMatrix=matrix(c(0.25,0.75,0,0,0.4,0.6,
                                   0,0,0,0,0.1,0.9,0,0,0.7,0.3), nrow=4, byrow=TRUE)
)
mcC

mcList<-new("markovchainList",markovchains=list(mcA, mcB, mcC),
            name="Non - homogeneous Markov Chain")
mcList


data(preproglucacon)
head(preproglucacon)
class(preproglucacon)
dim(preproglucacon)
View(preproglucacon)

preproglucaconMc<-markovchainFit(data=preproglucacon$preproglucacon)
preproglucaconMc


data(rain)
rainMc<-markovchainFit(data=rain$rain)
rainMc
View(rain)


f1 <- c(1,0,0,0)
f2 <- rep(1:0,2)
f1
(dt1 <- c(f1,f1,f2,f1,f2,f2,f1))
dt1

(vlmc.dt1 <- vlmc(dt1))


data(OZrain)
class(OZrain)
OZrain
dim(OZrain)
head(OZrain)

(n <- length(OZrain)) ## should be 1 more than
ISOdate(1990,12,31) - ISOdate(1981, 1,1)## but it ' s 2 ..
has.rain <- OZrain > 0
length(has.rain)
summary(OZrain[has.rain])# Median = 18, Q3 = 50
table(rain01 <- as.integer(has.rain))
table(rain4c <- cut(OZrain, c(-.1, 0.5, 18.5, 50.1, 1000)))


AIC(v1 <- vlmc(rain01))# cutoff = 1.92
AIC(v00 <- vlmc(rain01, cut = 1.4))
AIC(v0 <- vlmc(rain01, cut = 1.5))

predict()



# **************************************************
weathersOfDays <- rmarkovchain(n = 365, object = mcWeather, t0 = "sunny")


dir()

gram_1 <- fread("term_document_matrix_v2.csv")
gram_1 <-data.frame(gram_1)
dim(gram_1)
head(gram_1)


gram.1 <- fread("1_gram.csv")
gram.1 <- data.frame(gram.1)
dim(gram.1)
head(gram.1)

gram.3 <- fread("3_gram.csv")
gram.3 <- data.frame(gram.3)
dim(gram.3)
head(gram.3)


fit <- markovchainFit(data = gram.3[1:50, 1],
                      method = "mle",
                      name = "Weather mle")
fit$estimate

pred <- predict(object = fit$estimate,
                newdata = c("you don t"),
                n.ahead = 2)
pred
