args <- commandArgs(TRUE)
table <- read.table(file=args[1], sep=",")

#install.packages("e1071", dependencies = TRUE)
#data(package="e1071")
install.packages("e1071",lib="/data/Rpackages/", dependencies = TRUE)
library(e1071, lib.loc="/data/Rpackeges")
table<-read.table("D:/UTD CS/ML/Project/pima-indian-diabetes.csv", sep=',')
attributes(table)$names<-c("Pregnant","Plasma","BP","Triceps","Insulin","BMI","Diabetes","Age","Class")
table


linearAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(linearAccuracyTable)<-c("Experiment","Accuracy")
polyAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(polyAccuracyTable)<-c("Experiment","Accuracy")
radAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(radAccuracyTable)<-c("Experiment","Accuracy")
sigAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(sigAccuracyTable)<-c("Experiment","Accuracy")



for(i in 1:10)
{
  set.seed(i)
  train=sample(1:nrow(table),nrow(table)*0.9)
  train
  training_data=table[train,]
  training_data
  test=-train
  test
  test_data=table[test,]
  test_data
  
  #Default SVM
  svmModel<-svm(as.factor(training_data$Class)~., training_data)
  print(svmModel)
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,test_data)
  print(table(predict=pred, truth=test_data[,9]))
  defOT<-table(predict=pred, truth=test_data[,9])
  accuracy<-(defOT[1,1]+defOT[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  
  #Linear SVM
  svmModel<-svm(as.factor(training_data$Class)~., training_data, kernel="linear", cost=10, scale=FALSE)
  print(svmModel)
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,test_data[,-9])
  pred
  linearOT<-table(pred, test_data$Class)
  linearOT
  accuracy<-(linearOT[1,1]+linearOT[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  linearAccuracyTable[i,1]<-i
  print(linearAccuracyTable[i,0])
  linearAccuracyTable[i,2]<-accuracy
  print(linearAccuracyTable[i,2])
  
  #Polynomial SVM
  svmModel<-svm(as.factor(training_data$Class)~., training_data, kernel="polynomial")
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,test_data)
  print(table(predict=pred, truth=test_data[,9]))
  polyOT<-table(predict=pred, truth=test_data[,9])
  accuracy<-(polyOT[1,1]+polyOT[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  
  
  polyAccuracyTable[i,1]<-i
  print(polyAccuracyTable[i,0])
  polyAccuracyTable[i,2]<-accuracy
  print(polyAccuracyTable[i,2])
  
  #Radial SVM
  svmModel<-svm(as.factor(training_data$Class)~., training_data, kernel="radial")
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,test_data)
  print(table(predict=pred, truth=test_data[,9]))
  radOT<-table(predict=pred, truth=test_data[,9])
  accuracy<-(radOT[1,1]+radOT[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  
  radAccuracyTable[i,1]<-i
  print(radAccuracyTable[i,0])
  radAccuracyTable[i,2]<-accuracy
  print(radAccuracyTable[i,2])
  
  #Sigmoid Kernal
  svmModel<-svm(as.factor(training_data$Class)~., training_data, kernel="sigmoid")
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,test_data)
  print(table(predict=pred, truth=test_data[,9]))
  sigOT<-table(predict=pred, truth=test_data[,9])
  accuracy<-(sigOT[1,1]+sigOT[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  
  sigAccuracyTable[i,1]<-i
  print(sigAccuracyTable[i,0])
  sigAccuracyTable[i,2]<-accuracy
  print(sigAccuracyTable[i,2])
  
}

SVMAccuracyTable<-matrix(rep(0,8), nrow=4)
colnames(SVMAccuracyTable)<-c("Kernal","Average Accuracy of 10 experiments")
SVMAccuracyTable[1,1]<-"Linear"
SVMAccuracyTable[2,1]<-"Polynomial"
SVMAccuracyTable[3,1]<-"Radial"
SVMAccuracyTable[4,1]<-"Sigmoid"
SVMAccuracyTable[1,2]<-mean(linearAccuracyTable[,2])
SVMAccuracyTable[2,2]<-mean(polyAccuracyTable[,2])
SVMAccuracyTable[3,2]<-mean(radAccuracyTable[,2])
SVMAccuracyTable[4,2]<-mean(sigAccuracyTable[,2])
print(SVMAccuracyTable)
