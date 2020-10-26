##---------------------------------------------------
## Load both datasets and label them with feature names
##---------------------------------------------------

test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
featname  <- read.table("features.txt", colClasses = "character")
featvec <- featname$V2
featvec <- tolower(featvec)
featvec <- gsub("\\()","",featvec)
featvec <- gsub("-","",featvec)
names(test) <- featvec
names(train) <- featvec
rm(featname,featvec)

##---------------------------------------------------
## Select columns of mean and std 
##---------------------------------------------------
a <- grep("mean",names(test))
b <- grep("meanfreq",names(test))
c <- grep("angle",names(test))
x <- setdiff(a,b)
colselectmean <- setdiff(x,c)
colselectstd <- grep("std",names(test))
test <- test[,c(colselectmean,colselectstd)]

a <- grep("mean",names(train))
b <- grep("meanfreq",names(train))
c <- grep("angle",names(train))
x <- setdiff(a,b)
colselectmean <- setdiff(x,c)
colselectstd <- grep("std",names(train))
train <- train[,c(colselectmean,colselectstd)]
rm(a,b,x,c,colselectstd,colselectmean)

##---------------------------------------------------
## Add activitylabel column to both the datasets
##---------------------------------------------------
testact <- read.table("./test/y_test.txt")
trainact <- read.table("./train/y_train.txt")
names(testact) <- "activitylabel"
names(trainact) <- "activitylabel"
test <- cbind(test, testact)
train <- cbind(train, trainact)
rm(trainact,testact)

##---------------------------------------------------
## Add descriptive names to content of activitylabel column
##---------------------------------------------------

test$activitylabel <- sub("1","walking",test$activitylabel)
test$activitylabel <- sub("2","walking_upstairs",test$activitylabel)
test$activitylabel <- sub("3","walking_downstairs",test$activitylabel)
test$activitylabel <- sub("4","sitting",test$activitylabel)
test$activitylabel <- sub("5","standing",test$activitylabel)
test$activitylabel <- sub("6","laying",test$activitylabel)

train$activitylabel <- sub("1","walking",train$activitylabel)
train$activitylabel <- sub("2","walking_upstairs",train$activitylabel)
train$activitylabel <- sub("3","walking_downstairs",train$activitylabel)
train$activitylabel <- sub("4","sitting",train$activitylabel)
train$activitylabel <- sub("5","standing",train$activitylabel)
train$activitylabel <- sub("6","laying",train$activitylabel)

##---------------------------------------------------
## Add subject column to both the datasets
##---------------------------------------------------

testsub <- read.table("./test/subject_test.txt")
trainsub <- read.table("./train/subject_train.txt")
names(testsub) <- "subject"
names(trainsub) <- "subject"
test <- cbind(test, testsub)
train <- cbind(train, trainsub)
rm(trainsub,testsub)

##---------------------------------------------------
## Merge both the datasets together 
##---------------------------------------------------

data <- rbind(test,train)
rm(test,train)

##---------------------------------------------------
## Find average values wrt subject and activity
##---------------------------------------------------

library(plyr)
library(dplyr)

act <- data %>% 
  group_by(activitylabel,subject) %>% 
  summarise_each(funs(mean))

write.table(act, "./tidy_data_summary.txt", row.names = FALSE)

##---------------------------------------------------