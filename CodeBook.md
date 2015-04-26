# Codebook

## What we do to clean up the data

This script (run_analysis.R) merges the training and the test sets, extracts only the measurements on the mean and standard deviation for each measurement.  

To do this, we filter `-mean()` and `-std()` variables.  

Than script extract activity labels and make them more user friendly by applying lowercase and removing underscores. This activity labels used for naming activity data.  

Save cleaned data set to the `merged_clean_set.txt` file.  

Than script create a second, independent data set with the average of each variable for each activity and each subject. To do this, we create an empty data set `avg_data` and fills row-by-row with colMeans() of original data.
