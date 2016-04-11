#Comparing the Performance of various Classifiers using 5 different datasets

args <- commandArgs(TRUE)
dataURL<-as.character(args[1])
header<-as.logical(args[2])
d<-read.csv(dataURL,header = header)


#DataCleaning
myDataCleaning <- function(d) {
  for(i in 1:ncol(d)) {
    d <- d[ d[, i] != '?', ]
     }
  return (d)
}
d<-myDataCleaning(d)
#Importing package
dataURL
header

#install.packages("e1071", dependencies = TRUE, )
#install.packages("nnet", dependencies = TRUE, repos="http://cran.rstudio.com" )
#install.packages("randomForest", dependencies = TRUE, repos="http://cran.rstudio.com" )
#install.packages("adabag", repos="http://cran.rstudio.com", dependencies=TRUE)
#data(package="e1071")
#require(adabag)
library(nnet)
library(randomForest)
#library(neuralnet)
library(adabag)
library(rpart)
library(class)
library(mlbench)
library(e1071)
#For DT
DTAccuracyTable<-matrix(rep(0,30), nrow=10)
colnames(DTAccuracyTable)<-c("Experiment","DTAccuracy", "PrunedDTAccuracy")

#FOR NAIVEBAYES
accuracyTable<-matrix(rep(0,20), nrow=10)
colnames(accuracyTable)<-c("Experiment","Accuracy")
#FOR SVM
linearAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(linearAccuracyTable)<-c("Experiment","Accuracy")
polyAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(polyAccuracyTable)<-c("Experiment","Accuracy")
radAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(radAccuracyTable)<-c("Experiment","Accuracy")
sigAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(sigAccuracyTable)<-c("Experiment","Accuracy")
#For KNN
kNNTable<-matrix(rep(0,10),nrow=5)
kNNAccuracyTable<-matrix(rep(0,50),nrow = 10)

baggingAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(baggingAccuracyTable)<-c("Experiment","Accuracy")

boostingAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(boostingAccuracyTable)<-c("Experiment","Accuracy")

RFAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(RFAccuracyTable)<-c("Experiment","Accuracy")

LRAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(LRAccuracyTable)<-c("Experiment","Accuracy")

nNetAccuracyTable<-matrix(rep(0,20), nrow=10)
colnames(nNetAccuracyTable)<-c("Experiment","Accuracy")

myNaiveBayes<-function(table, Class, ClassPosition, i, training_data ,test_data, accuracyTable)
{
  print("*********NAIVE BAYES***************")
  training_data[,ClassPosition]<-factor(training_data[,ClassPosition], labels=c("No","Yes"))
  test_data[,ClassPosition]<-factor(test_data[,ClassPosition], labels=c("No","Yes"))
  Class<-paste(Class, "~.")
  colnames(accuracyTable)<-c("Experiment","Accuracy")
  attach(training_data)
  naiveDemo<-naiveBayes(as.formula(Class), training_data)
  test_data[,-ClassPosition]
  naiveValue<-predict(naiveDemo, test_data[,-ClassPosition],type = "raw")
  naiveClass<-predict(naiveDemo, test_data[,-ClassPosition], type ="class")
  outputTable<-table(naiveClass, test_data[,ClassPosition])
  outputTable[1,1]
  outputTable[2,2]
  accuracy<-(outputTable[1,1]+outputTable[2,2])/nrow(test_data)
  accuracy<-accuracy*100
  accuracy
  accuracyTable[i,1]<-i
  accuracyTable[i,2]<-accuracy
  cat("Naives Bayes accuracy for ", i, "interation\n")
  print(accuracyTable[i,2])
  detach(training_data)
  return (accuracyTable)
  
}


