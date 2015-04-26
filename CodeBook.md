# Codebook

## What we do to clean up the data

This script (run_analysis.R):

- merges the training (`train/X_train.txt`) and the test (`test/X_test.txt`) data sets. The result has a dimension 10299x561 where 561 - number of attributes from feature.txt; subject data frame (`train/subject_train.txt with` and `test/subject_test.txt`) contains subject IDs, the dimension is: 10299x1; and the activities data frame (`train/y_train.txt` and `test/y_test.txt`) contains activity IDs, the dimension is: 10299x1

- extracts only the measurements on the mean and standard deviation for each measurement. To do this, we filter `-mean()` and `-std()` variables from feature.txt. The result dimension is 10299x66

- applies descriptive activity labels to the data set (names of activities by id in data set). To make activities more user friendly, script remove underscores and apply tolower to labels

- save cleaned data set to the `merged_clean_set.txt` file

> The dimension of the data set in merged_clean_set.txt is:

> ```
> > dim(cleaned_set)
> [1] 10299    68
> ``` 

> 66 measurement columns, 1 subject and 1 activity column.

> The list of activities: `id` - `descriptive name`:

> | id |           descriptive name |
| ------------- | -----:|
> | 1 |           walking |
> | 2 |   walkingupstairs |
> | 3 | walkingdownstairs |
> | 4 |           sitting |
> | 5 |          standing |
> | 6 |            laying |
> 

- create a second, independent data set with the diaverage of each variable for each activity and each subject. To do this, we create an empty data set `avg_data` and fills row-by-row with calling `colMeans()` to original data.

- save second data set to the `avg_data_set.txt` file

> The dimension of the data set in avg_data_set.txt is:

> ```
> > dim(avg_set)
> [1] 180  68
> ```
