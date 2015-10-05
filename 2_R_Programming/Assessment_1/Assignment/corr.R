corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        filenames <- sprintf("%03d.csv", as.numeric(id))
        filedir <- file.path(directory, filenames)        
        
        nobsNum <- numeric(0)
        corrsNum <- numeric(0)
        nobsDfr <- complete("specdata")
        
        
        
        
        for (cid in 1:length(id)) {
                dataset <- read.csv(filedir[cid], header = TRUE)
                cDir <- dataset
                nobsNum <- c(nobsNum, nrow(na.omit(cDir)))
        }
        
        nob <- data.frame(id=id, nobs = nobsNum)
        
        nobsDfr <- nobsDfr[nobsDfr$nobs > threshold, ]
        
        for (cid in nobsDfr$id) {
                monDfr <- read.csv(filedir[cid], header = TRUE)
                
                corrsNum <- c(corrsNum, cor(monDfr$sulfate, monDfr$nitrate, use = "pairwise.complete.obs"))
        }
        return(corrsNum)
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
}