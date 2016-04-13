args <- commandArgs(TRUE)
table <- read.table(file=args[1], sep=",")


#table<-read.table("D:/UTD CS/ML/Project/pima-indian-diabetes.csv", sep=',')
#Changing the column names
attributes(table)$names<-c("Pregnant","Plasma","BP","Triceps","Insulin","BMI","Diabetes","Age","Class")
#print(table)
for(i in 1:(ncol(table)-1))
{
  #x=readline(prompt =paste("Press any key for the",colnames(table)[i], "attribute histogram"))
  hist(table[,i], main = paste("Histogram of" ,colnames(table)[i]))
  #x=readline(prompt =paste("Press any key for the ",colnames(table)[i],"attribute barplot"))
  barplot(table[,i])
}
table2<-cor(table$Class, table[,-9])
print(table2)
print(paste("Plasma has the maximum correlation with the class variable=",max(table2)), max(table2))
table3<-cor(table[,-9], table[,-9])
print(table3)
iMax<-1
jMax<-2
for(i in 1:nrow(table3))
{
  for(j in 1:ncol(table3))
  {
    if(table3[i,j]>table3[iMax,jMax]&&i!=j)
    {
      iMax<-i
      jMax<-j
    }
  }
}
print(paste(colnames(table3)[iMax],"and", colnames(table3)[jMax], "attributes have the highest mutual correlation=",table3[iMax,jMax]))

