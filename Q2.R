library(readxl)
##QUESTION2##
library(ggplot2)

setwd(".")
df <- read_excel("./data/aircraft.xlsx")


freq_count <- table(df$`Engine Type`)
#cal the number of observations in the Engine.Type column
total_observations <- length(df$`Engine Type`)

#cal the proportions by dividing the frequency count by total observations
engine_type_proportions <- freq_count / total_observations

#add the proportions as new column to the data frame
df$engine_type_proportions <- engine_type_proportions[as.factor(df$`Engine Type`)]

#print the updated dataframe with the new column
head(df)
