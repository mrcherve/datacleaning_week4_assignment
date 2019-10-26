## Merges the training and the test sets to create one data set.

#Import features data - NOT OK
features_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/features.txt"
features <-read.delim(features_url, header = FALSE,sep="")
colnames(features)<-c("n","calc")
#col_name<-as.character(features$calc)

# Import subject_train data
train_subject_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/train/subject_train.txt"
train_subject <- read.delim(train_subject_url,header=FALSE)
colnames(train_subject) <- "subject"

# Import X_train data
train_data_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/train/X_train.txt"
train_data <- read.delim(train_data_url, header=FALSE, sep="",col.names = features$calc)
#colnames(train_data)=col_name

# Import y_test data
train_y_data_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/train/y_train.txt"
train_y_data <- read.delim(train_y_data_url, header=FALSE,sep = "")
colnames(train_y_data)="class"

# Import subject_test data
test_subject_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/test/subject_test.txt"
test_subject <- read.delim(test_subject_url, header=FALSE)
colnames(test_subject) <- "subject"

# Import X_test data
test_data_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/test/X_test.txt"
test_data <- read.delim(test_data_url, header=FALSE,sep = "",col.names = features$calc)
#colnames(test_data)=col_name

# Import y_test data
test_y_data_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/test/y_test.txt"
test_y_data <- read.delim(test_y_data_url, header=FALSE,sep = "")
colnames(test_y_data)="class"

# Import activities
activity_data_url <- "C:/Users/mikael.herve/Documents/R/run_analysis/activity_labels.txt"
activity <- read.delim(activity_data_url, header=FALSE,sep = "")
colnames(activity)=c("class","activity")

final_test<-cbind(test_y_data,test_subject, test_data)
final_train<-cbind(train_y_data,train_subject, train_data)

#merge test and train data
final<-rbind(final_test,final_train)

## Extracts only the measurements on the mean and standard deviation for each measurement
extract<-final %>% select(subject,class, contains("mean"),contains("std"))

## Uses descriptive activity names to name the activities in the data set
extract$class<-activity[extract$class,2]

## Appropriately labels the data set with descriptive variable names
names(extract)[2]="activity"
names(extract)<-gsub("Acc","Acceleration",names(extract))
names(extract)<-gsub("Mag","Magnitude",names(extract))
names(extract)<-gsub("Gyro","Gyroscope",names(extract))
names(extract)<-gsub("Freq","Frequency",names(extract))
names(extract)<-gsub("BodyBody","Body",names(extract))
names(extract)<-gsub("std","Standard_Deviation",names(extract))
names(extract)<-gsub("^t","Time",names(extract))
names(extract)<-gsub("^f","Frequency",names(extract))

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
extract_final <- extract %>% group_by(subject,activity) %>% summarize_all(funs(mean))

## Write output for submission 
write.table(extract_final,"C:/Users/mikael.herve/Documents/R/run_analysis/extract_final.txt",row.names = FALSE)
