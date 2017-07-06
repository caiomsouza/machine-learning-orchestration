# ISOWeek

# https://cran.r-project.org/web/packages/ISOweek/ISOweek.pdf
# https://en.wikipedia.org/wiki/ISO_week_date


install.packages("ISOweek")

library(ISOweek)

x <- paste(1999:2011, "-12-31", sep = "")
y <- as.Date(x)
data.frame(date = format(y), weekdate = date2ISOweek(y))
data.frame(date = x, weekdate = date2ISOweek(x))


x <- paste(1999:2011, "-12-31", sep = "")
y <- as.Date(x)
data.frame(date = format(y), week = ISOweek(y))
data.frame(date = x, week = ISOweek(x))


w <- paste("2009-W53", 1:7, sep = "-")
data.frame(weekdate = w, date = ISOweek2date(w))
# convert from calendar date to week date and back to calendar date
x <- paste(1999:2011, "-12-31", sep = "")
w <- date2ISOweek(x)
d <- ISOweek2date(w)
data.frame(date = x, weekdate = w, date2 = d)

x <- paste(1999:2011, "-12-31", sep = "")
y <- as.Date(x)
data.frame(date = format(y), weekday = ISOweekday(y))
data.frame(date = x, weekday = ISOweekday(x))


