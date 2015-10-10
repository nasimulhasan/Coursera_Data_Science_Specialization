library(shiny)
library(markovchain)

load("train.token.RData")
load("model.fit.RData")

# model.fit <- markovchainFit(data = train.token[1:58306],
#                             method = "mle"
#                             )

prediction <- function(phrase) {
        phrase <- as.vector(unlist(strsplit(tolower(phrase), " ", fixed = TRUE)))
                                                
        if (phrase[length(phrase)] %in% train.token[1:58306]) {
                prediction <- predict(model.fit$estimate,
                                      newdata = phrase, 
                                      n.ahead = 1
                                      )
        } else {
                prediction <- "the"
        }
                
        prediction
}

shinyServer(function(input, output) {
        # function call        
        output$Predict <- renderPrint({prediction(input$text)}) 
        
})