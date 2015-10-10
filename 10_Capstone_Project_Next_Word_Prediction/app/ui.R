library(shinyapps)

shinyUI(fluidPage(
        #titlePanel("Next Word Predictor"),
        h2("Next Word Predictor",
           style = "color: #0A5680;"),        
        
        sidebarLayout(
                      sidebarPanel(
                              textInput("text", 
                                        label = h4("Phrase",
                                                   style = "color: #16789E;"), 
                                        value = "Type a phrase..."),
                                                            
                              submitButton('Predict')
                              ),
                      
                      mainPanel(
                              br(),
                              h4("Predicted next word",
                                 style = "color: #11A816;"),
                              
                              h5(textOutput("Predict"))
                              )
        ),
        
        p("S.N.: Reviewing this app may take couple of minutes of your time.
          Please, be patient. In case of gray out screen, 
          refresh or reload the link. Thank you.", style = "color:#5E6063")
        
))

