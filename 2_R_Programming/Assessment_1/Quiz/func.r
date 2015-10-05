#create standard test dataset
set.seed(100) #for stability of test dataset and get same dataset all the time
d <- rpois(25, 8)
d

#create func
GetCI = function(x, level=0.95) {
  if (level <= 0 || level >= 1) {
    stop("The 'level' argument must be > 0 and <1")
  }
  if (level < 0.5) {
    warning("Confidence levels are often close to 1 e.g. 0.5")
  }
  m <- mean(x)
  l <- length(x)
  SE <- sd(x) / sqrt(l)
  upper <- 1 - (1-level)/2
  ci <- m + c(-1, 1)*qt(upper, l-1)*SE
  #when multiple value is returned from func, its 
  #useful to use list() 
  return (list(mean=m, se=SE, ci=ci)) #return in a list
}
#call the func
GetCI(d, 99)
GetCI(d, 0.99)
GetCI(d, 0.09)

#(...) allow a function to take extra args, not specified
#Demo = function(x, ...)

#to pass additional args
#use (...)
#to access this args use list(...)
  
##############
#invisible func
#used when output is very large. Very careful
annoying <- function (x) {
  invisible(rep(x, 1000))
}
tmp <- annoying(1:3)
tmp

#recursive func
LogMe <- function(x) {
  return(ifelse(x > 1, LogMe(log(x)), x))
}
LogMe(3.369)

LogMe <- function(x) {
  #(recall()) automatically the func its in
  return(ifelse(x > 1, Recall(log(x)), x))
}
LogMe(3.369)