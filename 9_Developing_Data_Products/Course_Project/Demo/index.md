---
title       : Project Presentation
subtitle    : Developing Data Products
author      : Mohamed Taufeeq
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---
## Ideal Body Weight (IBW)

To determine how much you should weigh (your ideal body weight) several factors should be considered, including age, muscle-fat ratio, height, sex, and bone density. 

This app will help you to detemine your IBW using the three standard approaches.


Body Mass Index (BMI) 
=====================
Your BMI is your weight in relation to your height. 

```r
weight <- 80
height <- 1.8
BMI <- weight/(height^2)
if (BMI >= 18.5 && BMI <= 25) {
    print("Your weight is ideal")
}
```

```
## [1] "Your weight is ideal"
```


---

Waist-Hip Ratio (WHR) 
=====================
A waist-hip measurement is the ratio of the circumference of your waist to that of your hips.

```r
waist <- 28
hip <- 36
WHR <- waist/hip
WHR
```

```
## [1] 0.7778
```


Waist-to-Height Ratio
=====================

```r
waist <- 91
height <- 183
if (waist <= (height/2)) {
    print("This can help you to increase your life expectancy.")
}
```

```
## [1] "This can help you to increase your life expectancy."
```

```r
if (waist > (height/2)) {
    print("Your WHtR is not ideal.")
}
```


---

## ui.R chunk
Below is the code snippet of the ui.R

```r
library(shiny)

shinyUI(pageWithSidebar(
        
        headerPanel("Ideal body weight"),
        
        sidebarPanel(                
                h3('Body Mass Index(BMI)'),
                p('Your BMI is your weight in relation to your height.'),
                
                numericInput(
                        'weight',
                        'Weight in kilogram(kg)',
                        0,
                        min = NA,
                        max = NA,
                        step = NA
                ),
                
                numericInput(
                        'height',
                        'Height in centi-meter(cm)',
                        0,
                        min = NA,
                        max = NA,
                        step = NA),
                
                submitButton('Your BMI')
                ),
        mainPanel(
                h3('Result of BMI Measurement'),
                
                h4('Your weight in kg'),
                p('Example: 95'),
                verbatimTextOutput("weight")
                )
        ))
```


---

## server.R chunk

Here the code snippet of the server.R

```r
shinyServer(function(input, output) {
    output$weight <- renderPrint({
        input$weight
    })
    output$height <- renderPrint({
        input$height
    })
    output$height1 <- renderPrint({
        input$height1
    })
    output$waist <- renderPrint({
        input$waist
    })
    output$waist1 <- renderPrint({
        input$waist1
    })
    output$hip <- renderPrint({
        input$hip
    })
    
    # call required function
    output$BMI <- renderPrint({
        BMI(input$weight, input$height)
    })
    output$WHR <- renderPrint({
        WHR(input$waist, input$hip)
    })
    output$WHtR <- renderPrint({
        WHtR(input$waist1, input$height1)
    })
})
```

