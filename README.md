# GetingAndCleaningData
This repositiory is created to store artifacts for the final project.

Summary: The run_analysis.R script reads the test and training data files seperately, and merges them to create a tidy data set, which summarizes the mean, and standard deviation of each input variables by Subject, and by Activity types.

It performs following steps to arrive at final output.

1. It reads the feature file to store column names in a data frame.
2. It reads test data sets.
3. It changes the column names on the data set to provide meaningful names.
4. It merges the three data sets read in the prior steps.
5. It performs step 2 to 4 for the training data set.
6. Next, new data frames is created to store only those columns which have "mean" or "std" in the their column names.
7. Next, new data frames are merged togather to comeup with a new data set, which contains Subject, Activity, and mean/std for the original variables.
8. Column names are changed to provide meaningful names.
9. Finally an aggregation is performed to summarize the data set by Subject, and Activity on the means of each variables.
