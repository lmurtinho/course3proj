# Getting and Cleaning Data
This repo contains the script "run_analysis.R", which takes as input a zipped file found in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and returns a tidy data set with the average of every mean and standard deviation measured in the train and test sets, summarized by subject and by activity.

## Input files
These are the files used as input (all can be found on the zipped file linked above):
* y_test.txt: lists (as a number) the activities performed by the test subjects
* subject_test.txt: lists (as a number) the subjects who performed the test session
* X_test.txt: lists the results of the tests
* y_train.txt: lists (as a number) the activities performed by the test subjects
* subject_train.txt: lists (as a number) the subjects who performed the training session
* X_train.txt: lists the results of the tests
* features.txt: lists the names of the 561 measurements taken for each test/training session
* activities_labels.txt: numbers from 1 to 6 the activities performed by the subjects

## Result
The script returns a data set with the average value of the 66 means and standard deviations of the measures presented in the train and test files, for each subject and each activity. Since there are 30 subjects and 6 activities, there are 180 rows of data in the output.

## Step by step
Below I describe each step of the script~. The lines mentioned in the heading refer to the lines of the "run_analysis.R" file (last commit).

### 1. Unzipping the file (lines 6-8)
Checks if there already exists the folder that will be created once the zipped file is unzipped. If the folder is there, the script assumes all the input files (see above) are there as well, in the same path as after they were unzipped. If there is no such folder, the zipped file is unzipped.

Once step 1 is done, all input files can be accessed by the script. 

### 2. Merging the test and train data sets into one (lines 13-28)

#### 2.1 Getting the test data set (lines 13-17)
Takes from the test input files the activities performed (as numbers), the subjects of the test session and the results of the session, and column-binds all data in a single data set. After the single data set is created, eliminate the tables with partial data.

#### 2.2 Getting the train data set (lines 20-24)
Same as 2.1, but for the train data.

#### 2.3 Merging data sets (lines 27-28)
Row-binds the train and test sessions into a single data set, and eliminate the partial data sets used to build this single one.

Once step 2 is done, the data from the test and train sessions are in a single table in R.

### 3. Extracting the mean and the standard deviation of each measurement (lines 33-52)

#### 3.1 Getting the label of the featured measures (line 33)
Gets from an input file the labels of each of the 561 measurements performed.

#### 3.2 Preparing vectors to store information (lines 36-37)
Creates vectors to store the indices of the columns to keep (those with the mean and standard deviation of the measurements) and the names of these columns.

#### 3.3 Looping through the measurement labels to find the columns of interest (lines 41-48)
Start a count from 2 (the first two columns of the data set have info on activity and subject, not on measurements). For each label in the vector created in 3.1, increments the count by one and checks if the label contains the exact strings "mean()" or "std()". If so, appends the count to the vector of columns to keep and the label to the vector of column names.

#### 3.4 Getting rid of undesired columns (line 52)
Keeps on the data set only the two first columns (with subject and activity info) plus all columns whose indices are in the vector of columns to keep.

Once step 3 is done, the data set contains only the subject, the activity and the mean and standard deviation of all measurements performes (66 variables and 68 columns in total).

### 4. Naming activities in data set (lines 57-61)

#### 4.1 Getting activity labels from input file (line 57)
Gets from an input file ordered labels for the six activities performed by the subjects.

#### 4.2 Replacing activity number with activity label (line 61)
Replace each number in the activity column on the data set with the label corresponding to the number in the vector created in 4.1.

Once step 4 is done, the activities are listed with their names in the data sets.

### 5. Renaming columns (lines 64-105)
Check each activity name to define the following characteristics:
* Is the measurement on the time domain, or on the frequency domain? (line 69)
* Does the measurement refer to an axis? If so, which one (X, Y, or Z)? (lines 72-83)
* Does the signal refer to body or gravitational motion? (line 86)
* Was the signal taken with the accelerometer or with the gyroscope? (line 89)
* Is it a measurement of jerk signals? (line 92)
* Is it a measurement of magnitude? (line 95)
* Is it the mean or the standard deviation? (line 98)
With all this established, creates a full name for the column, expanding on the abbreviations used in the input files, and substitutes the expanded name for the abbreviated one in the vector with column names (lines 101-102).
Replace the actual column names with the names on the vector described above (line 105).

Once step 5 is done, all measurement columns of the data set have descriptive names.

### 6. Creating data set with average of each measurement for each subject and each activity (lines 111-122)

#### 6.1 Replacing columns with the activity and the subject with a single column comprising both (lines 111-113)
Adds trailing zeros to subject number (otherwise subject 1 would be followed by subject 10 in the final data set; this way, subject 01 is followed by subject 02) and pastes together in a new vector this formatted subject number and the activity of the row. Then column-binds this vector to the 3rd column of the data set on (getting rid of the two first columns, with activity and subject).

#### 6.2 Summarising the data set and getting the average of each variable by subject and by activity (lines 117-122)
If necessary, installs the dplyr package. Then groups the database by the column with subject and activity, and summarises each column using the mean function to get the average.

Once step 6 is done, the data set comprises 180 rows (each of the 6 activities times each of the 30 subjects) and 67 columns (the column with subject and activity plus 66 columns with variables). Each cell (i, j) represents the average measurement j for the subject and activity in i.

### 7. Replacing activity and subject in separate columns (lines 125-127)
Creates a vector with the subjects per row of the data set and another with the activities per row. Column-binds these two vectors and the data set, excluding the column with subject and activity combined.

Once step 7 is done, the data set is done.

### 8. Removing unnecessary data (line 130)
Removes from the environment everything but the data set created above.

Once step 8 is done, the script is done.