complete <- function(directory = getwd(), id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files       
        filenames <- sprintf("%03d.csv", as.numeric(id))
        filedir <- file.path(directory, filenames)        

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        nobsNum <- numeric(0)
        
        for (cid in 1:length(id)) {
                dataset <- read.csv(filedir[cid], header = TRUE)
                cDir <- dataset
                nobsNum <- c(nobsNum, nrow(na.omit(cDir)))
        }
        
        data.frame(id=id, nobs = nobsNum)
        
}