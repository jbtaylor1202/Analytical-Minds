#http://theanalyticalminds.blogspot.co.uk

source(file = "Data Prep.R")

library(package = ggplot2)

#EXAMPLES
#Scatterplot with season controlling the colour of points
ggplot(data = weather, aes(x = l.temp, y=h.temp, colour=season))+geom_point()
#Scatterplot with dir.wind controlling the colour of points (overwriting season)
ggplot(data = weather, aes(x = l.temp, y=h.temp, colour=season))+geom_point(aes(colour=dir.wind))
# This sets the parameter colour to a constant instead of mapping it to data. This is outside aes()!
ggplot(data = weather, aes(x = h.temp, y= l.temp)) + geom_point(colour = "blue")
# Mapping to data (aes) and setting to a constant inside the geom layer
ggplot(data = weather, aes(x = l.temp, y= h.temp)) + geom_point(aes(size=rain), colour = "blue")              
# This is a MISTAKE - mapping with aes() when intending to set an aesthetic. It will create a column in the data named "blue", which is not what we want.
#ggplot(data = weather, aes(x = l.temp, y= h.temp)) + geom_point(aes (colour = "blue"))


# Time series of average daily temperature, with smoother curve
ggplot(weather,aes(x = date,y = ave.temp)) +
  geom_point(colour="dark blue") +
  geom_smooth(colour = "red",size = 1) +
  scale_y_continuous(limits = c(5,30), breaks = seq(5,30,5)) +
  ggtitle ("Daily average temperature") +
  xlab("Date") +  ylab ("Average Temperature ( ºC )")

# Same but with colour varying
ggplot(weather,aes(x = date,y = ave.temp)) + 
  geom_point(aes(colour = ave.temp)) +
  scale_colour_gradient2(low = "blue", mid = "green" , high = "red", midpoint = 16) + 
  geom_smooth(color = "red",size = 0.5) +
  scale_y_continuous(limits = c(5,30), breaks = seq(5,30,5)) +
  ggtitle ("Daily average temperature") +
  xlab("Date") +  ylab ("Average Temperature ( ºC )")

#Analysing the temperature by season - density geom
# Distribution of the average temperature by season - density plot
ggplot(weather,aes(x = ave.temp, colour = season)) +
  geom_density() +
  scale_x_continuous(limits = c(5,30), breaks = seq(5,30,5)) +
  ggtitle ("Temperature distribution by season") +
  xlab("Average temperature ( ºC )") +  ylab ("Probability")

#Analysing the temperature by month - violin geom with jittered points overlaid
# Label the months - Jan...Dec is better than 1...12
weather$month = factor(weather$month,
                       labels = c("Jan","Fev","Mar","Apr",
                                  "May","Jun","Jul","Aug","Sep",
                                  "Oct","Nov","Dec"))

# Distribution of the average temperature by month - violin plot,
# with a jittered point layer on top, and with size mapped to amount of rain
ggplot(weather,aes(x = month, y = ave.temp)) +
  geom_violin(fill = "orange") +
  geom_point(aes(size = rain), colour = "blue", position = "jitter") +
  ggtitle ("Temperature distribution by month") +
  xlab("Month") +  ylab ("Average temperature ( ºC )")

#Analysing  the correlation between low and high temperatures
# Scatter plot of low vs high daily temperatures, with a smoother curve for each season
ggplot(weather,aes(x = l.temp, y = h.temp)) +
  geom_point(colour = "firebrick", alpha = 0.3) + 
  geom_smooth(aes(colour = season),se= F, size = 1.1) +
  ggtitle ("Daily low and high temperatures") +
  xlab("Daily low temperature ( ºC )") +  ylab ("Daily high temperature ( ºC )") 

#Distribution of low and high temperatures by the time of day
library(reshape2)
temperatures <- weather[c("day.count","h.temp.hour","l.temp.hour")] 
head(temperatures)
dim(temperatures)

#The temperatures are molten into a single variable called l.h.temp 
temperatures <- melt(temperatures,id.vars = "day.count",
                       variable.name = "l.h.temp", value.name = "hour")
head(temperatures)
tail(temperatures)
dim(temperatures)
temperatures$hour <- factor(temperatures$hour,levels=0:23)

# Now we can just fill the colour by the grouping variable to visualise the two distributions 
ggplot(temperatures) +
  geom_bar(aes(x = hour, fill = l.h.temp)) +
  scale_fill_discrete(name= "", labels = c("Daily high","Daily low")) +
  scale_y_continuous(limits = c(0,100)) +
  ggtitle ("Low and high temperatures - time of the day") +
  xlab("Hour") +  ylab ("Frequency")
