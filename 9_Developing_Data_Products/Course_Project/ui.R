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