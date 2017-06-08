#install.packages("rwunderground")
#library(rwunderground)

# https://www.wunderground.com/weather/api/
# https://www.wunderground.com/weather/api/d/docs
# https://cran.r-project.org/web/packages/rwunderground/index.html

# Rforecastio – Simple R Package To Access forecast.io Weather Data
# https://rud.is/b/2013/09/08/rforecastio-simple-r-package-to-access-forecast-io-weather-data/



#?rwunderground

require(rwunderground)

## Not run: 
forecast10day(set_location(territory = "Hawaii", city = "Honolulu"))
forecast10day(set_location(airport_code = "JFK"))
forecast10day(set_location(zip_code = "90210"))
forecast10day(set_location(territory = "IR", city = "Tehran"))

## End(Not run)

#madrid_airport_weather <- forecast10day(set_location(airport_code = "MAD"))

forecast10day(set_location(country="Spain", territory = "Madrid", city = "Madrid"))

set_api_key(key = "5a92b38687c5327f")

lookup_country_code(name = "JFK")

list_airports()

list_airports()

astronomy(set_location(airport_code = "JFK"))

conditions(set_location(territory = "Hawaii", city = "Honolulu"))

forecast3day(set_location(territory = "Hawaii", city = "Honolulu"))

forecast3day(set_location(country.name.en = "ES", city = "Madrid"))

forecast3day(set_location(iso2c = "ES", city = "Madrid"))

# Working
forecast3day(set_location(territory = "ES", city = "Madrid"))

forecast10day(set_location(territory = "ES", city = "Madrid"))



list_countries()
list_states()
list_airports()

geolookup(set_location(territory = "Hawaii", city = "Honolulu"))

geolookup(set_location(territory = "ES", city = "Madrid"))

history(set_location(territory = "Hawaii", city = "Honolulu"), "20130101")

history(set_location(territory = "ES", city = "Madrid"), "20160101")

history(set_location(territory = "ES", city = "Madrid"), "20170508")

history(set_location(territory = "UK", city = "London"), "20170508")


hourly(set_location(territory = "Hawaii", city = "Honolulu"))

lookup_airport("Honolulu")

lookup_airport("Madrid")

forecast10day(set_location(airport_code = "MAD"))

planner(set_location(territory = "Hawaii", city = "Honolulu"),
        start_date = "0101", end_date = "0131")

rawtide(set_location(territory = "Hawaii", city = "Honolulu"))


satellite(set_location(territory = "Hawaii", city = "Honolulu"))


set_location(zip_code = "90210")
set_location(territory = "Hawaii", city = "Honolulu")
set_location(territory = "Kenya", city = "Mombasa")
set_location(airport_code = "SEA")
set_location(PWS_id = "KMNCHASK10")
set_location(lat_long="40.6892,-74.0445")
set_location(autoip = "172.227.205.140")
set_location()




