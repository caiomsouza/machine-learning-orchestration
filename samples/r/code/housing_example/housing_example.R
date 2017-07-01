# Example extracted from the Book R for Data Science

# http://proquest.safaribooksonline.com/book/programming/r/9781784390860/firstchapter#X2ludGVybmFsX0h0bWxWaWV3P3htbGlkPTk3ODE3ODQzOTA4NjAlMkZjaDEwczAyX2h0bWwmcXVlcnk9

#7. Attribute Information:
#1. CRIM      per capita crime rate by town
#2. ZN        proportion of residential land zoned for lots over 25,000 sq.ft.
#3. INDUS     proportion of non-retail business acres per town
#4. CHAS      Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
#5. NOX       nitric oxides concentration (parts per 10 million)
#6. RM        average number of rooms per dwelling
#7. AGE       proportion of owner-occupied units built prior to 1940
#8. DIS       weighted distances to five Boston employment centres
#9. RAD       index of accessibility to radial highways
#10. TAX      full-value property-tax rate per $10,000
#11. PTRATIO  pupil-teacher ratio by town
#12. B        1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
#13. LSTAT    % lower status of the population
#14. MEDV     Median value of owner-occupied homes in $1000's


# https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.names
housing <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
colnames(housing) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PRATIO","B","LSTAT","MDEV")

summary(housing)

plot(housing)

#install.packages("corrplot")
library(corrplot)
corrplot(cor(housing), method="number", tl.cex=0.5)

#
cov(housing)

#Using linear regression to predict quantities
#Using logistic regression to predict probabilities or categories

# Data partitioning
housing <- housing[order(housing$MDEV),]
#install.packages("caret")
library(caret)
set.seed(3277)
trainingIndices <- createDataPartition(housing$MDEV, p=0.75, list=FALSE)
housingTraining <- housing[trainingIndices,]
housingTesting <- housing[-trainingIndices,]
nrow(housingTraining)
nrow(housingTesting)

# Linear model -  linear regression 
linearModel <- lm(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT, data=housingTraining)
summary(linearModel)

predicted <- predict(linearModel,newdata=housingTesting)
summary(predicted)
summary(housingTesting$MDEV)
plot(predicted,housingTesting$MDEV)

head(housingTesting$MDEV)
head(housingTraining$MDEV)


sumofsquares <- function(x) {
  return(sum(x^2))
}

sumofsquares(1:5)

diff <- predicted - housingTesting$MDEV
sumofsquares(diff)

# Linear model -  Logistic regression 

lr <- glm(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT, data=housingTraining)
summary(lr)

predicted <- predict(lr,newdata=housingTesting)
summary(predicted)
plot(predicted,housingTesting$MDEV)
diff <- predicted - housingTesting$MDEV
sumofsquares(diff)

# Residuals
plot(resid(linearModel))

# Least squares regression
x <- housingTesting$MDEV
Y <- predicted
b1 <- sum((x-mean(x))*(Y-mean(Y)))/sum((x-mean(x))^2)
b0 <- mean(Y)-b1*mean(x)
c(b0,b1)

plot(x,Y)
abline(c(b0,b1),col="blue",lwd=2)

# Relative importance
# We can calculate the relative importance of the variables we used in the model using the relaimpo package. The relative importance of the variables used in our model will tell you which variables are providing the most effect on your results. In other words, out of all of the variables available, which should we pay the most attention to. Most of the time, you can only afford to investigate a few. In this case, maybe we are a buyer looking to see what factors are most affecting the value of houses and direct our search where those factors are maximized.

install.packages("relaimpo")
library(relaimpo)
calc.relimp(linearModel,type=c("lmg","last","first","pratt"), rela=TRUE)


# Stepwise regression
library(MASS)
step <- stepAIC(linearModel, direction="both")

# The k-nearest neighbor classification
library(class)
knnModel <- knn(train=housingTraining, test=housingTesting, cl=housingTraining$MDEV)
summary(knnModel)

