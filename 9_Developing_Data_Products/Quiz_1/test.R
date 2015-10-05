setwd("F:/Data Science/9. Developing Data Products/Week1/Assessment")

#Q1
library(manipulate)

myPlot <- function(s) {
        plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
        abline(0, s)
}