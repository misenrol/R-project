library(readxl)
#load necessary libraries
library(ggplot2)
library(dplyr)

#read the Excel file
df <- setwd(".")
df <- read_excel("./data/aircraft.xlsx")

#define the function to calculate the mean passenger-to-fuel ratio
calculate_fuel_efficiency <- function(df) {
  #group by Aircraft Model and calculate mean of 'Number_of_Passengers' and 'Fuel_Capacity'
  df_fuel_efficiency <- df |>
    group_by(Aircraft.Model) |>
    summarise(
      Mean_Passenger = mean(Number.of.Passengers, na.rm = TRUE),
      Mean_Fuel_Capacity = mean(Fuel.Capacity..liters., na.rm = TRUE)
    ) |>
    mutate(
      Mean_Passenger_to_Fuel_Ratio = Mean_Passenger / Mean_Fuel_Capacity
    ) |>
    select(Aircraft.Model, Mean_Passenger_to_Fuel_Ratio)
  
  return(df_fuel_efficiency)
}

#assuming 'df' is the original dataset loaded in the R environment
# calculate the mean passenger-to-fuel ratio for each aircraft model
aircraft_fuel_efficiency <- calculate_fuel_efficiency(df)

#save the newly created dataframe as "aircraft_fuel_efficiency.csv"
write.csv(aircraft_fuel_efficiency, "aircraft_fuel_efficiency.csv", row.names = FALSE)

#load the saved dataframe to ensure it was saved correctly
df_fuel_efficiency <- read_excel("aircraft_fuel_efficiency.csv")

#merge the original dataframe with the 'aircraft_fuel_efficiency' dataframe on 'Aircraft.Model'
merged_aircraft <- merge(df, df_fuel_efficiency, by = "Aircraft.Model", all.x = TRUE)

#have the merged dataframe as 'merged_aircraft.csv'
write.csv(merged_aircraft, "merged_aircraft.csv", row.names = FALSE)

#check the merged dataframe
head(merged_aircraft)