# create 10 samples
set.seed(123)
for(i in 1:10) {
  cat("Running sample ",i,"\n")
  
  sampleInstances<-sample(1:nrow(d),size = 0.9*nrow(d))
  trainingData<-d[sampleInstances,]
  testData<-d[-sampleInstances,]
  # which one is the class attribute
  #Class<-as.integer(args[3])
  Class<-d[,as.integer(args[3])]
  cat(args[3],"\n")
  cat("*****args Integer****",as.integer(args[3]),"\n")
  cat(as.factor(as.integer(args[3])),"\n")
  #cat("*******************",Class,"\n")
  # now create all the classifiers and output accuracy values:
  ClassPosition<-as.integer(args[3])
  #DECISION TREE CLASSIFIER
  ClassVariable<-colnames(x = trainingData)[as.integer(args[3])]
  attach(trainingData)
  cfit<-rpart(as.formula(paste(ClassVariable,"~.")), data=trainingData, method='class', parms=list(split="information"), control = rpart.control(minsplit = 2, minbucket = 1, cp = 0.0005))
  cfit
  #plotcp(cfit)
  #par(adj=0.1,mar=rep(0.1,4),bg="grey")
  #plot(cfit)
  #text(cfit)
  #summary(cfit)
  cfit$variable.importance
  tpredict<-predict(cfit, newdata = testData[,-ClassPosition], type="class")
  
  #Acccuracy of the original tree using testing data
  cat("Method =DECISION TREE ,Accuracy= ",100*mean(tpredict==testData[,ClassPosition]),"\n")
  
  cat(which.min(cfit$cptable[,"xerror"]),"\n")
  minCP<-cfit$cptable[which.min(cfit$cptable[,"xerror"])-1]
  minCP
  prunedTree<-prune(cfit, minCP-1)
  prunedTree
  prunedTree$variable.importance
  #plotcp(prunedTree)
  #printcp(prunedTree)
  #par(adj=1,mar=rep(0.1,4),bg="grey")
  #plot(prunedTree)
  #text(prunedTree)
  print(prunedTree)
  ppredict<-predict(cfit, newdata = testData[,-ClassPosition], type="class")
  #Acccuracy of the original tree using testing data
  cat("Method = PRUNED DECISION TREE ,Accuracy= ",100*mean(ppredict==testData[,ClassPosition]),"\n")
  DTAccuracyTable[i,1]<-i
  DTAccuracyTable[i,2]<-mean(tpredict==testData[,ClassPosition])*100
  DTAccuracyTable[i,3]<-mean(ppredict==testData[,ClassPosition])*100
  detach(trainingData)
  
  #NaiveBayes
  accuracyTable<-myNaiveBayes(d, ClassVariable, ClassPosition, i, trainingData ,testData, accuracyTable)
  
  
  #SVM
  Class<-paste("trainingData$",ClassVariable, sep = "")
  cat("Class", as.factor(Class),"\n")
  Class<-paste(as.factor(Class),"~.", sep = "")
  trainingData[,ClassPosition]<-as.factor(trainingData[,ClassPosition])
  testData[,ClassPosition]<-as.factor(testData[,ClassPosition])
  
  #Linear SVM
  svmModel<-svm(as.formula(Class), trainingData, kernel="linear", cost=10, scale=FALSE)
  print(svmModel)
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,testData[,-ClassPosition])
  linearOT<-table(pred, testData[,ClassPosition])
  print(linearOT)
  accuracy<-(linearOT[1,1]+linearOT[2,2])/nrow(testData)
  accuracy<-accuracy*100
  accuracy
  linearAccuracyTable[i,1]<-i
  linearAccuracyTable[i,2]<-accuracy
  cat("******Linear Accuracy *******",i,"iteration",accuracy,"\n")
  
  #Polynomial SVM
  svmModel<-svm(as.formula(Class), trainingData, kernel="polynomial")
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,testData)
  print(table(predict=pred, truth=testData[,ClassPosition]))
  polyOT<-table(predict=pred, truth=testData[,ClassPosition])
  accuracy<-(polyOT[1,1]+polyOT[2,2])/nrow(testData)
  accuracy<-accuracy*100
  accuracy
  polyAccuracyTable[i,1]<-i
  polyAccuracyTable[i,2]<-accuracy
  cat("******Poly Accuracy *******",i,"iteration",accuracy,"\n")
  
  #Radial SVM
  svmModel<-svm(as.formula(Class), trainingData, kernel="radial")
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,testData)
  print(table(predict=pred, truth=testData[,ClassPosition]))
  radOT<-table(predict=pred, truth=testData[,ClassPosition])
  accuracy<-(radOT[1,1]+radOT[2,2])/nrow(testData)
  accuracy<-accuracy*100
  accuracy
  radAccuracyTable[i,1]<-i
  print(radAccuracyTable[i,0])
  radAccuracyTable[i,2]<-accuracy
  cat("******RAD Accuracy *******",i,"iteration",accuracy,"\n")
  
  #Sigmoid Kernal
  svmModel<-svm(as.formula(Class), trainingData, kernel="sigmoid")
  summary(svmModel)
  svmModel$index
  pred<-predict(svmModel,testData)
  print(table(predict=pred, truth=testData[,ClassPosition]))
  sigOT<-table(predict=pred, truth=testData[,ClassPosition])
  accuracy<-(sigOT[1,1]+sigOT[2,2])/nrow(testData)
  accuracy<-accuracy*100
  accuracy
  sigAccuracyTable[i,1]<-i
  print(sigAccuracyTable[i,0])
  sigAccuracyTable[i,2]<-accuracy
  cat(sigAccuracyTable[i,2],"\n")
  cat("******Sigmoid Accuracy *******",i,"iteration",accuracy,"\n")
  
  
  # example of how to output
  # method="kNN" 
  
  #kNNAccuracyTable<-mykNN(trainingData, testData, ClassPosition, ClassVariable, i)
  ClassVariable<-paste("trainingData$", ClassVariable,sep="")
  predict<-knn(trainingData[,-ClassPosition], testData[,-ClassPosition], k=3, cl = trainingData[,ClassPosition])
  FOT<-table(predict, testData[,ClassPosition])
  accuracy<-(FOT[1,1]+FOT[2,2])/nrow(testData)
  kNNAccuracyTable[i,1]<-accuracy
  
  
  predict<-knn(trainingData[,-ClassPosition], testData[,-ClassPosition], k=5, cl = trainingData[,ClassPosition])
  SOT<-table(predict, testData[,ClassPosition])
  accuracy<-(SOT[1,1]+SOT[2,2])/nrow(testData)
  kNNAccuracyTable[i,2]<-accuracy
  predict<-knn(trainingData[,-ClassPosition], testData[,-ClassPosition], k=7, cl = trainingData[,ClassPosition])
  TOT<-table(predict, testData[,ClassPosition])
  accuracy<-(TOT[1,1]+TOT[2,2])/nrow(testData)
  kNNAccuracyTable[i,3]<-accuracy
  predict<-knn(trainingData[,-ClassPosition], testData[,-ClassPosition], k=9, cl = trainingData[,ClassPosition])
  FROT<-table(predict, testData[,ClassPosition])
  accuracy<-(FROT[1,1]+FROT[2,2])/nrow(testData)
  kNNAccuracyTable[i,4]<-accuracy
  predict<-knn(trainingData[,-ClassPosition], testData[,-ClassPosition], k=11, cl=trainingData[,ClassPosition])
  FFOT<-table(predict, testData[,ClassPosition])
  accuracy<-(FFOT[1,1]+FFOT[2,2])/nrow(testData)
  kNNAccuracyTable[i,5]<-accuracy
  
  
  #************Logistic**********
  
  sapply(trainingData, sd)
  #print(trainingData[, ])
  mylogit <- glm(as.formula(Class), data = trainingData[,!colnames(trainingData) %in% c("V35")], family = "binomial")
  #summary(mylogit)
  #confint(mylogit)
  # How to predict
  # use predict with type="response", it will give you a probability of 1
  
  p<-predict(mylogit, newdata=testData, type="response")
  # use a threshold value and anything above that, you can assign to class=1 others to class=0
  threshold=0.65
  actual<-table(testData[,ClassPosition])
  demoDF<-as.data.frame(actual)
  prediction<-sapply(p, FUN=function(x) if (x>threshold) demoDF[2,1] else demoDF[1,1])
  cat("Logistic Regression ",i, "Interation")
  print("******CONFUSION MATRIX*****")
  print(table(testData[,ClassPosition], prediction))
  accuracy <- sum(testData[,ClassPosition]==prediction)/length(prediction)
  cat("Accuracy ")
  accuracy<-accuracy*100
  LRAccuracyTable[i,1]<-i
  LRAccuracyTable[i,2]<-accuracy
  print(accuracy)
  
  print("************BAGGING***************")
  l <- length(trainingData[,1])
  #sub <- sample(1:l,2*l/3)
  mfinal <- 5
  maxdepth <- 3
  attach(trainingData)
  trainingData[,ClassPosition]<-as.factor(trainingData[,ClassPosition])
  testData[,ClassPosition]<-as.factor(testData[,ClassPosition])
  ClassVariable<-colnames(x = trainingData)[ClassPosition]
  n <- names(d[,-ClassPosition])
  
  f <- as.formula(paste(ClassVariable ,"~", paste(n, collapse = " + ")))
  
  trainingData.bagging <- bagging( f, data=trainingData, mfinal=40, 
                             control=rpart.control(maxdepth=5))
  
  
  trainingData.bagging.pred <- predict.bagging(trainingData.bagging,newdata=testData)
  cat("Bagging Confusion matrix ",i, " iteration\n")
  print(trainingData.bagging.pred$confusion)
  accuracy<-1-trainingData.bagging.pred$error
  accuracy<-accuracy*100
  baggingAccuracyTable[i,1]<-i
  baggingAccuracyTable[i,2]<-accuracy
  cat("Accuracy", accuracy,"\n")
  detach(trainingData)
  
  print("*********BOOSTING********")
  trainingData.adaboost <- boosting(f ,data=trainingData ,mfinal=mfinal, coeflearn="Zhu",
                               control=rpart.control(maxdepth=maxdepth))
  trainingData.adaboost.pred <- predict.boosting(trainingData.adaboost,newdata=testData)
  cat("Boosting Confusion matrix ",i, " iteration\n")
  print(trainingData.adaboost.pred$confusion)
  print("Boosting Accuracy")
  accuracy<-(1-trainingData.adaboost.pred$error)*100
  boostingAccuracyTable[i,1]<-i
  boostingAccuracyTable[i,2]<-accuracy
  print(1-trainingData.adaboost.pred$error)
  
  
  
  print("********NEURAL NETWORK*************")
  
  f <- as.formula(paste(ClassVariable ,"~", paste(n, collapse = " + ")))
  creditnet <- nnet(f, trainingData , size=4, maxit=200)
  predictnet <- predict(creditnet, testData, type="class" )
  NNetAccuracyTable<-table(predictnet, testData[, ClassPosition])
  cat("Neural Network Confusion matrix ",i, " iteration\n")
  accuracy<-sum(testData[,ClassPosition]==predictnet)/length(predictnet)
  print(NNetAccuracyTable)
  accuracy<-accuracy*100
  nNetAccuracyTable[i,1]<-i
  nNetAccuracyTable[i,2]<-accuracy
  cat("Accuracy ", accuracy )

  
  cat("******************RANDOM FORESTS*************************")
  ## prediction
  set.seed(111)
  trainingData.rf <- randomForest(f, data=trainingData)
  trainingData.pred <- predict(trainingData.rf, testData[,-ClassPosition])
  ppt<-table(observed = testData[,ClassPosition], predicted = trainingData.pred)
  cat("Random Forest Confusion matrix ",i, " iteration\n")
  print(ppt)
  accuracy<-sum(testData[,ClassPosition]==trainingData.pred )/length(trainingData.pred )
  print(RFAccuracyTable)
  accuracy<-accuracy*100
  RFAccuracyTable[i,1]<-i
  RFAccuracyTable[i,2]<-accuracy
  cat("Accuracy ", accuracy)
  
}

