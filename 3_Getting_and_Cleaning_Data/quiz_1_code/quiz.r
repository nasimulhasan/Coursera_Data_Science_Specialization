#Quiz 1
head(file)

which(file)

agricultureLogical <- file[file$AGS >= 2 & file$ACR >= 2, ]
which(agricultureLogical)
agricultureLogical[1:3, ]

aL <- file[file$AGS >= 2 & file$ACR >= 2, 11:12]
which(aL)
str(file[, 11:12])
getwd()

agri <- c(file$AGS >= 2 & file$ACR >= 2)
agri
which(agri)
head(sort(which(agri)), n = 20)
head(sort(which(agri)), n = 30)


agri <- c(file$AGS >2 & file$ACR >2)
agri
which(agri, 1:3)

# ===========================================
#Q2
fUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg "
pidP <- download.file(fUrl, destfile="./q2.jpg", mode='wb')
head(pidP)

jpgR <- read.jpeg("q2.jpg", native=TRUE)
img <- readJPEG("q2.jpg",native=TRUE)


source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")

quantile(img)

#===============================================
#Q3
f1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
f1Url <- download.file(f1, destfile="./f1.csv")
f1Url

f1Url <- read.csv(f1)
sortDec <- sort(f1Url[, 1:4], decreasing=T)
order(f1Url[, 4], decreasing=T)
summary(f1Url)
head(f1Url)


f2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(f2, destfile="./f2.csv")


f2Url <- read.csv(f2)
f2Url

head(f2Url)
summary(f2Url)

f1Url[1:50, 1:4]
f2Url[, 1]

cbind(f1Url[, 1], f2Url[, 1])
merge(f1Url[, 1], f2Url[, 1])
merge(f1Url[1:15, 1:4], f2Url[1:15, 1])
sort(match(f1Url[, 1], f2Url[, 1]), decreasing=TRUE)


d <- (f1Url[5:194, 5])
dSort <- sort(d, decreasing=T)


L <- f1Url[1:194, 5]
L
L2 <- f1Url[1:194, 1:2]
L2
bind <- cbind(L2, L)
bind

f2B <- f2Url[1:234, 1:2]
f2B
cbind(bind, f2B)

m <- merge(bind, f2B, by.x="X", by.y="CountryCode", all=F)
match(bind, f2B)
library(plyr)
arrange(f1Url, X.3)
arrange(f1Url, X.3)


sort(f1Url$X.3)

matchingTable <- table(bind$X %in% f2B$CountryCode)
freshTable <- bind[bind$X %in% f2B$CountryCode, ]

#=========================================================
#Q4
f2Url[, 3]
