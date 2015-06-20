# Code Book
This is the code book for the data set returned by the "run_analysis.R" script

## Dimensions
The data set has 180 rows and 68 columns. Each of the rows corresponds to an item in the combination between 30 subjects and the 6 activities they performed. The first column indicate the subject; the second columns, the activity; and the last 66 refer to the mean and standard deviation of several features measured during the activities.

## Values
Each item (i, j), j > 2 in the data set records the average of measurement j for the subject (i, 1) while performing the activity (i, 2). All of the original values whose average is presented here were normalized and bounded within [-1, 1] (see readme file for the raw data files).

## Descriptions
Column 1: The subject who performed the activities (numbered from 01 to 30).
Column 2: The activity performed. 6 possibilities: "Laying", "Sitting", "Standing", "Walking", "Walking Downstairs" and "Walking Upstairs").
Columns 3-8: averages of mean and standard deviation of body measurements from the accelerometer in X, Y and Z axes (in the time domain). 
Columns 9-14: averages of mean and standard deviation of gravity measurements from the accelerometer in X, Y and Z axes (in the time domain).
Columns 15-20: averages of mean and standard deviation of jerk signal measurements from the accelerometer in X, Y and Z axes (in the time domain).
Columns 21-26: averages of mean and standard deviation of body measurements from the gyroscope in X, Y and Z axes (in the time domain).
Columns 27-32: averages of mean and standard deviation of jerk signal measurements from the gyroscope in X, Y and Z axes (in the time domain).
Columns 33-34: averages of mean and standard deviation of body measurements magnitude from the accelerometer (in the time domain).
Columns 35-36: averages of mean and standard deviation of gravity measurements magnitude from the accelerometer (in the time domain).
Columns 37-38: averages of mean and standard deviation of jerk signal measurements magnitude from the accelerometer (in the time domain).
Columns 39-40: averages of mean and standard deviation of body measurements magnitude from the gyroscope (in the time domain).
Columns 41-42: averages of mean and standard deviation of jerk signal measurements magnitude from the gyroscope (in the time domain).
Columns 43-48: averages of mean and standard deviation of body measurements from the accelerometer in X, Y and Z axes (in the frequency domain).
Columns 49-54: averages of mean and standard deviation of jerk signal measurements from the accelerometer in X, Y and Z axes (in the frequency domain).
Columns 55-60: averages of mean and standard deviation of body measurements from the gyroscope in X, Y and Z axes (in the frequency domain).
Columns 61-62: averages of mean and standard deviation of body measurements magnitude from the accelerometer (in the frequency domain).
Columns 63-64: averages of mean and standard deviation of jerk signal measurements magnitude from the accelerometer (in the frequency domain).
Columns 65-66: averages of mean and standard deviation of body measurements magnitude from the gyroscope (in the frequency domain).
Columns 67-68: averages of mean and standard deviation of jerk signal measurements magnitude from the gyroscope (in the frequency domain).