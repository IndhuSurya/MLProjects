#1.Create a model using rpart function
data(package="rpart")
library(rpart)
data("kyphosis")
kyphosis
colnames(x = kyphosis)[4]
progstat<-factor(kyphosis$Kyphosis)
progstat
cfit<-rpart(progstat~kyphosis$Age+kyphosis$Number+kyphosis$Start,data=kyphosis,method='class', parms=list(split="information"), control = rpart.control(minsplit = 2,minbucket = 1, cp=0.0005))
cfit

#2.Create a nice decision tree plot
par(adj=0.5,mar=rep(0.5,4),bg="grey")
plot(cfit)
text(cfit)
print(cfit)
summary(cfit)

#3.List the important attributes
cfit$variable.importance

#4.Using the best pruning parameter, create a pruned tree
minCP<-cfit$cptable[which.min(cfit$cptable[,"xerror"])]
minCP
prunedTree<-prune(cfit,minCP)
prunedTree
prunedTree$variable.importance
par(adj=1,mar=rep(5,4),bg="grey")
plot(prunedTree)
text(prunedTree)
print(prunedTree)

#5.Divide the dataset into 2 parts
#Training data set a random sample of 80% 
set.seed(0)
train=sample(1:nrow(kyphosis),nrow(kyphosis)*0.8)
train
training_data=kyphosis[train,]
training_data

#Testdata of remaining 20%
test=-train
test_data=kyphosis[test,]
test_data
testing_kyphosis=kyphosis$Kyphosis[test]
testing_kyphosis

#Training data tree
progstat1<-factor(training_data$Kyphosis)
progstat1
cfit1<-rpart(progstat1~training_data$Age+training_data$Number+training_data$Start,data=training_data,method='class', parms=list(split="information"),control = rpart.control(minsplit = 2, minbucket = 1, cp = 0.0005))
cfit1
par(adj=0.5,mar=rep(0.5,4),bg="grey")
plot(cfit1)
text(cfit1)
print(cfit1)
summary(cfit1)
cfit1$variable.importance

#Prediction on the test data of the original tree
tpredict<-predict(cfit1, newdata = rep(test_data), type="class")

#Acccuracy of the original tree using testing data
mean(tpredict==rep(testing_kyphosis))

#Pruned data using training set
minCP1<-cfit1$cptable[which.min(cfit1$cptable[,"xerror"])]
prunedTree1<-prune(cfit1,minCP1)
plot(prunedTree1)
text(prunedTree1)
print(prunedTree1)
prunedTree1$variable.importance

#Prediction on the test data of the pruned tree
treePredict<-predict(prunedTree1,newdata = rep(test_data),type ="class")
treePredict

#Calculating the accuracy
mean(treePredict==rep(testing_kyphosis))

#Training data set a random sample of 90% 
set.seed(3)
train1=sample(1:nrow(kyphosis),nrow(kyphosis)*0.9)
train1
training_data1=kyphosis[train1,]
training_data1

#Testdata of remaining 10%
test1=-train1
test_data1=kyphosis[test1,]
test_data1
testing_kyphosis1=kyphosis$Kyphosis[test1]
testing_kyphosis1

#Trainiing data tree
progstat2<-factor(training_data1$Kyphosis)
progstat2
cfit2<-rpart(progstat2~training_data1$Age+training_data1$Number+training_data1$Start,data=training_data1,method='class', parms=list(split="information"),control = rpart.control(minsplit = 2, minbucket = 1, cp = 0.0005))
cfit2
par(adj=0.5,mar=rep(0.5,4),bg="grey")
plot(cfit2)
text(cfit2)
print(cfit2)
summary(cfit2)
cfit2$variable.importance
ptree1<-predict(cfit2, rep(test_data1), type ="class")

#accuracy of the original tree
mean(ptree1==testing_kyphosis1)

#Pruned data using training set
minCP2<-cfit2$cptable[which.min(cfit2$cptable[,"xerror"])]
prunedTree2<-prune(cfit2,minCP2)
plot(prunedTree2)
text(prunedTree2)
print(prunedTree2)
prunedTree2$variable.importance

#Prediction on the test data
treePredict1<-predict(prunedTree2,newdata = rep(test_data1),type ="class")

