setwd("F:/Data Science/9. Developing Data Products/Week4/Project")
getwd()

BMI <- function(weight, height) {
        heightSqr <- height ^ 2
        BMI <- weight / heightSqr
        BMI
        
        if (BMI < 18.5) {
                print("You are underweight")
        }
        else if (BMI >= 18.5 && BMI <= 25) {
                print("Your weight is ideal")
        }
        else if (BMI > 25 && BMI <= 30) {
                print("You are overweight")
        }
        else if (BMI > 30) {
                print("Your weight is obese")
        }
}

weightClassification <- function(BMI) {
        if (BMI < 18.5) {
                print("You are underweight")
        }
        else if (BMI >= 18.5 && BMI <= 25) {
                print("Your wieght is ideal")
        }
        else if (BMI > 25 && BMI <= 30) {
                print("You are overweight")
        }
        else if (BMI > 30) {
                print("Your weight is obese")
        }
}