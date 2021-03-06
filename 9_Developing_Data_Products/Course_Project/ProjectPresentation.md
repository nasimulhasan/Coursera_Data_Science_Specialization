Ideal Body Weight (IBW)
========================================================
To determine how much you should weigh (your ideal body weight) several factors should be considered, including age, muscle-fat ratio, height, sex, and bone density. 

This app (Shiny.io link: https://mtaufeeq.shinyapps.io/Project/) will help you to detemine your IBW using three standard approaches.

Body Mass Index (BMI) 
=====================
Your BMI is your weight in relation to your height. 

```r
weight <- 80
height <- 1.8
BMI <- weight/(height^2)
BMI
```

```
## [1] 24.69
```


Waist-Hip Ratio (WHR) 
=====================
A waist-hip measurement is the ratio of the circumference of your waist to that of your hips.

```r
waist <- 28
hip <- 36
WHR <- waist/hip
p <- paste0("Your waist size is ", round(WHR * 100), "%  of your hip size.")
print(p)
```

```
## [1] "Your waist size is 78%  of your hip size."
```


Waist-to-Height Ratio (WHtR)
============================


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


UI 
==

```r
library(shiny)

shinyUI(pageWithSidebar(
        
        headerPanel("Ideal body weight"),
        
        sidebarPanel(
                h3('How Much Should you Weigh For your Age & Height?'),
                p('To determine how much you should weigh
                  (your ideal body weight) several factors
                  should be considered, including age, 
                  muscle-fat ratio, height, sex, and bone 
                  density. This app consists of three standard 
                  approach of compute the weight. You can find out
                  your ideal weight using this app.'),
                
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
                
                submitButton('Your BMI'),
                
                h3('Waist-Hip Ratio(WHR)'),
                p('A waist-hip measurement is the ratio of the circumference of your waist to that of your hips.'),
                
                numericInput(
                        'waist',
                        'Waist in centi-meter(cm)',
                        0,
                        min = NA,
                        max = NA,
                        step = NA
                ),
                
                numericInput(
                        'hip',
                        'Hip in centi-meter(cm)',
                        0,
                        min = NA,
                        max = NA,
                        step = NA
                ),
                
                submitButton('Your WHR'),
                
                h3('Waist-to-Height Ratio'),
                p('A waist-to-height measurement is the ratio of the circumference of your waist to that of your heights.'),
                
                numericInput(
                        'waist1',
                        'Waist in centi-meter(cm)',
                        0,
                        min = NA,
                        max = NA,
                        step = NA
                ),
                
                numericInput(
                        'height1',
                        'Height in centi-meter(cm)',
                        0,
                        min = NA,
                        max = NA,
                        step = NA),
                
                submitButton('Your WHtR'),
                
                h5('Note: WHR and WHtR are more accurate than BMI.')
               
        ),
        
        mainPanel(
                h3('Result of BMI Measurement'),
                
                h4('Your weight in kg'),
                p('Example: 95'),
                verbatimTextOutput("weight"),
                
                h4('Your height in cm'),
                p('Example: 120'),
                verbatimTextOutput("height"),
                
                h4('Your BMI'),
                p('Example: '),
                p('[1] "BMI: 65.9722222222222"'),
                p('[1] "According to Health authorities your are obese"'),
                p('Do not worry about this: "Error: missing value where TRUE/FALSE needed"'),
                verbatimTextOutput("BMI"),
                
                h3('Result of WHR Measurement'),
                
                h4('Your waist in centi-meter(cm)'),
                p('Example: 28'),
                verbatimTextOutput("waist"),
                
                h4('Your hip in centi-meter(cm)'),
                p('Example: 36'),
                verbatimTextOutput("hip"),
                
                h4('Your WHR'),
                p('Example: '),
                p('[1] "Your waist size is 78% of your hip size."'),
                p('[1] "Male: Low risk of cardiovascular health problems."'),
                p('[1] "Female: Low risk of cardiovascular health problems."'),
                p('Do not worry about this: "Error: missing value where TRUE/FALSE needed"'),
                verbatimTextOutput("WHR"),
                
                h3('Result of WHtR Measurement'),
                
                h4('Your waist in centi-meter(cm).'),
                p('Example: 83'),
                verbatimTextOutput("waist1"),
                
                h4('Your height in centi-meter(cm).'),
                p('Example: 175'),
                verbatimTextOutput("height1"),
                
                h4('Your WHtR'),
                p('Example: '),
                p('[1] "Your waist circumference is 47% of your height."'),
                p('[1] "This can help you to increase your life expectancy."'),
                p('Do not worry about this: "Error: missing value where TRUE/FALSE needed"'),
                verbatimTextOutput("WHtR")
                
        )
))
```


Server.R
========

```r
#measure body mass index
BMI <- function(weight, height) {
        
        #compute bmi
        heightSqr <- (height / 100) ^ 2
        BMI <- weight / heightSqr
        
        p <- paste0("BMI: ", BMI)
        print(p)
        
        #filter out weight quality based on bmi
        if (BMI < 18.5) {
                print("According to Health authorities you are underweight")
        }
        else if (BMI >= 18.5 && BMI <= 25) {
                print("According to Health authorities your weight is ideal")
        }
        else if (BMI > 25 && BMI <= 30) {                
                print("According to Health authorities you are overweight")
        }
        else if (BMI > 30) {
                print("According to Health authorities your are obese")
        }
}

#measure Waist Hip Ratio
WHR <- function(waist, hip) {
        
        #compute Waist Hip Ratio
        WHR <- waist / hip
        p <- paste0("Your waist size is ", round(WHR * 100), "% of your hip size.")
        print(p)
        
        # male WHR
        #filter out cardiovascular health problems for male based on WHR
        if (WHR < .9) {
                print("Male: Low risk of cardiovascular health problems.")
        }
        if (WHR >= .9 && WHR <= .99) {
                print("Male: Moderate risk of cardiovascular health problems.")
        }
        if (WHR > .99) {
                print("Male: High risk of cardiovascular health problems.")
        }
        
        #female WHR
        #filter out cardiovascular health problems for female based on WHR
        if (WHR < .8) {
                print("Female: Low risk of cardiovascular health problems.")
        }
        if (WHR >= .8 && WHR <= .89) {
                print("Female: Moderate risk of cardiovascular health problems")
        }
        if (WHR >= .9) {
                print("Female: High risk of cardiovascular health problems")
        }
}

#measure Weight to Height Ratio (WHtR)
WHtR <- function(waist1, height1) {
        
        #compute Weight to Height Ratio
        WHtR <- round((waist1 / height1) * 100)        
        p <- paste0("Your waist circumference is ", WHtR, "% of your height.")
        print(p)
        
        #classify life expectancy based on WHtR
        if (WHtR <= 50) {
                print("This can help you to increase your life expectancy.")
        }
        if (WHtR > 50) {
                print("Your WHtR is not ideal.")
        }
}

shinyServer(
        function(input, output) {
                output$weight <- renderPrint({input$weight})
                output$height <- renderPrint({input$height})
                output$height1 <- renderPrint({input$height1})
                output$waist <- renderPrint({input$waist})
                output$waist1 <- renderPrint({input$waist1})
                output$hip <- renderPrint({input$hip})
                
                #call required function
                output$BMI <- renderPrint({BMI(input$weight, input$height)})   
                output$WHR <- renderPrint({WHR(input$waist, input$hip)})
                output$WHtR <- renderPrint({WHtR(input$waist1, input$height1)})
        }
       
)

```

