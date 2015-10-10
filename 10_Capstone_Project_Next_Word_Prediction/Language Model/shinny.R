setwd("F:/Taufeeq/ML/Data Science/10. Capstone/app")
getwd()
dir()

devtools::install_github('rstudio/shinyapps')
library(shinyapps)

runExample("01_hello")

runApp("App")
