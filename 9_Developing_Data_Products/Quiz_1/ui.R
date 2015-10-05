setwd("F:/Data Science/9. Developing Data Products/Week1/Assessment")

library(shiny)
shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Diabetes prediction"),
                sidebarPanel(
                        numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
                        submitButton('Submit')
                ),
                mainPanel(
                        h3('Results of prediction'),
                        h4('You entered'),
                        verbatimTextOutput("inputValue"),
                        h4('Which resulted in a prediction of '),
                        verbatimTextOutput("prediction")
                )
        )
)