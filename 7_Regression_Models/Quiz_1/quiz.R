setwd("F:/Data Science/7. Regression Models/Week3/Quiz")

#Q1
names(mtcars)
fit <- lm(mtcars$mpg ~ mtcars$cyl + mtcars$wt)

gr <- split(mtcars$mpg, mtcars$cyl, drop = F)

fit1 <- lm(gr ~ mtcars$wt)

fit <- lm(mpg~factor(cyl)+wt,data=mtcars)

#Q2
fit21 <- lm(mpg ~ factor(cyl), data = mtcars)
fit22 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)

#Q3
library(lmtest)
fit31 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit32 <- lm(mpg ~ factor(cyl) + wt + factor(cyl) * wt, 
            data = mtcars)
fit33 <- lm(mpg ~ factor(cyl) + factor(cyl) * wt, 
            data = mtcars)

lrtest(fit31, fit32)
anova(fit31, fit32)
#Q4
fit4 <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)


#Q5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit5 <- lm(y ~ x)
hatvalues(fit5)

#Q6
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit6 <- lm(y ~ x)
