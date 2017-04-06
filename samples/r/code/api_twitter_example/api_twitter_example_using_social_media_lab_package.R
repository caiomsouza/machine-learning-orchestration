# SocialMediaLab
# https://cran.r-project.org/web/packages/SocialMediaLab/index.html
# https://cran.r-project.org/web/packages/SocialMediaLab/SocialMediaLab.pdf

# install.packages("SocialMediaLab")

library(SocialMediaLab)

# Twitter App Page
# https://apps.twitter.com/



# PythonTwitterCollector

my_api_key <- "A8dkIlhIkk9rfeAZPX2p0yUX4"
my_api_secret <- "fs7c9VZcbvjDVZXAdvjW7lXuDAZ1HgLoL2rrkV1fAKXNPCbglb"
my_access_token <- "36965900-pufEdzIa94GbXeZ2tSTs4XmH9Hv9T83l1nCV0b0G7"
my_access_token_secret <- "AuRIIQLys7GOsJFepjqr4IiKJREuFN3p5b7CncEd3O7H3"
AuthenticateWithTwitterAPI(api_key=my_api_key, api_secret=my_api_secret,
                           access_token=my_access_token, access_token_secret=my_access_token_secret)

#myTwitterData <- CollectDataTwitter(searchTerm = "Pentaho", numTweets = 100, writeToFile = TRUE)


#myTwitterData <- CollectDataTwitter(searchTerm = "Google Campus Madrid", numTweets = 100, writeToFile = TRUE)

myTwitterData <- CollectDataTwitter(searchTerm = "#docker", numTweets = 100)

class(myTwitterData$text)
class(myTwitterData)

myTwitterData.df <- as.data.frame(myTwitterData)
myTwitterData.df
class(myTwitterData.df)


library(stackr)
stack_tags <- stack_tags(c("pentaho", "SPSS", "SAS", "R", "Python", "weka", "Spark", "Hadoop", "BigData", "ibm", "oracle", "ctools", "kettle", "pdi", "saiku"))
stack_tags

class(stack_tags)

df <- tweetsToDF(myTwitterData)



