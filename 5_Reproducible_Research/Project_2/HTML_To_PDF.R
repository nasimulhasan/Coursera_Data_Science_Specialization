# Set working directory
setwd("F:/Data Science/5. Reproducible Research/Week3/Project2")
getwd()

# Load packages
library(knitr)
library(markdown)
require(knitr)
require(markdown)

# Create .md, .html, and .pdf files
knit("RR_Project2.Rmd")
markdownToHTML('RR_Project2.md', 'RR_Project2.html', options=c("use_xhml"))
system("pandoc -s RR_Project2.html -o RR_Project2.pdf")