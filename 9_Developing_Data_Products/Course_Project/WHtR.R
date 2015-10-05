setwd("F:/Data Science/9. Developing Data Products/Week4/Project")
getwd()

WHtR <- function(waist, height) {
        
        WHtR <- round((waist / height) * 100)
        #print(WHtR)
        print(paste0("Your waist circumference is ", WHtR, "% of your height."))
        
        if (waist <= (height / 2)) {
                print("This can help you to increase your life expectancy.")
        }
        if (waist > (height / 2)) {
                print("Your WHtR is not ideal.")
        }
}