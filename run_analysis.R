# Merges the training and the test sets to create one data set.

# Change this path to your correct working directory with 
# Human Activity Recognition Using Smartphones Dataset
# and this script.

setwd('/home/babl/coursera/Getting_and_Cleaning_Data/cp/coursera-3-3/')

x_train<-read.table("train/X_train.txt")
x_test<-read.table("test/X_test.txt")
x_set<-rbind(xtrain, xtest)

subj_train<-read.table("train/subject_train.txt")
subj_test<-read.table("test/subject_test.txt")
subj_set <- rbind(subjtrain, subjtest)

y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
y_set<-rbind(ytrain, ytest)


# Extracts only the measurements on the mean and standard deviation for each measurement. 

features<-read.table("features.txt")
features_mean_std <- features$V2 %like% '-mean\\(\\)' | features$V2 %like% '-std\\(\\)'
x_set<-x_set[,features_mean_std]

namesx<-features[features_mean_std, 2]
namesx<-gsub("\\(|\\)", "", namesx)
names(x_set)<-namesx


# Uses descriptive activity names to name the activities in the data set

activity_labels<-read.table("activity_labels.txt")
activity_good_labels<-tolower(activity_labels[, 2])
activity_good_labels<-gsub("_", "", activity_good_labels)
activity_labels[, 2] = activity_good_labels
y_set[,1] = activity_labels[y_set[,1], 2]
names(y_set) <- "activity"


# Appropriately labels the data set with descriptive variable names.

names(subj_set) <- "subject"
cleaned_set <- cbind(subj_set, y_set, x_set)
write.table(cleaned_set, "merged_clean_set.txt", row.name=FALSE)


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subj_uniq<-unique(subj_set)[,1]
set_cols_num<-dim(cleaned_set)[2]

# new data set contains cols with cleaned_set names
avg_set<-cleaned_set[0,]

counter<-1
for (subj_iter in 1:length(subj_uniq)) {
  for (activity_iter in 1:length(activity_labels[,1])) {
    row_condition<-cleaned_set$subject==subj_iter & cleaned_set$activity==activity_labels[activity_iter, 2]
    row<-cleaned_set[row_condition, ]

    avg_set[counter, 1] = subj_uniq[subj_iter]
    avg_set[counter, 2] = activity_labels[activity_iter, 2]
    avg_set[counter, 3:set_cols_num] <- colMeans(row[, 3:set_cols_num])

    counter<-counter+1
  }
}

write.table(avg_set, "avg_data_set.txt", row.name=FALSE)