plot(knnModel)

# Naïve Bayes
install.packages("e1071")
library(e1071)
nb <- naiveBayes(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT, data=housingTraining)
nb$tables$TAX

plot(nb$apriori)


# SVM  - Support vector machines
pima <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data")
colnames(pima) <- c("pregnancies","glucose","bp","triceps","insulin","bmi","pedigree","age","class")
summary(pima)

set.seed(3277)
library(caret)
pimaIndices <- createDataPartition(pima$class, p=0.75, list=FALSE)
pimaTraining <- pima[pimaIndices,]
pimaTesting <- pima[-pimaIndices,]

install.packages("kernlab")
library(kernlab)
bootControl <- trainControl(number = 200)
svmFit <- train(pimaTraining[,-9], pimaTraining[,9], method="svmRadial", tuneLength=5, trControl=bootControl, scaled=FALSE)
svmFit
predicted <- predict(svmFit$finalModel,newdata=pimaTesting[,-9])
plot(pimaTesting$class,predicted)

table(pred = predicted, true = pimaTesting[,9])
svmFit$finalModel

# K-means clustering

iris
irisIndices <- createDataPartition(iris$Species, p=0.75, list=FALSE)
irisTraining <- iris[irisIndices,]
irisTesting <- iris[-irisIndices,]
bootControl <- trainControl(number = 20)
km <- kmeans(irisTraining[,1:4], 3)
km

install.packages("clue")
library(clue)
cl_predict(km,irisTesting[,-5])
irisTesting[,5]

# Decision trees
library(rpart)

set.seed(3277)
#housing <- read.csv("housing.csv")
housing <- housing[order(housing$MDEV),]
trainingIndices <- createDataPartition(housing$MDEV, p=0.75, list=FALSE)
housingTraining <- housing[trainingIndices,]
housingTesting <- housing[-trainingIndices,]

housingFit <- rpart(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT, method="anova", data=housingTraining)

plot(housingFit)
text(housingFit, use.n=TRUE, all=TRUE, cex=.8)

treePredict <- predict(housingFit,newdata=housingTesting)

diff <- treePredict - housingTesting$MDEV
sumofsquares <- function(x) {return(sum(x^2))}
sumofsquares(diff)

# AdaBoost
#install.packages("ada")
library(ada)
adaModel <- ada(x=pimaTraining[,-9],y=pimaTraining$class,test.x=pimaTesting[,-9],test.y=pimaTesting$class)
adaModel

# Neural network
#install.packages('neuralnet')
library("neuralnet")

nnet <- neuralnet(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT,housingTraining, hidden=10, threshold=0.01)

nnet <- neuralnet(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT,housingTraining)

plot(nnet, rep="best")

results <- compute(nnet, housingTesting[,-14])
diff <- results$net.result - housingTesting$MDEV
sumofsquares(diff)

# Random forests
install.packages("randomForest")
library(randomForest)

forestFit <- randomForest(MDEV ~ CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PRATIO + B + LSTAT, data=housingTraining)
forestPredict <- predict(forestFit,newdata=housingTesting)

diff <- forestPredict - housingTesting$MDEV
sumofsquares(diff)

# If we gather the results of the sumofsquares test from the models in the chapter, we come across the following findings:
#3,555 from the linear regression
#3,926 from the decision tree
#11,016 from the neural net
#2,464 from the forest

#The forest model produced the best-fitting data.

# Anomaly detection
install.packages("DMwR")
library(DMwR)

data <- iris
nospecies <- data[,1:4]
scores <- lofactor(nospecies, k=3)
plot(density(scores))


# Association rules
install.packages("arules")
library(arules)
data <- read.csv("http://www.salemmarafi.com/wp-content/uploads/2014/03/groceries.csv")
head(data)
View(data)
rules <- apriori(data) 
rules
inspect(rules)
rules <- apriori(data, parameter = list(supp = 0.001, conf = 0.8))
rules
inspect(rules)

