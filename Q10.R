# Load required library
library(readxl)  # For reading Excel files

# Set working directory
setwd(".")

# Check if the Excel file exists before reading it, if not give an error
file_path <- "./data/aircraft.xlsx"
if (!file.exists(file_path)) {
  stop("Error: The file 'aircraft.xlsx' was not found.")
}

# Read the Excel file
df_all <- read_excel(file_path)

# Function to compute passenger-to-fuel ratio by aircraft model
fuel_passenger_ratio_base <- function(data,
                                      aircraft_m_column = "Aircraft Model",
                                      fuel_column = "Fuel Capacity (liters)",
                                      passenger_column = "Number of Passengers") {

    # Check if the required columns exist in the dataset
    required_columns <- c(aircraft_m_column, fuel_column, passenger_column)
    if (!all(required_columns %in% colnames(data))) {
        stop("Error: One or more required columns are missing from the dataset. Please check the column names.")
    }

    # Compute passenger-to-fuel ratio, avoiding division by zero as that would lead to an error
    data$Passenger_to_Fuel_Ratio <- ifelse(data[[fuel_column]] == 0, NA,
                                           data[[passenger_column]] / data[[fuel_column]])

    # Remove rows with NA values (to ensure clean data for analysis)
    data <- na.omit(data)

    # Aggregate ratios and average passengers by aircraft model
    ranked_aircraft <- aggregate(
        list(Avg_Ratio = data$Passenger_to_Fuel_Ratio,
             Avg_Passengers = data[[passenger_column]]),
        by = list(Aircraft_Model = data[[aircraft_m_column]]),
        FUN = mean
    )

    # Count frequency of each aircraft model in the dataset
    freq_table <- table(data[[aircraft_m_column]])
    ranked_aircraft$Frequency <- freq_table[match(ranked_aircraft$Aircraft_Model, names(freq_table))]

    # Select Top 10 aircraft models based on passenger-to-fuel ratio
    ranked_aircraft <- ranked_aircraft[order(-ranked_aircraft$Avg_Ratio), ][1:10, ]

    return(ranked_aircraft)
}

# Execute the function and print the results
top_aircraft <- fuel_passenger_ratio_base(df_all)
print(top_aircraft)
