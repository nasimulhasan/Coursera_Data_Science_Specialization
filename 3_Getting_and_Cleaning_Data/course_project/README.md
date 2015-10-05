Description of the run_analysis.md script:

1. setup the working directory

2.load the required files such as subject_train, y_train, X_train, subject_test, y_test ,X_test, features and activity_labels, and then check out their dimension

3.In step 3 label the columns with column names from features files

4(a). Bind the training set column wise using cbind() function
4(b). Bind the test set column wise using cbind() function
4(c). Finally, bind both the training set and test set row wise using rbind() function and test the resulted file

5. Extract the mean and standard deviation for each measurement
using subsetting technique and cbind() function and check the data set

6. find out the activity and replace the activity with descriptive #activity names and check for sure.

7. Now, split the data set based on the two variables such as
activity and subject, and compute the column means of the 
data set using sapply() and colMeans.Then, compute the transpose 
of the resulted data set and test the dimension, column names and row names. That is the required tidy data.

8. Finally, write the tidy data to a .txt file named as
"TidyData.txt" using write.table() function where seperator is
tab, row name is FALSE and column name is TRUE.Then, read the 
tidy data using read.table() function and test the dimension.