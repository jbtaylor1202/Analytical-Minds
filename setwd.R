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
