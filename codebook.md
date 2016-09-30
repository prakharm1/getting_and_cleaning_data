## Code Book 
summary of the data in tidy.txt

# Activity Labels

* WALKING : VALUE 1 {subject walking during test}
* WALKING_UPSTAIRS :VALUE 2 {subject walking upstairs d.t.}
* WALKING_DOWNSTAIRS : VALUE 3 {subject walking down d.t.}
* SITTING : VALUE 4 {subject sitting d.t.}
* STANDING :VALUE 5 {subject standing d.t.}
* LAYING : VALUE 6 {subject laying down d.t.}

# Identification

* subject - test subject ID
* activity - activity type being performed during test

# steps taken

* I have downloaded the dataset locally and loaded the activity and feature information
* Then, I have loaded training and test datasets and kept columns reflecting mean or standard deviation
* Then, loaded the activity and subject data and merged columns --> then merged the datasets 
* I have taken the activity names and IDs from activity_labels.txt and substituted in the dataset
* Finally created the tidy dataset consisting of average valuse for each (subject, activity) pair
