#install.packages("titanic")

library(sparklyr)
library(dplyr)
library(tidyr)
library(titanic)
library(ggplot2)
library(purrr)

setwd("~/GitHub/caiomsouza/machine-learning-orchestration/samples/apache-spark-ml/titanic")

# Connect to local spark cluster and load data
sc <- spark_connect(master = "local", version = "2.0.0")
spark_read_parquet(sc, name = "titanic", path = "titanic-parquet")
titanic_tbl <- tbl(sc, "titanic")

#titanic_tbl

# Partition the data
partition <- titanic_tbl %>% 
  mutate(Survived = as.numeric(Survived), SibSp = as.numeric(SibSp), Parch = as.numeric(Parch)) %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked) %>%
  sdf_partition(train = 0.75, test = 0.25, seed = 8585)
# Create table references
train_tbl <- partition$train
test_tbl <- partition$test

# Model survival as a function of several predictors
ml_formula <- formula(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked)


# Train a logistic regression model
ml_log <- ml_logistic_regression(train_tbl, ml_formula)

## Decision Tree
ml_dt <- ml_decision_tree(train_tbl, ml_formula)

## Random Forest
ml_rf <- ml_random_forest(train_tbl, ml_formula)

## Gradient Boosted Tree
ml_gbt <- ml_gradient_boosted_trees(train_tbl, ml_formula)

## Naive Bayes
ml_nb <- ml_naive_bayes(train_tbl, ml_formula)

## Neural Network
ml_nn <- ml_multilayer_perceptron(train_tbl, ml_formula, layers = c(8,15,2))

# Bundle the modelss into a single list object
ml_models <- list(
  "Logistic" = ml_log,
  "Decision Tree" = ml_dt,
  "Random Forest" = ml_rf,
  "Gradient Boosted Trees" = ml_gbt,
  "Naive Bayes" = ml_nb,
  "Neural Net" = ml_nn
)


# Create a function for scoring
score_test_data <- function(model, data=test_tbl){
  pred <- sdf_predict(model, data)
  select(pred, Survived, prediction)
}

# Score all the models
ml_score <- lapply(ml_models, score_test_data)


titanic_tbl.df <- as.data.frame(titanic_tbl)

titanic_tbl.df
