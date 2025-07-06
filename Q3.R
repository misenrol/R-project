library(readxl)
library(ggplot2)

# Set working directory and load Excel file
setwd(".")
df <- read_excel("./data/aircraft.xlsx")

# Define the function to calculate the differences
calculate_weight_differences <- function(df) {
  # Calculate the difference between Maximum Takeoff Weight and Empty Weight
  df$Empty_Mx_Takeoff_Diff <- df$`Maximum Takeoff Weight (kg)` - df$`Empty Weight (kg)`
  
  # Calculate the difference between Maximum Landing Weight and Empty Weight
  df$Empty_Max_landing_Diff <- df$`Maximum Landing Weight (kg)` - df$`Empty Weight (kg)`
  
  return(df)
}

# Apply the function
df <- calculate_weight_differences(df)

# Preview result
head(df)

# Save as R binary
save(df, file = "./data/aircraft_with_weight_differences.RData")
