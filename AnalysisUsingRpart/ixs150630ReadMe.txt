Rpart Package Analysis Version 1.0 08/31/2015

How to run
-----------
1) Open cmd prompt and go to the path of the folder
2) cd AnalysisUsingRpart
3) Rscript AnalysisUsingRpart.R

General Usage Notes
-------------------

-The program was coded using RStudio

Program Description
-------------------

The analysis of Rpart Package by using the functions rpart, plot, text, prune and predict 
In built data sets used are kyphosis and solder.
A decision tree is built and pruning is performed using the training data.
Testing data is used to predict the accuracy of the decision trees created. 

Resources used
--------------

https://stat.ethz.ch/R-manual/R-devel/library/rpart/html/predict.rpart.html
https://www.youtube.com/watch?v=XLNsl1Da5MA
https://www.youtube.com/watch?v=CrFwNzdyt7I

Observation
-----------

From the output, it can be observed that


5. FOR KYPHOSIS DATA:

Variable importance of the original tree using 80% data as training data
training_data$Start    training_data$Age training_data$Number 
Accuaracy of the original tree using testing data= 0.5625
Variable importance of the pruned tree
training_data$Start training_data$Number 
Accuracy of the pruned tree using testing data= 0.625

Variable importance of the original tree using 90% data as training data
training_data1$Start    training_data1$Age training_data1$Number 
Accuaracy of the original tree using testing data= 0.6666667
Variable importance of the pruned tree
training_data1$Start    training_data1$Age training_data1$Number 
Accuaracy of the pruned tree using testing data= 0.6805556


In both of the above situations, pruned tree has greater accuracy.
But the best decision tree to be chosen for the kyphosis data is the pruned tree with 90% of original data as the training data.

6. FOR SOLDER DATA:

Variable importance of the original tree using 80% data as training data
training_data$skips training_data$Opening    training_data$Mask training_data$PadType 
Accuaracy of the original tree using testing data= 0.5399306
Variable importance of the pruned tree
training_data$skips training_data$Opening    training_data$Mask training_data$PadType 
Accuracy of the pruned tree using testing data= 0.5399306

Variable importance of the original tree using 90% data as training data
training_data1$skips training_data1$Opening    training_data1$Mask training_data1$PadType 
Accuaracy of the original tree using testing data= 0.4984568
Variable importance of the pruned tree
training_data1$skips training_data1$Opening    training_data1$Mask training_data1$PadType 
Accuaracy of the pruned tree using testing data= 0.4984568

In this situation, both original and pruned trees obtained are the same.
It can be said that 80% data as the training data can be considered for the solder data to get the tree with greater accuracy 



