
# Version 3.10.5.3 (Last Stable Version - CM_20170712)
# Caio

# http://h2o-release.s3.amazonaws.com/h2o/rel-vajda/3/index.html

# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

# Next, we download packages that H2O depends on.
pkgs <- c("statmod","RCurl","jsonlite")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}

# Now we download, install and initialize the H2O package for R.
install.packages("h2o", type="source", repos="http://h2o-release.s3.amazonaws.com/h2o/rel-vajda/3/R")

# Finally, let's load H2O and start up an H2O cluster
library(h2o)
h2o.init()

setwd("~/Desktop")
train <- h2o.importFile("kaggle-santander-train.csv")

#head(train)

# https://h2o-release.s3.amazonaws.com/h2o/rel-vapnik/1/docs-website/h2o-docs/automl.html
# To test H2o AutoML is necessary to install the version 3.11.0.3888 or superior
# http://h2o-release.s3.amazonaws.com/h2o/rel-vapnik/1/index.html

# I will install 3.12.0.1 (http://h2o-release.s3.amazonaws.com/h2o/rel-vapnik/1/R/src/contrib/h2o_3.12.0.1.tar.gz)

# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

# Next, we download packages that H2O depends on.
pkgs <- c("statmod","RCurl","jsonlite")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}

# Now we download, install and initialize the H2O package for R.
install.packages("h2o", type="source", repos="http://h2o-release.s3.amazonaws.com/h2o/rel-vapnik/1/R")

# Finally, let's load H2O and start up an H2O cluster
library(h2o)
h2o.init()

setwd("~/Desktop")
train <- h2o.importFile("kaggle-santander-train.csv")
test <- h2o.importFile("test.csv")

aml <- h2o.automl(y = "TARGET", training_frame = train, max_runtime_secs = 60)

lb <- aml@leaderboard 

lb

aml

aml@leader

pred <- h2o.predict(aml, test)  # predict(aml, test) also works

# or:
pred <- h2o.predict(aml@leader, test)

pred

# Another Use Case

# Import a sample binary outcome train/test set into H2O
train <- h2o.importFile("https://s3.amazonaws.com/erin-data/higgs/higgs_train_10k.csv")
test <- h2o.importFile("https://s3.amazonaws.com/erin-data/higgs/higgs_test_5k.csv")

# Identify predictors and response
y <- "response"
x <- setdiff(names(train), y)

# For binary classification, response should be a factor
train[,y] <- as.factor(train[,y])
test[,y] <- as.factor(test[,y])

aml <- h2o.automl(x = x, y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 30)

# View the AutoML Leaderboard
lb <- aml@leaderboard
lb


# The leader model is stored here
aml@leader


# If you need to generate predictions on a test set, you can make
# predictions directly on the `"H2OAutoML"` object, or on the leader
# model object directly

pred <- h2o.predict(aml, test)  # predict(aml, test) also works

pred

# or:
pred <- h2o.predict(aml@leader, test)


# https://blog.h2o.ai/2013/08/run-h2o-from-within-r/
# https://github.com/h2oai/h2o-3/blob/master/h2o-r/h2o-package/R/automl.R
# https://github.com/ledell?tab=repositories
# http://www.stat.berkeley.edu/~ledell/
# 



