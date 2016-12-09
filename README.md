# GettingCleaningData

In order to create a new tidy data set based on data collected from the accelerometers from the Samsung Galaxy S smartphone, the following steps were taken:

1. create function run_analysis
2. load libraries
3. read the all data sets into the RAM
4. labels the data set with descriptive variables names, renaming all the Vs.
5. merge the trainning and the test sets to create one data set using rbind
6. use select from dplyr to pick only column names that cointans mean ou std
7. use descriptive activity names to name the activities in the data set
8. make a tidy data set by using the gather function from
9. use group_by and summarize to make the second tidy data set

The code with detailed implementation is provided in the GITHUB folder.

I also provide a code book for those who would like to undertand the variables from those data sets.
