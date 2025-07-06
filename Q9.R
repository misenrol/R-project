# Load required libraries
library(readxl)  # For reading Excel files
library(ggplot2)  # For creating plots

# Set working directory and check if the file exists
setwd(".")
if (!file.exists("./data/aircraft.xlsx")) {
  stop("The Excel file 'aircraft.xlsx' does not exist in the specified path.")
}

# Read the Excel file
df_all <- read_excel("./data/aircraft.xlsx")

# Check if required columns exist
required_columns <- c("Aircraft Model", "Maximum Landing Weight (kg)", "Maximum Speed (knots)")
missing_columns <- setdiff(required_columns, colnames(df_all))
if(length(missing_columns) > 0) {
  stop("Missing required columns: ", paste(missing_columns, collapse = ", "))
}

# Filter for Airbus A320 aircraft
a320_data <- subset(df_all, `Aircraft Model` == "Airbus A320")

# Limit data to first 100 rows if more are available
if (nrow(a320_data) > 100) {
  a320_data <- a320_data[1:100, ]
  # Message to say that the program selected 100 rows out of X available rows for user info
  message("Selected first 100 rows (total available: ", nrow(df_all), ")")
} else {
  message("Using all ", nrow(a320_data), " available rows")
}

# Create scatter plot of Airbus A320 performance
scatter_plot <- ggplot(a320_data, aes(x = `Maximum Landing Weight (kg)`, y = `Maximum Speed (knots)`)) +
  geom_point(color = "#b83b58", size = 3, alpha = 0.8) +
  labs(
    title = "Airbus A320 Performance Analysis: Landing Weight vs Maximum Speed",
    x = "Maximum Landing Weight (kg)",
    y = "Maximum Speed (knots)"
  ) +
  theme_minimal() +
  theme(
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1),  # Add border to plot area
    plot.title = element_text(face = "bold", size = 14),
    axis.title = element_text(size = 12)
  ) +
  geom_smooth(method = "lm", color = "darkgray", se = FALSE)  # Add a linear trend line

# Save the plot as a PNG file
ggsave("a320_landing_weight_vs_speed.png", plot = scatter_plot, width = 9, height = 6, dpi = 300, bg = "white")

# Message to confirm the plot was saved!
message("Plot saved as 'a320_landing_weight_vs_speed-Q9.png'")

