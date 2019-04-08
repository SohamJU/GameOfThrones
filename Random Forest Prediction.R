mydata=read.csv('Death.csv')
View(mydata)
#Split the mydata into the Training set and Test set
library(caTools)
library(caret)
set.seed(123)
split = sample.split(mydata$Death, SplitRatio = 0.8) 
training_set = subset(mydata, split == TRUE) 
test_set = subset(mydata, split == FALSE)
#K-fold Cross Validation with Random Forest supervised ML technique
ControlParameter=trainControl(method='cv',number=10)
 logM=train(Death ~ Degree + Closeness.Centrality + Betweenness.Centrality + Eccentricity + Page.Rank + Eigen.Value.Centrality, 
     data=training_set, method='rf', trControl=ControlParameter)
prob=predict(logM,test_set)
concat1=cbind(test_set,prob)
concat1
#Confusion Matrix for Accuracy Check and Choosing Threshold
for (i in seq(0.1,0.9,0.1))
{
y_pred  = ifelse(prob>i, 1, 0)
# Making the Confusion Matrix for different threshold probability
cm = table(test_set[,8], y_pred)
paraCM=confusionMatrix(cm)
Accuracy=paraCM$overall[1] #The entry for accuracy by position
print(Accuracy)
}
#Accuracy close to highest for 0.3 as threshold probability
combprob=predict(logM,mydata)
y_pred1  = ifelse(combprob>0.3, 1, 0)
combine=cbind(mydata,y_pred1)
a=combine[combine[,9]==1 & combine[9]!=combine[8],] #predicting death which hasn't actually happened yet
a
chars=a[1]
die=a[9]
listing=cbind(chars,die)
colnames(listing)[2]='Death'
listing
