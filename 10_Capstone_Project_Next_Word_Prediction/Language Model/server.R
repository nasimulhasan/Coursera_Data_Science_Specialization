library(shiny)
library(markovchain)

load("train.token.RData")
#t <- train.token[1:10]

model.fit <- markovchainFit(data = train.token,
                            method = "mle"
                            )

prediction <- function(phrase) {
        phrase <- as.vector(unlist(strsplit(phrase, " ", fixed = TRUE)))
        
        if (phrase[length(phrase)] %in% train.token) {
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