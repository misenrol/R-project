library(readxl)
#load necessary libraries
library(ggplot2)

#read the excel file
df <- setwd(".")
df <- read_excel("./data/aircraft.xlsx") #chnage file location as needed

#calculate the frequency count of each unique engine type
freq_count <- table(df$'Engine Type')

#print the frequency count
print(freq_count)
