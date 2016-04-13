#data(package="rpart")
library(rpart)
#Choosing the file from the pop up
#file <- read.csv(file.choose(), header=TRUE, sep=",")
args <- commandArgs(TRUE)
data(package="rpart")
library(rpart)
#Choosing the file from the pop up
file <- read.csv(file=args[1], header=TRUE, sep=",")
file
#dynamically retrieving the column variables of the testing data
x<-c()
y<-c()
for (i in (1:ncol(file)-1))
{
  x<- append(x,colnames(file[i]))
  y<-paste(y,x[i])
  
  print(i)
  print(x)
  print(y)
  
  
  if (i!=ncol(file)-1&&i!=0) {
    y<-paste(y,'+')  
    
    print("hi")
  }
  print(y)
}
y<-paste("Class~",y)
y
attach(file)
cfit<-rpart(y,data=file,method='class', parms=list(split="information"), control = rpart.control(minsplit = 2,minbucket = 1))
cfit
plotcp(cfit)
printcp(cfit)
par(adj=0.1,mar=rep(0.1,4),bg="grey")
plot(cfit)
text(cfit)
print(cfit)
summary(cfit)
cfit$variable.importance
minCP<-cfit$cptable[which.min(cfit$cptable[,"xerror"])]
minCP
#Creating a pruned tree using testing data
prunedTree<-prune(cfit,minCP)
prunedTree
prunedTree$variable.importance
plotcp(prunedTree)
printcp(prunedTree)
par(adj=1,mar=rep(0.1,4),bg="grey")
plot(prunedTree)
text(prunedTree)
print(prunedTree)
#retrieving the testing data 
testing_data<- read.csv(file=args[3], header=TRUE, sep=",")
#Prediction on the test data
treePredict<-predict(prunedTree,newdata =testing_data,type ="class")
treePredict














