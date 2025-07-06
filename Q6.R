# Load required libraries
library(readxl)  # To read Excel files
library(ggplot2)  # For creating plots and visualizations

# Read the Excel file from the specified path
setwd(".")
df_all <- read_excel("./data/aircraft.xlsx")

# Check if essential columns exist in the dataset
if (!all(c("Aircraft Model", "Number of Passengers") %in% colnames(df_all))) {
  stop("Essential columns missing: 'Aircraft Model' or 'Number of Passengers'")  # Stop execution if columns are missing
}

# Count aircraft model occurrences and get the top 5 by frequency
model_counts <- as.data.frame(table(df_all$`Aircraft Model`))  # Count frequencies of each aircraft model
colnames(model_counts) <- c("Model", "Count")  # Rename columns for clarity
top_models <- model_counts[order(-model_counts$Count), ][1:5, ]  # Select top 5 models with highest frequencies

# Calculate the mean number of passengers for the top 5 aircraft models
passenger_means <- aggregate(`Number of Passengers` ~ `Aircraft Model`,
                             data = df_all[df_all$`Aircraft Model` %in% top_models$Model, ],
                             FUN = mean)

# Merge the top models with their corresponding passenger mean values
plot_data <- merge(top_models, passenger_means, by.x = "Model", by.y = "Aircraft Model")

# Create a bar plot of the top 5 aircraft models
bar_plot <- ggplot(plot_data, aes(x = reorder(Model, -`Number of Passengers`),  # Reorder x-axis by mean passengers
                                  y = `Number of Passengers`)) +
  geom_bar(stat = "identity", fill = "#b83b58", width = 0.7, color = "black") +  # Plot bars with specified colors and width
  labs(title = "Top 5 Aircraft Models by Frequency with Mean Passenger Counts",  # Title of the plot
       x = "Aircraft Model",  # Label for x-axis
       y = "Number of Passengers") +  # Label for y-axis
  theme_minimal() + 
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10, color = "black"),  # Rotate x-axis labels 45, so they dont clip into eachother
    plot.title = element_text(face = "bold", size = 14, color = "black"),  # Customize plot title appearance
    axis.title = element_text(color = "black") 
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  geom_text(aes(label = round(`Number of Passengers`, 1)),
            vjust = -0.5, size = 3.5, color = "black")

# Save the plot as a PNG image
ggsave("barplot-Q6.png", plot = bar_plot, width = 8, height = 6, dpi = 300, bg = "white")

# Message to show that the plot has been saved!!
message("Saved!")