#Accuracy of the pruned tree using testing data
mean(treePredict1==rep(testing_kyphosis1))

#1.Create a model using rpart function for solder

data("solder")
solder
progstat<-factor(solder$Solder)
progstat
cfit<-rpart(progstat~solder$Opening+solder$Mask+solder$PadType+solder$Panel+solder$skips,data=solder,method='class', parms=list(split="information"), control = rpart.control(minsplit = 2,minbucket = 1))
cfit

#2.Create a nice decision tree plot

par(adj=0.5,mar=rep(0.5,4),bg="grey")
plot(cfit)
text(cfit)
print(cfit)
summary(cfit)

#3.List the important attributes
cfit$variable.importance

#4.Using the best pruning parameter, create a pruned tree
minCP<-cfit$cptable[which.min(cfit$cptable[,"xerror"])]
minCP
prunedTree<-prune(cfit,minCP)
prunedTree
prunedTree$variable.importance
par(adj=1,mar=rep(5,4),bg="grey")
plot(prunedTree)
text(prunedTree)
print(prunedTree)

#5.Divide the dataset into 2 parts
#Training data set a random sample of 80% 
set.seed(0)
train=sample(1:nrow(solder),nrow(solder)*0.8)
train
training_data=solder[train,]
training_data

#Testdata of remaining 20%
test=-train
test_data=solder[test,]
test_data
testing_solder=solder$Solder[test]
testing_solder

#Training data tree
progstat1<-factor(training_data$Solder)
progstat1
cfit1<-rpart(progstat1~training_data$Opening+training_data$Mask+training_data$PadType+training_data$Panel+training_data$skips,data=training_data,method='class', parms=list(split="information"),control = rpart.control(minsplit = 2, minbucket = 1))
cfit1
par(adj=0.5,mar=rep(0.5,4),bg="grey")
plot(cfit1)
text(cfit1)
print(cfit1)
summary(cfit1)
cfit1$variable.importance

#Prediction on the test data of the original tree
tpredict<-predict(cfit1, newdata = rep(test_data), type="class")

#Acccuracy of the original tree using testing data
mean(tpredict==rep(testing_solder))

#Pruned data using training set
minCP1<-cfit1$cptable[which.min(cfit1$cptable[,"xerror"])]
prunedTree1<-prune(cfit1,minCP1)
plot(prunedTree1)
text(prunedTree1)
print(prunedTree1)
prunedTree1$variable.importance

#Prediction on the test data of the pruned tree
treePredict<-predict(prunedTree1,newdata = rep(test_data),type ="class")
treePredict

#Calculating the accuracy
mean(treePredict==rep(testing_solder))

#Training data set a random sample of 90% 
set.seed(3)
train1=sample(1:nrow(solder),nrow(solder)*0.9)
train1
training_data1=solder[train1,]
training_data1
#Testdata of remaining 10%
test1=-train1
test_data1=solder[test1,]
test_data1
testing_solder1=solder$Solder[test1]
testing_solder1

#Trainiing data tree
progstat2<-factor(training_data1$Solder)
progstat2
cfit2<-rpart(progstat2~training_data1$Opening+training_data1$Mask+training_data1$PadType+training_data1$Panel+training_data1$skips,data=training_data1,method='class', parms=list(split="information"),control = rpart.control(minsplit = 2, minbucket = 1))
cfit2
par(adj=0.5,mar=rep(0.5,4),bg="grey")
plot(cfit2)
text(cfit2)
print(cfit2)
summary(cfit2)
cfit2$variable.importance
ptree1<-predict(cfit2, rep(test_data1), type ="class")

#accuracy of the original tree
mean(ptree1==testing_solder1)

#Pruned data using training set
minCP2<-cfit2$cptable[which.min(cfit2$cptable[,"xerror"])]
prunedTree2<-prune(cfit2,minCP2)
plot(prunedTree2)
text(prunedTree2)
print(prunedTree2)
prunedTree2$variable.importance

#Prediction on the test data
treePredict1<-predict(prunedTree2,newdata = rep(test_data1),type ="class")

#Accuracy of the pruned tree using testing data
mean(treePredict1==rep(testing_solder1))





























