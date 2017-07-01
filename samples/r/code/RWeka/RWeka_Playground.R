

#https://cran.r-project.org/web/packages/RWeka/RWeka.pdf
#https://www.r-bloggers.com/r-talks-to-weka-about-data-mining/



library(RWeka)


iris_j48 <- J48(Species ~ ., data = iris)
iris_j48


summary(iris_j48)

m <- iris

e <- evaluate_Weka_classifier(m,
                              cost = matrix(c(0,2,1,0), ncol = 2),
                              numFolds = 10, complexity = TRUE,
                              seed = 123, class = TRUE)



iris_AutoWeka <- AutoWeka(Species ~ ., data = iris)
iris_j48



## Use some example data.
w <- read.arff(system.file("arff","weather.nominal.arff",
                           package = "RWeka"))
## Identify a decision tree.
m <- J48(play~., data = w)
m
## Use 10 fold cross-validation.
e <- evaluate_Weka_classifier(m,
                              cost = matrix(c(0,2,1,0), ncol = 2),
                              numFolds = 10, complexity = TRUE,
                              seed = 123, class = TRUE)
e
summary(e)
e$details




x <- read.arff(system.file("arff", "contact-lenses.arff",
                           package = "RWeka"))
## Apriori with defaults.
Apriori(x)
## Some options: set required number of rules to 20.
Apriori(x, Weka_control(N = 20))
## Not run:
## Requires Weka package 'tertius' to be installed.
## Tertius with defaults.
Tertius(x)
## Some options: only classification rules (single item in the RHS).
Tertius(x, Weka_control(S = TRUE))
## End(Not run)




## Linear regression:
## Using standard data set 'mtcars'.
LinearRegression(mpg ~ ., data = mtcars)
## Compare to R:
step(lm(mpg ~ ., data = mtcars), trace = 0)
## Using standard data set 'chickwts'.
LinearRegression(weight ~ feed, data = chickwts)
## (Note the interactions!)
## Logistic regression:
## Using standard data set 'infert'.
STATUS <- factor(infert$case, labels = c("control", "case"))
Logistic(STATUS ~ spontaneous + induced, data = infert)
## Compare to R:
glm(STATUS ~ spontaneous + induced, data = infert, family = binomial())
## Sequential minimal optimization algorithm for training a support
## vector classifier, using am RBF kernel with a non-default gamma


## parameter (argument '-G') instead of the default polynomial kernel
## (from a question on r-help):
SMO(Species ~ ., data = iris,
    control = Weka_control(K =
                             list("weka.classifiers.functions.supportVector.RBFKernel", G = 2)))
## In fact, by some hidden magic it also "works" to give the "base" name
## of the Weka kernel class:
SMO(Species ~ ., data = iris,
    control = Weka_control(K = list("RBFKernel", G = 2)))



## Use AdaBoostM1 with decision stumps.
m1 <- AdaBoostM1(Species ~ ., data = iris,
                 control = Weka_control(W = "DecisionStump"))
table(predict(m1), iris$Species)
summary(m1) # uses evaluate_Weka_classifier()
## Control options for the base classifiers employed by the meta
## learners (apart from Stacking) can be given as follows:
m2 <- AdaBoostM1(Species ~ ., data = iris,
                 control = Weka_control(W = list(J48, M = 30)))



m1 <- J48(Species ~ ., data = iris)
## print and summary
m1
summary(m1) # calls evaluate_Weka_classifier()
table(iris$Species, predict(m1)) # by hand

#install.packages("partykit")

## visualization
## use partykit package
if(require("partykit", quietly = TRUE)) plot(m1)
## or Graphviz
write_to_dot(m1)
## or Rgraphviz
## Not run:
#install.packages("Rgraphviz")

library("Rgraphviz")
ff <- tempfile()
write_to_dot(m1, ff)
plot(agread(ff))
## End(Not run)
## Using some Weka data sets ...
## J48
DF2 <- read.arff(system.file("arff", "contact-lenses.arff",
                             package = "RWeka"))
m2 <- J48(`contact-lenses` ~ ., data = DF2)
m2
table(DF2$`contact-lenses`, predict(m2))
if(require("partykit", quietly = TRUE)) plot(m2)
## M5P
DF3 <- read.arff(system.file("arff", "cpu.arff", package = "RWeka"))
m3 <- M5P(class ~ ., data = DF3)
m3
if(require("partykit", quietly = TRUE)) plot(m3)
## Logistic Model Tree.
DF4 <- read.arff(system.file("arff", "weather.arff", package = "RWeka"))
m4 <- LMT(play ~ ., data = DF4)
m4
table(DF4$play, predict(m4))
## Larger scale example.
if(require("mlbench", quietly = TRUE)
   && require("partykit", quietly = TRUE)) {
  ## Predict diabetes status for Pima Indian women
  data("PimaIndiansDiabetes", package = "mlbench")
  ## Fit J48 tree with reduced error pruning
  m5 <- J48(diabetes ~ ., data = PimaIndiansDiabetes,
            control = Weka_control(R = TRUE))
  plot(m5)
  ## (Make sure that the plotting device is big enough for the tree.)
}


cl1 <- SimpleKMeans(iris[, -5], Weka_control(N = 3))
cl1
table(predict(cl1), iris$Species)
## Not run:
## Requires Weka package 'XMeans' to be installed.
## Use XMeans with a KDTree.
cl2 <- XMeans(iris[, -5],
              c("-L", 3, "-H", 7, "-use-kdtree",
                "-K", "weka.core.neighboursearch.KDTree -P"))
cl2
table(predict(cl2), iris$Species)




## Not run:
## Start by building/refreshing the cache.
WPM("refresh-cache")
## Show the packages installed locally.
WPM("list-packages", "installed")
## Show the packages available from the central Weka package
## repository and not installed locally.
WPM("list-packages", "available")
## Show repository information about package XMeans.
WPM("package-info", "repository", "XMeans")

write.arff(iris, file = "iris_test.arff")













#install.packages("tm")
#install.packages("Rgraphviz")

#source("https://bioconductor.org/biocLite.R")
#biocLite("Rgraphviz")

library("RWeka")
library("tm")
library("Rgraphviz")


data("crude")

BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tdm <- TermDocumentMatrix(crude, control = list(tokenize = BigramTokenizer))

inspect(tdm[340:345,1:10])

plot(tdm, terms = findFreqTerms(tdm, lowfreq = 2)[1:50], corThreshold = 0.5)

