setwd("F:/Data Science/7. Regression Models/Week4/Assessment")
getwd()

#Q1
?shuttle
library(MASS)
dim(shuttle)
View(shuttle)

model.glm <- glm(use ~ wind, data = shuttle, family="binomial")
summary(model.glm)

# finding odds ratio
OR <- exp(cbind(coef(model.glm), confint(model.glm)))
OR

#Q2
model.glm2 <- glm(use ~ wind + magn, 
                   data = shuttle, 
                  family="binomial")

summary(model.glm2)

OR2 <- exp(cbind(coef(model.glm2), confint(model.glm2)))
OR2

library(MASS)
?shuttle
summary(glm(shuttle$use ~ shuttle$wind + shuttle$magn, family="binomial"))

#Q3
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
model.glm3 <- glm(x.2 ~ x.1, data = vowel.train)
model.glm3 <- glm((1 - x.2) ~ x.1, data = vowel.train)

model.glm3_3 <- glm(x.3 ~ x.2, data = vowel.train)
model.glm3_4 <- glm((1 - x.3) ~ x.2, data = vowel.train)

#Q4
data(InsectSprays)
dim(InsectSprays)
View(InsectSprays)

s <- factor(InsectSprays$spray)

model.poisson <- glm(count ~ spray - 1,
                     data = InsectSprays, 
                     family = "poisson"
                     )
relativeRate <- exp(2.674) / exp(2.730)


#Q5
y=c(1:10)
x=y-1+rnorm(10)/10
z=c(1:10)
z=z*2
summary(lm(y~x+offset(z)))
z=z*4
summary(lm(y~x+offset(z)))
z=z+5
summary(lm(y~x+offset(z)))
z=z+100
summary(lm(y~x+offset(z)))
z=z/10
summary(lm(y~x+offset(z)))

#Q5
y <- c(3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
x <- 1:10
z <- 41:50
fit5 <- glm(y ~ factor(x) + offset(log(10) + z), 
    family = "poisson")

fit5_1 <- glm(y ~ factor(x) + offset(z), 
            family = "poisson")
#Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

knots <- 0
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
summary(lm(y ~ xMat - 1))
predict(lm(y ~ xMat - 1))
