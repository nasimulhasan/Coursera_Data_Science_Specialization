library(shinyapps)

shinyUI(fluidPage(
        titlePanel("Next Word Predictor"),
        
        sidebarLayout(
                      sidebarPanel(
                              textInput("text", 
                                        label = h4("Input Phrase"), 
                                        value = "Enter a phrase..."),
                                                            
                              submitButton('Predict')
                                        ),
                      mainPanel(
                              br(),
                              h4("Predicted next word"),
                              textOutput("Predict")
                                   
                                )
        )
))

