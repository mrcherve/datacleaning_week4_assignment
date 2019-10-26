The purpose of the readme is to show how the "run_analysis" script works

The scripts takes as input the following files:
*features: List of all features of the X_train and X_test data.
*subject_train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
*subject_test: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
*X_train: Training set
*y_train: Training labels
*X_test: Test set
*y_test: Test labels
*activity_labels: Links the class labels with their activity name.  Class range from 1 to 6.

All files are loaded into separate tables, and in case no headers are found, headers are added back.
The following mergers then take place:
*test data,test subject, test labels for the test group
*train data, train subject, train labels for the training group
*once two above are done, the test group and training group are then merged

The script then select the relevant column variable that include "mean" and "std" (standard deviation) 

The script then renames the columns to show variable description in a more meaningful way, and extends any accronyms.

Finally, the script groups by subject and activity and summurizes the data via an average.  The extract is available in a landing folder.
 