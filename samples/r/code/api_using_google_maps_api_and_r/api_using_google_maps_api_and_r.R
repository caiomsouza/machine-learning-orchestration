# This code was original created by Jose Gonzalez https://github.com/josecarlosgonz 
# and adapted by Caio Moreno https://github.com/caiomsouza
# https://gist.github.com/josecarlosgonz/6417633


library(RCurl)
library(RJSONIO)

# install.packages("RJSONIO")

library(plyr)

url <- function(address, return.call = "json", sensor = "false") {
  root <- "http://maps.google.com/maps/api/geocode/"
  u <- paste(root, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(u))
}

geoCode <- function(address,verbose=FALSE) {
  if(verbose) cat(address,"\n")
  u <- url(address)
  doc <- getURL(u)
  x <- fromJSON(doc,simplify = FALSE)
  if(x$status=="OK") {
    lat <- x$results[[1]]$geometry$location$lat
    lng <- x$results[[1]]$geometry$location$lng
    location_type  <- x$results[[1]]$geometry$location_type
    formatted_address  <- x$results[[1]]$formatted_address
    return(c(lat, lng, location_type, formatted_address))
    Sys.sleep(0.5)
  } else {
    return(c(NA,NA,NA, NA))
  }
}


#address <- geoCode("The White House, Washington, DC")
#address

#address <- c("The White House, Washington, DC","The Capitol, Washington, DC")
#locations  <- ldply(address, function(x) geoCode(x))
#names(locations)  <- c("lat","lon","location_type", "formatted")
#head(locations)

address <- c("Wellington, New Zeland","Madrid, Spain")
locations  <- ldply(address, function(x) geoCode(x))
names(locations)  <- c("lat","lon","location_type", "formatted")
head(locations)

address <- c("Wellington, New Zeland")
locations  <- ldply(address, function(x) geoCode(x))
names(locations)  <- c("lat","lon","location_type", "formatted")
head(locations)


# Dataset
address.input <- c("Parque del Retiro, Madrid")

address.raw <- as.data.frame(address.input)

locations  <- ldply(address.raw, function(x) geoCode(x))
names(locations)  <- c("lat","lon","location_type", "formatted")
#head(locations)
locations



#address.input <- c("Parque del Retiro, Madrid")

locations  <- ldply(address.input, function(x) geoCode(x))
names(locations)  <- c("address.input","lat","lon","location_type", "formatted")
locations

