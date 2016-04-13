library(class)
args <- commandArgs(TRUE)
table <- read.table(file=args[1], sep=",")

#table<-read.table("D:/UTD CS/ML/Project/pima-indian-diabetes.csv", sep=',')
attributes(table)$names<-c("Pregnant","Plasma","BP","Triceps","Insulin","BMI","Diabetes","Age","Class")
table
kNNAccuracyTable<-matrix(rep(0,50),nrow = 10)

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
  #training_data$Class<-factor(training_data$Class, levels = c("No","Yes"), labels=0:1)
  #test_data$Class<-factor(test_data$Class, levels = c("No","Yes"), labels=0:1)
  predict<-knn(training_data, test_data, k=3, cl = training_data$Class)
  FOT<-table(predict, test_data$Class)
  accuracy<-FOT[1,1]+FOT[2,2]/nrow(test_data)
  kNNAccuracyTable[i,1]<-accuracy
  predict<-knn(training_data, test_data, k=5, cl = training_data$Class)
  SOT<-table(predict, test_data$Class)
  accuracy<-SOT[1,1]+SOT[2,2]/nrow(test_data)
  kNNAccuracyTable[i,2]<-accuracy
  predict<-knn(training_data, test_data, k=7, cl = training_data$Class)
  TOT<-table(predict, test_data$Class)
  accuracy<-TOT[1,1]+TOT[2,2]/nrow(test_data)
  kNNAccuracyTable[i,3]<-accuracy
  predict<-knn(training_data, test_data, k=9, cl = training_data$Class)
  FROT<-table(predict, test_data$Class)
  accuracy<-FROT[1,1]+FROT[2,2]/nrow(test_data)
  kNNAccuracyTable[i,4]<-accuracy
  predict<-knn(training_data, test_data, k=11, cl=training_data$Class)
  FFOT<-table(predict, test_data$Class)
  accuracy<-FFOT[1,1]+FFOT[2,2]/nrow(test_data)
  kNNAccuracyTable[i,5]<-accuracy
}
kNNAccuracyTable
kNNTable<-matrix(rep(0,10),nrow=5)
colnames(kNNTable)<-c("k","Average Accuracy of 10 experiments")
kNNTable[1,1]<-"3"
kNNTable[2,1]<-"5"
kNNTable[3,1]<-"7"
kNNTable[4,1]<-"9"
kNNTable[5,1]<-"11"
for(i in 1:5)
{
  kNNTable[i,2]<-mean(kNNAccuracyTable[,i])
}
kNNTable





















