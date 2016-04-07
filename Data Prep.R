#http://theanalyticalminds.blogspot.co.uk

setwd("~/Documents/R Working Directory/Analytical Minds")

#Load and examine data
weather<-read.csv(file = "weather_2014.csv",sep = ";", stringsAsFactors=FALSE)

dim(weather)
names(weather)
head(weather)
str(weather)

#Check for NAs
sum(is.na(weather))
nrow(weather)
sum(complete.cases(weather))
nrow(weather)==sum(complete.cases(weather))

#Create factors
summary(weather$season)
weather$season<-factor(weather$season, levels=c("Spring", "Summer", "Autumn", "Winter"))        
summary(weather$season)

weather$day<-as.factor(weather$day)
weather$month<-as.factor(weather$month)
weather$dir.wind<-as.factor(weather$dir.wind)

#Collapsing Wind Direction from 16 to 8 directions
length(unique(weather$dir.wind))
table(weather$dir.wind)
rel<-round(prop.table(table(weather$dir.wind))*100,digits = 1)
sort(rel,decreasing = TRUE)

weather$dir.wind.8<-weather$dir.wind #create new variable (copy) in dataframe
weather$dir.wind.8<-ifelse(weather$dir.wind %in% c("NNE","ENE"),"NE", as.character(weather$dir.wind.8))
weather$dir.wind.8<-ifelse(weather$dir.wind %in% c("NNW","WNW"),"NW", as.character(weather$dir.wind.8))
weather$dir.wind.8<-ifelse(weather$dir.wind %in% c("WSW","SSW"),"SW", as.character(weather$dir.wind.8))
weather$dir.wind.8<-ifelse(weather$dir.wind %in% c("ESE","SSE"),"SE", as.character(weather$dir.wind.8))
weather$dir.wind.8<-factor(weather$dir.wind.8,levels = c("N","NE","E","SE","S","SW","W","NW"))

length(unique(weather$dir.wind.8))
table(weather$dir.wind.8)
rel2<-round(prop.table(table(weather$dir.wind.8))*100,digits = 2)
rel3<-round(round(prop.table(table(weather$dir.wind.8,weather$season),margin = 2)*100,digits = 3))

#Add date
first.day<-"2014-01-01"
class(first.day)
first.day<-as.Date(first.day)
class(first.day)
weather$date<-first.day+weather$day.count-1
head(weather$day.count)
head(weather$date)

#Round times to nearest hour
#Store time and date as POSIXlt class
l.temp.time.date<-as.POSIXlt(paste(weather$date,weather$l.temp.time))
head(l.temp.time.date)
l.temp.time.date<-round(l.temp.time.date,"hours")
head(l.temp.time.date)
attributes(l.temp.time.date)

h.temp.time.date<-as.POSIXlt(paste(weather$date,weather$h.temp.time))
head(h.temp.time.date)
h.temp.time.date<-round(h.temp.time.date,"hours")
head(h.temp.time.date)
attributes(h.temp.time.date)

#Extract the value of the hour attribute as a number and add to the data set
weather$l.temp.hour<-l.temp.time.date[["hour"]]
head(weather$l.temp.hour)
weather$l.temp.hour<-as.factor(weather$l.temp.hour)
head(weather$l.temp.hour)

weather$h.temp.hour<-h.temp.time.date[["hour"]]
head(weather$h.temp.hour)
weather$h.temp.hour<-as.factor(weather$h.temp.hour)
head(weather$h.temp.hour)

#Final prepared data set
str(weather)
