#load necessary libraries
library(ggplot2)
library(readxl)  # or read.csv if using CSV files

#read the dataset (update the path to your file)
df <- setwd(".")
df <- read_excel("./data/aircraft.xlsx")

#choose a specific engine type (update the engine type as needed)
#choose a specific engine type
chosen_engine_type <- "Turbofan"  # Replace this with your chosen engine type

#filter the dataset based on the chosen engine type
filtered_df <- subset(df, `Engine Type` == chosen_engine_type)

#create a histogram of the 'Maximum Takeoff Weight' column for the filtered dataset
ggplot(filtered_df, aes(x = `Maximum Takeoff Weight (kg)`)) +
  geom_histogram(binwidth = 1500, color = "black") +
  labs(title = paste("Maximum Takeoff Weight for", chosen_engine_type, "Engine Type"),
       x = "Maximum Takeoff Weight (kg)",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5))

#save the histogram as a PNG image
ggsave("max_takeoff_weight_histogram-Q5.png")
