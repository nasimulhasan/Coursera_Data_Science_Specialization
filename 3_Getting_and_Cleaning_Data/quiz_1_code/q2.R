#Q4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
nchar(htmlCode)

# ====================================
con <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
download.file(con, destfile="./q5.for")
code <- readLines(con)

code <- read.fwf(con, widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(code[, 4])

install.packages("json")


#===========================================
#Q1
library(httr)
library(httpuv)
oauth_endpoints("github")

BROWSE("https://api.github.com/users/jtleek/repos",authenticate("638c1019636d3427751cefb80b8278f7bbda1138","x-oauth-basic","basic"))

stuff<-get("https://api.github.com/users/jtleek/repos",authenticate("638c1019636d3427751cefb80b8278f7bbda1138","x-oauth-basic","basic"))


cat(content(stuff, "text"), "\n") 
