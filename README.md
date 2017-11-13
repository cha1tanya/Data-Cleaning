# Data-Cleaning

Subject: Human Activity Recognition Using Smartphones Dataset - Preliminary analysis

Version: 1.0

Author: Chaitanya R.

Date: 2017-11-12

Human Activity Recognition Using Smartphones Dataset is used for this analysis. The dataset has train and test samples in seperate folders. Full description of the folders and the features in each of the folder may be found in README.txt file provided along with the dataset.

The following steps were taken to find the means of selected variables in "run_analysis.R".

1. Both x and y variables were read into seperate datasets, along with the IDs of subjects that were part of the study.
2. Features in x variable dataset are shared in a seperate dataset. They are first cleaned to substitute dash(-) for dot(.) and the paranthesis in the names removed. These features are then used as column names for x variables.
3. The 3 datasets which were read in step 1 above are then combined using cbind function to form a single train dataset
4. Above process is repeated to create a testing dataset
5. Both training and testing datasets are combined using rbind function. This dataset is "TrainAndTestData"
6. Measurements having mean and standard deviations are filtered using grep function. 
7. To convert the activity IDs to activity labels, inner join has been performed and columns reordered.
8. This data is grouped by the subject id and activity and mean of all other variables computed using summarise_all function

The final file is written to a text file using write.table function.
