# Load required libraries
library(readxl)  # To read Excel files
library(ggplot2)  # For creating plots and visualizations

# Define file path and check if the file exists
file_path <- "./data/aircraft.xlsx"
if (!file.exists(file_path)) {
  stop("Error: The file 'aircraft.xlsx' does not exist in the specified path.")
}

# Read the Excel file
df_all <- read_excel(file_path)

# Filter the data for aircraft with "Piston" engines
piston_data <- subset(df_all, `Engine Type` == "Piston")

# Verify that there is data after filtering, and stop if empty
if (nrow(piston_data) == 0) {
  stop("No Piston engine aircraft found in the dataset.")
}

# Check if required columns exist in the filtered data
if (!all(c("Number of Passengers", "Fuel Capacity (liters)") %in% colnames(piston_data))) {
  stop("Essential columns missing: 'Number of Passengers' or 'Fuel Capacity (liters)'")
}

# Limit the dataset to the first 500 rows as the dataset is too large for visualization and it just looks clusted
if (nrow(piston_data) > 500) {
  piston_data <- piston_data[1:500, ]
  message("Showing the first 500 rows for visualization!")  # Message indicating row limitation
}

# Create a scatter plot showing the relationship between number of passengers and fuel capacity
scatter_plot <- ggplot(piston_data, aes(x = `Number of Passengers`, y = `Fuel Capacity (liters)`)) +
    geom_point(color = "#b83b58", size = 1.8, alpha = 0.5)  # Plot points with transparency to avoid overlap

# Customize the plot
scatter_plot <- scatter_plot +
    ggtitle("Piston Engine Aircraft Fuel Efficiency") +  # Title of the plot
    labs(subtitle = "Fuel Capacity vs Passenger Capacity") +  # Subtitle for more context
    xlab("Number of Passengers") +  # Label for the x-axis
    ylab("Fuel Capacity (liters)") +  # Label for the y-axis
    theme_minimal() + 
    theme(panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
          plot.title = element_text(face = "bold", size = 14),
          axis.title = element_text(size = 11))  # Adjust axis title size

# Add a linear trend line to the scatter plot to model the relationship
scatter_plot <- scatter_plot +
    geom_smooth(method = "lm", formula = y ~ x, color = "darkgray", se = FALSE)  # Linear model trend line

# Save the scatter plot as a PNG file
ggsave("piston_fuel_passengers-Q7.png", plot = scatter_plot, width = 8, height = 6, dpi = 300, bg = "white")

# Message that it has been saved!
message("Saved!")
