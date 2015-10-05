#q3
setwd("F:/Data Science/3. Getting and Cleaning Data/Week1/Quiz")

gdp <- read.csv("gdp.csv")
ext <- gdp[5:194, 1:2]


edu <- read.csv("edu.csv")

edu <- [, 1]
df <- merge(ext, edu, all=T)
sort(df, decreasing=T)

m <- merge(edu, ext)
m[1:190, 1:3]
sort(m[, 1])

first <- ext[, 1]
s0 <- sort(ext, by="Gross.domestic.product.2012", decreasing=T)
s1 <- sort(first)

second <- edu[, 1]
s2 <- sort(second)

s1 == s2

#q4
by(z$Gross.domestic.product.2012,z$Income.Group, mean)

#q5
library(Hmisc)
ext$Group = cut2(ext[, 2], g=5)

e1 <- data.frame(ext)
e2 <- data.frame(e)
mm <- merge(e1, e2, all=L)
sort(mm)
