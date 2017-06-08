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

titanic_tbl.df <- as.data.frame(titanic_tbl)

titanic_tbl.df
