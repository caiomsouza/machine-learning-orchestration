
# https://www.credera.com/blog/business-intelligence/twitter-analytics-using-r-part-1-extract-tweets/

#install.packages("twitteR")
#install.packages("ROAuth")
library("twitteR")
library("ROAuth")

# Download "cacert.pem" file
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")

#create an object "cred" that will save the authenticated object that we can use for later sessions
cred <- OAuthFactory$new(consumerKey='XXXXXXXXXXXXXXXXXX',
                         consumerSecret='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

cred <- OAuthFactory$new(consumerKey='A8dkIlhIkk9rfeAZPX2p0yUX4',
                         consumerSecret='fs7c9VZcbvjDVZXAdvjW7lXuDAZ1HgLoL2rrkV1fAKXNPCbglb',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# Executing the next step generates an output --> To enable the connection, please direct your web browser to: <hyperlink> . Note:  You only need to do this part once
cred$handshake(cainfo="cacert.pem")

# PIN: 4053314

#save for later use for Windows
save(cred, file="twitter authentication.Rdata")


load("twitter authentication.Rdata")
registerTwitterOAuth(cred)

?setup_twitter_oauth

consumer_key <- "A8dkIlhIkk9rfeAZPX2p0yUX4"
consumer_secret <- "fs7c9VZcbvjDVZXAdvjW7lXuDAZ1HgLoL2rrkV1fAKXNPCbglb"
access_token <- "36965900-pufEdzIa94GbXeZ2tSTs4XmH9Hv9T83l1nCV0b0G7"
access_secret <- "AuRIIQLys7GOsJFepjqr4IiKJREuFN3p5b7CncEd3O7H3"
AuthenticateWithTwitterAPI(api_key=my_api_key, api_secret=my_api_secret,
                           access_token=my_access_token, access_token_secret=my_access_token_secret)


setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

search.string <- "#nba"
no.of.tweets <- 100

tweets <- searchTwitter(search.string, n=no.of.tweets, cainfo="cacert.pem", lang="en")
tweets

tweets <- searchTwitter(search.string, n=no.of.tweets, lang="en")
tweets












my_api_key <- "A8dkIlhIkk9rfeAZPX2p0yUX4"
my_api_secret <- "fs7c9VZcbvjDVZXAdvjW7lXuDAZ1HgLoL2rrkV1fAKXNPCbglb"
my_access_token <- "36965900-pufEdzIa94GbXeZ2tSTs4XmH9Hv9T83l1nCV0b0G7"
my_access_token_secret <- "AuRIIQLys7GOsJFepjqr4IiKJREuFN3p5b7CncEd3O7H3"
AuthenticateWithTwitterAPI(api_key=my_api_key, api_secret=my_api_secret,
                           access_token=my_access_token, access_token_secret=my_access_token_secret)


