#Are there any good predictors, in our data, for the occurrence of rain on a given day?

# After framing the question, and before fitting any model, EDA techniques (such as visualisation) are used to gain insight from the data. Here are the steps I usually take at this stage:
# Analyse the (continuous) dependent variable - at least, make an histogram of the distribution; when applicable, plot the variable against time to see the trend. Can the continuous variable be transformed to a binary one (i.e., did it rain or not on a particular day?), or to a multicategorical one (i.e., was the rain none, light, moderate, or heavy on a particular day?).
# Search for correlations between the dependent variable and the continuous independent variables - are there any strong correlations? Are they linear or non-linear?
# Do the same as above but try to control for other variables (faceting in ggplot2 is very useful  to do this), in order to assess for confounding and effect modification. Does the association between two continuous variables hold for different levels of a third variable, or is modified by them? (e.g., if there is a strong positive correlation between the rain amount and the wind gust maximum speed, does that hold regardless of the season of the year, or does it happen only in the winter?)
# Search for associations between the dependent variable and the categorical independent variables (factors) - does the mean or median of the dependent variable change depending on the level of the factor? What about the outliers, are they evenly distributed across all levels, or seem to be present in only a few of them? 



#Exploring the dependent variable - daily rain amount
# Time series of the daily rain amount, with smoother curve



