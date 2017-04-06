
# https://github.com/facebookincubator/prophet

#install.packages('prophet')


library(prophet)
library(dplyr)


# R
#df <- read.csv('../examples/example_wp_peyton_manning.csv') %>%
#  mutate(y = log(y))

df <- read.csv('https://raw.githubusercontent.com/facebookincubator/prophet/master/examples/example_wp_peyton_manning.csv') %>%
  mutate(y = log(y))

head(df)


m <- prophet(df)

future <- make_future_dataframe(m, periods = 365)
tail(future)

future
future$ds

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

forecast.pdioutput <- forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')]

forecast.pdioutput

#forecast.pdioutput$ds

#forecast
#m


plot(m, forecast)


prophet_plot_components(m, forecast)


