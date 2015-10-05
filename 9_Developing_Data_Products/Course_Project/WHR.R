setwd("F:/Data Science/9. Developing Data Products/Week4/Project")
getwd()

WHR <- function(waist, hip) {
        
        WHR <- waist / hip
        p <- paste0("Your waist size is ", round(WHR * 100), "% of your hip size.")
        print(p)
        
        # male WHR
        if (WHR < .9) {
                print("Male: Low risk of cardiovascular health problems.")
        }
        if (WHR >= .9 && WHR <= .99) {
                print("Male: Moderate risk of cardiovascular health problems.")
        }
        if (WHR > .99) {
                print("Male: High risk of cardiovascular problems.")
        }
        
        #female WHR
        if (WHR < .8) {
                print("Female: Low risk of cardiovascular health problems.")
        }
        if (WHR >= .8 && WHR <= .89) {
                print("Female: Moderate risk of cardiovascular health problems")
        }
        if (WHR >= .9) {
                print("Female: High risk of cardiovascular problems")
        }
}