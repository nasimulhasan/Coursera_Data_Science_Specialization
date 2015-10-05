rankall <- function(outcome, num = "best") {
        ## Read outcome data
        ## Check that state and outcome are valid
        ## For each state, find the hospital of the given rank
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        outcomeF <- read.csv("outcome-of-care-measures.csv",  colClasses = "character")
        
        suppressWarnings(outcomeF[, 11] <- as.numeric(outcomeF[, 11]))
        suppressWarnings(outcomeF[, 17] <- as.numeric(outcomeF[, 17]))
        suppressWarnings(outcomeF[, 23] <- as.numeric(outcomeF[, 23]))
        
        #create data frame
        dataFrame <- data.frame(State = names(tapply(outcomeF$State, outcomeF$State, 
                                                     length)), Freq = tapply(outcomeF$State, outcomeF$State, length))
        
        rownames(dataFrame) <- NULL
        
        
        #outcome data frame
        inputDfr <- data.frame(Outcome = c("heart attack", "heart failure", "pneumonia"), 
                               Col = c(11, 17, 23))
        
        # --- Check that state and outcome are valid
        if (nrow(dataFrame[dataFrame$State == state, ]) == 0) 
                stop("invalid state")
        if (nrow(inputDfr[inputDfr$Outcome == outcome, ]) == 0) 
                stop("invalid outcome")
        
        # --- Return hospital name in that state with lowest THIRTY(30)-day death
        # rate Create a data frame with given ONE (1) state Determine the relevant
        # row and column
        nameChr <- character(0)
        for (state in dataFrame$State) {
        stateDfr <- outcomeF[outcomeF$State == state, ]
        colNum <- inputDfr[inputDfr$Outcome == outcome, 2]
        stateDfr <- stateDfr[complete.cases(stateDfr[, colNum]), ]
        stateDfr <- stateDfr[order(stateDfr[, colNum], stateDfr$Hospital.Name), 
                             ]
        
        
        # --- Convert 'best' and 'worst' to numeric 'Worst' code is not valid if
        # omit NA from results Determine the relevant row
        if (num == "best") 
                rankNum <- 1
        else if (num == "worst") 
                rankNum <- nrow(stateDfr)
        # if( rankObj=='worst' ) rankObj <- tableDfr[tableDfr$State==stateChr, 2]
        else suppressWarnings(rankNum <- as.numeric(num))
        
        # --- Return value is a character Return data frame for debug
        nameChr <- c(nameChr, stateDfr[rankNum, ]$Hospital.Name)
        # return(stateDfr)
        }
        #new data frame
        return(data.frame(hospital = nameChr, state = dataFrame$State))
}
