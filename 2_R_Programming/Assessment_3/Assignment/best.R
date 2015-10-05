setwd("F:/Data Science/2. R Programming/Week4/Assesment/Assignment")

outcome <- read.csv("outcome-of-care-measures.csv",  colClasses = "character")
head(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])
names(outcome)

best <- function(state, outcome) {
        ## Read outcome data
        
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
         stateDfr <- outcomeF[outcomeF$State == state, ]
         colNum <- inputDfr[inputDfr$Outcome == outcome, 2]
         rowNum <- which.min(stateDfr[, colNum])
         return(stateDfr[rowNum, ]$Hospital.Name)
         
#         
#         columnName <- c("heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
#                         "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
#                         , "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
#         if (!state%in%outcome$State & !outcome%in%columnName) {
#                 stop()
#                 geterrmessage("invalid state")
#                 geterrmessage("invlid outcome")
#         } else {
#                 outcome <- outcome[order(outcome$Hospital.Name)]
#                 
#                 #split(outcome[, 7], outcome[, 7])
#                 
#                 outcome
#         }
#         
#         if (!outcome%in%columnName) {
#                 stop()
#                 geterrmessage("invlid outcome")
#         } else {
#                 outcome <- outcome[order(outcome$State, outcome$Hospital.Name)]
#         }
        ## Check that state and outcome are valid
        
        ## Return hospital name in that state with lowest 30-day death
        ## rate
}

