setwd("F:/Data Science/7. Regression Models/Week3/Project")
getwd()

data(mtcars)
View(mtcars)

#extract mpg and am (automatic manual)
data <- data.frame(mtcars$mpg, mtcars$am)
dim(data); View(data)

meanMPG <- tapply(mtcars$mpg, mtcars$am, mean)
sdMPG <- tapply(mtcars$mpg, mtcars$am, sd)

mtcars0 <- mtcars[which(mtcars$am == 0), ]
mtcars1 <- mtcars[which(mtcars$am != 0), ]
plot(mtcar0$mpg); plot(mtcar1$mpg)
dim(mtcars0); View(mtcars0)
dim(mtcars1); View(mtcars1)

#make trianing set
library(caret)
training <- createDataPartition(y = mtcars$am,
                                p = 0.7,
                                list = FALSE)

training <- mtcars[training, ]
dim(training); View(training)
testing <- mtcars[25:32, ]
dim(testing); View(testing)        

model.fit <- lm(mpg ~ ., data = training)
dir <- step(model.fit, , direction = "backward")
model.fit2 <- lm(mpg ~ factor(am), data = training)

model.fit3 <- lm(mpg ~ factor(am), data = training)
model.fit4 <- lm(mpg ~ as.factor(am) + wt, data = mtcars)
model.fit5 <- lm(mpg ~ as.factor(am) + as.factor(cyl),
                 data = mtcars)

summary(model.fit)$coef
summary(model.fit2)$coef
summary(model.fit3)$coef
summary(model.fit4)$coef
summary(model.fit5)$coef

plot(model.fit)
model.lm <- train(am ~ ., method = "lm", data = training)
model.fit


model.predict <- predict(model.lm, testing)


#======================
#plot segment
library(lattice)
qplot(wt, mpg, data = mtcars, col = am)
