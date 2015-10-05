pollutantmean <- function(directory = getwd(), pollutant, id = 1:332) {
        
        filenames <- sprintf("%03d.csv", id)
        
        filedir <- file.path(directory, filenames)
        
        #initailize null 
        initVec <- numeric()
        meanS <- NULL
        for (i in 1:length(id)) {
                dataset <- read.csv(filedir[i], header = TRUE)
                
                #extract sulfate and nitrate and store in poldataset
                if(pollutant == "sulfate") {
                        polDataset <- dataset$sulfate
                }
                else if (pollutant == "nitrate") {
                        polDataset <- dataset$nitrate
                }
                else {}
                
                #compute mean
                initVec <- c(initVec, polDataset)               
                meanS <- round(mean(initVec, na.rm = TRUE), 3)
                
        }
        return(meanS)
        
}

### Test case
#> pollutantmean("specdata", "sulfate", 1:10)
#[1] 4.064
#> pollutantmean("specdata", "nitrate", 70:72)
#[1] 1.706
#> pollutantmean("specdata", "nitrate", 23)
#[1] 1.281
