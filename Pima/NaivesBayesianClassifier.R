args <- commandArgs(TRUE)
table <- read.table(file=args[1], sep=",")

#table<-read.table("D:/UTD CS/ML/Project/pima-indian-diabetes.csv", sep=',')
#show(table)
name<-attributes(table)$names
attributes(table)$names<-c("Pregnant","Plasma","BP","Triceps","Insulin","BMI","Diabetes","Age","Class")
#install.packages("e1071", dependencies = TRUE)
library(e1071)
table
table$Class<-factor(table$Class, levels = 0:1, labels=c("No","Yes"))
naiveBayes(table$Class~., table, laplace=0)
accuracyTable<-matrix(rep(0,20), nrow=10)
colnames(accuracyTable)<-c("Experiment","Accuracy")
accuracyTable
nrow(table)
table
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
  naiveDemo<-naiveBayes(training_data$Class~., training_data)
  str(naiveDemo)
  test_data[,-9]
  naiveValue<-predict(naiveDemo, test_data[,-9],type = "raw")
  naiveClass<-predict(naiveDemo, test_data[,-9], type ="class")
  naiveValue
  print(naiveClass)
  test_data$Class
  nrow(naiveValue)
  nrow(test_data$Class)
  test_data
  test_data$BP
  test_data$Class
  naiveClass
  outputTable<-table(naiveClass, test_data$Class)
  nrow(test_data)
  outputTable[1,1]
  outputTable[2,2]
  accuracy<-(outputTable[1,1]+outputTable[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  accuracyTable[i,1]<-i
  print(accuracyTable[i,0])
  accuracyTable[i,2]<-accuracy
  print(accuracyTable[i,2])
}
print(accuracyTable)
meanAccuracy=mean(accuracyTable[,2])
print(paste("Overall Accuracy = ",meanAccuracy, "%"))
