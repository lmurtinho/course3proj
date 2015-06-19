# Script to clean up data from accelerometers
# Zip file with data must be in working directory

# 1. Unzip files (if necessary)
if (!file.exists("./UCI HAR Dataset")) {
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

# 2. Merge sets into one data set

# 2.1. Get the test data set
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test <- cbind(test_labels, test_subjects, test_set)
remove(test_set, test_labels, test_subjects)

# 2.2 Get the train data set
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train <- cbind(train_labels, train_subjects, train_set)
remove(train_labels, train_subjects, train_set)
  
# 2.3 Merge data sets
ds <- rbind(test, train)
remove(test, train)
  
# 3. Extract mean and standard deviation for each measurement
features <- read.table("./UCI HAR Dataset/features.txt")[, 2]
to_keep <- c()                              # Vector to store indices of columns to keep
column_names <- c("Activity", "Subject")    # Vector to store names of columns to keep
count <- 2                                  # The first two columns are activity and subject!

# 3.1 Loop each element of the features vector to find out
#     in which columns the means and standard deviations are
for (feature in features) {
  count <- count + 1
  if (grepl("mean()", feature, fixed = TRUE) || grepl("std()", feature, fixed = TRUE)) {
    to_keep <- append(to_keep, count)
    column_names <- append(column_names, feature)
  }
}

# 3.2 Keep only the first two columns plus those
#     with means and standard deviations
ds <- ds[,c(1, 2, to_keep)]
  
# 4. Name activities in data set

# 4.1 Get activity labels from file
activity_labels <- as.character(read.table("./UCI HAR Dataset/activity_labels.txt")[, 2])

# 4.2 Use number in activity col as indices to find activity label
#     and replace number with label
ds[,1] <- activity_labels[ds[,1]]

# 5. Name variables
for (i in 3:length(column_names)) {
  
  abbrev <- column_names[i]
  
  # 5.1 Get domain
  domain <- ifelse(substring(abbrev, 1, 1) == "t", "time domain - ", "frequency domain - ")
  
  # 5.2 Get axis
  if (grepl("X", abbrev)) {
    axis <- "X Axis "
  }
  else if (grepl("Y", abbrev)) {
    axis <- "Y Axis "
  }
  else if (grepl("Z", abbrev)) {
    axis <- "Z Axis "
  }
  else {
    axis <- ""
  }
  
  # 5.3 Get signal source
  signal_source <- ifelse(grepl("Body", abbrev), "Body ", "Gravity ")

  # 5.4 Get tool
  tool <- ifelse(grepl("Acc", abbrev), "Accelerator ", "Gyroscope ")
  
  # 5.5 Check for jerk signal
  jerk <- ifelse(grepl("Jerk ", abbrev), "Jerk", "")
  
  # 5.6 Check for magnitude
  mag <- ifelse(grepl("Mag", abbrev), "Magnitude ", "")
  
  # 5.7 Get variable
  variable <- ifelse(grepl("mean()", abbrev), "- mean", "- standard deviation")
  
  # 5.8 Paste strings
  full_name <- paste(domain, axis, signal_source, tool, jerk, mag, variable, sep="")
  column_names[i] <- full_name
}  

names(ds) <- column_names

# 6. Create data set with average of each variable for each
#    activity and each subject