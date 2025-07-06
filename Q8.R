# Load required library
library(readxl)  # For reading Excel files

# Set working directory and check if the file exists
setwd(".")
file_path <- "./data/aircraft.xlsx"

# Check if the file exists before reading it
if (!file.exists(file_path)) {
  stop("Error: The file 'aircraft.xlsx' was not found in the specified path. Please check the file location.")
}

# Read the Excel file
df_all <- read_excel(file_path)

# Check if the necessary columns are present
required_columns <- c("Maximum Speed (knots)", "Fuel Capacity (liters)", "Aircraft Model", "Number of Passengers")
missing_columns <- setdiff(required_columns, colnames(df_all))
if (length(missing_columns) > 0) {
  stop("Error: Missing required columns: ", paste(missing_columns, collapse = ", "))
}

# Function to calculate basic statistics (mean, variance, and standard deviation)
calculate_stats <- function(values) {
  if (length(values) == 0) {
    return(list(mean = NA, variance = NA, std_dev = NA))  # Return NA if input is empty
  }
  
  clean_values <- na.omit(values)  # Remove NA values
  
  list(
    mean = mean(clean_values),      # Mean of the cleaned values
    variance = var(clean_values),   # Variance of the cleaned values
    std_dev = sd(clean_values)      # Standard deviation of the cleaned values
  )
}

# Overall Maximum Speed Statistics
message("\nOverall Maximum Speed Statistics (All Aircraft):")
speed_stats <- calculate_stats(df_all$`Maximum Speed (knots)`)
message("- Mean: ", round(speed_stats$mean, 2), " knots")
message("- Variance: ", round(speed_stats$variance, 2))
message("- Standard Deviation: ", round(speed_stats$std_dev, 2), " knots\n")

# Fuel Capacity Statistics
message("Fuel Capacity Statistics (All Aircraft):")
fuel_stats <- calculate_stats(df_all$`Fuel Capacity (liters)`)
message("- Mean: ", round(fuel_stats$mean, 2), " liters")
message("- Variance: ", round(fuel_stats$variance, 2))
message("- Standard Deviation: ", round(fuel_stats$std_dev, 2), " liters\n")

# Airbus A320-specific Passenger Statistics
a320_data <- subset(df_all, `Aircraft Model` == "Airbus A320")
if (nrow(a320_data) > 0) {
  passenger_stats <- calculate_stats(a320_data$`Number of Passengers`)
  message("Passenger Statistics for Airbus A320:")
  message("- Mean number of passengers: ", round(passenger_stats$mean, 2))
  message("- Variance in number of passengers: ", round(passenger_stats$variance, 2))
  message("- Standard deviation in number of passengers: ", round(passenger_stats$std_dev, 2))
} else {
  message("\nError: No data found for Airbus A320.")  # If no data is found for Airbus A320
}

