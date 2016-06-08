## Code Book

### Input Data

The data set can be downloaded [here](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip). A description of the data can be found at the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Data Transformation

The R script `run_analysis.R` performs the following steps:

1. Downloads the dataset if not available
2. Loads both the activities and features - `activity_labels.txt` and `features.txt`
3. Loads the train and test data - `X_train.txt`, `X_test.txt`, `y_train.txt`, and `y_test.txt`
4. Loads the subject data - `subject_train.txt` and `subject_test.txt`
5. Keeps only the measurements on the mean and standard deviation
6. Adds descriptive names for variables
7. Merges the data into a single dataset
8. Averages the data for each activity type and subject
9. Exports a tidy dataset with the averages in a file called `tidy_data.txt`

### Details

- `activity_types` - contains the `activity_labels.txt`  
- `features` - contains the `features.txt`  
- `x_train` - contains the `X_train.txt`  
- `x_test` - contains the `X_test.txt`  
- `x_data` - contains the `x_train` and `x_test` data these are combined using `rbind()`
- `y_train` - contains the `y_train.txt`  
- `y_test` - contains the `y_test.txt`  
- `y_data` - contains the `y_train` and `y_test` data these are combined using `rbind()`
- `subject_train` - contains the `subject_train.txt`  
- `subject_test` - contains the `subject_test.txt`  
- `subject_data` - contains the `subject_train` and `subject_test` data these are combined using `rbind()`
- `features_wanted` - is a numeric vector of the column names with mean and standard deviation, used for filtering the data needed
- `all_data` - contains the combined datasets of `subject_data`, `y_data`, and `x_data`
- `average_data` - contains the mean value for each measurement when groupoed by `subject_id` and `activity_name`

### Dependencies

In order to execute the script, the `dplyr` library is required. 


