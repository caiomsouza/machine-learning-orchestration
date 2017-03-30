# install.packages("jsonlite")
# install.packages("devtools")
#devtools::install_github("dgrtwo/stackr")
# if you want to access the vignettes from within the package:
#devtools::install_github("dgrtwo/stackr", build_vignettes = TRUE)
#browseVignettes("stackr")

library(stackr)

q <- stack_questions()

a <- stack_answers()

stack_questions(11227809)

stack_answers(c(179147, 2219560, 180085))

stack_users(712603)

stack_tags(c("r", "ggplot2", "dplyr"))

stack_tags(c("ctools", "kettle", "pentaho", "weka", "oracle", "ibm"))

stack_tags(c("saiku", "weka"))

stack_tags(c("SPSS", "R", "Python", "weka", "Spark", "Hadoop", "BigData"))