#DTree
cat("Method =**************DTree************* AccuracyTable given below \n")
print(DTAccuracyTable)
cat("Average accuracy of 10 experiments ", mean(DTAccuracyTable[,2]))
cat("Average Pruned tree accuracy of 10 experiments ", mean(DTAccuracyTable[,3]))

cat("Method =**************Naives Bayes************* AccuracyTable given below \n")
print(accuracyTable)
meanAccuracy=mean(accuracyTable[,2])
cat(paste("Overall Accuracy = ",meanAccuracy),"%")



cat("Method =**************KNN************* AccuracyTable given below \n")
print(kNNAccuracyTable)
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
print(kNNTable)



#sVM
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
cat("Method =SVM AccuracyTable given below \n")
print(SVMAccuracyTable)

#LR
cat("Method =**************Logistic Regression************* AccuracyTable given below \n")
print(LRAccuracyTable)
cat("Average accuracy of 10 experiments ", mean(LRAccuracyTable[,2]))

#NNet
cat("Method =**************Neural Network************* AccuracyTable given below \n")
print(nNetAccuracyTable)
cat("Average accuracy of 10 experiments ", mean(nNetAccuracyTable[,2]))

#Bagging
cat("Method =**************Bagging ************ AccuracyTable given below \n")
print(baggingAccuracyTable)
cat("Average accuracy of 10 experiments ", mean(baggingAccuracyTable[,2]))

#RandomForest
cat("Method =**************RandomForest************* AccuracyTable given below \n")
print(RFAccuracyTable)
cat("Average accuracy of 10 experiments ", mean(RFAccuracyTable[,2]))

#Boosting
cat("Method =**************Boosting************* AccuracyTable given below \n")
print(boostingAccuracyTable)
cat("Average accuracy of 10 experiments ", mean(boostingAccuracyTable[,2]))
