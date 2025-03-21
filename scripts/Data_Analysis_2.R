
#### Data Analysis for Precipitation ####

## adding Fonts 
font_add("MouldyCheeseRegular", regular = "MouldyCheeseRegular-WyMWG.ttf")
showtext_auto()  # This is essential!
font_add("Luminari", regular = "Luminari.ttf")
font_path <- "/System/Library/Fonts/Supplemental/Trattatello.ttf"
font_add("Trattatello", regular = font_path)
font_add("Angelos", regular = "Angelos.ttf")
showtext_auto()

##  libraries
library(tidyverse)
library(SPEI)
library(ggplot2)
library(extrafont)
library(extrafontdb)
library(showtext)

##### Reading the data / loading the data from the data folder #####

data <- readRDS(file = "data/monthly_tbl.rds")
data <- data |> drop_na()

#### Precipitation #####
data |> 
  ggplot(aes(date, PRCP)) +
  geom_point(color = "white", fill = "blue", size = 2.5, shape = 21, stroke = 1) +
  geom_line(col = "#0096FF") + 
  scale_x_date(breaks = c(seq(as.Date("1891-01-01"), as.Date("2021-01-01"), by = "10 years"), 
                          as.Date("2025-01-01"))) +
  scale_y_continuous(
    breaks = seq(0, 250, by = 50),
    labels = function(x) paste0(format(x, nsmall = 0), "mm")
  ) + 
  coord_cartesian(xlim = c(as.Date("1891-01-01"), as.Date("2025-01-01")),
                  ylim = c(0, 250)) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      family = "MouldyCheeseRegular",
      size = 24),
    plot.title.position = "plot",
    plot.subtitle = element_text(hjust = 0, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, color = "#3D4551"),
    axis.text.y = element_text( color = "#3D4551"),
    axis.title = element_text( color = "#3D4551", face = "bold",colour = "black" ),
    axis.line = element_line(color = "#7393B3", linewidth  = 1),
    panel.background = element_blank(),
    plot.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "lightgrey", linewidth  = 0.5),
    axis.line.y.right = element_line(color = "#7393B3", linewidth = 0.5),
    axis.text.y.right = element_text(color = "#3D4551"),
    axis.title.y.right = element_text( angle = 90)) +
  labs(title = "Precipitation\nHamburg Fuhlsbüttel  ",
       subtitle = "Period:-1891-2024",
       x = "", 
       y = "Precipitation",
       caption = "Source:-NCEI NOAA") 

##  Decadal Precipitation ####

# First, create your decade tibble correctly
decade_tbl <- data %>% 
  mutate(
    decade = year - (year %% 10),
    decade_label = paste0(decade + 1, "-", decade + 10)
  ) 

# Fix the 2020s decade label
decade_tbl <- decade_tbl %>% 
  mutate(
    decade_label = case_when(
      decade == 2020 ~ "2021-2024",
      TRUE ~ decade_label
    )
  ) 

decade_summary <- decade_tbl %>% 
  group_by(decade, decade_label) %>% 
  summarize(
    PRCP = sum(PRCP, na.rm = TRUE),
   
    .groups = "drop"
  ) 
Hamburg_PRCP_Decade_plot <- decade_summary |> 
  ggplot(aes(x = decade, y = PRCP)) +
  # Lighter background with reduced opacity
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf,
           fill = "aliceblue", alpha = 0.2) +
  # Lighter blue for the line
  geom_line(color = "#1E63BC", linewidth = 1.5) +
  # Lighter blue fill for points but keep dark border for contrast
  geom_point(fill = "#4682B4", color = "#1E3A8A", size = 4, shape = 21, stroke = 1.2) +
  # Slightly darker text for better readability
  geom_text(aes(label = paste0(round(PRCP, 0), "mm")), 
            vjust = -1, hjust = 0.45, size = 3.5, fontface = "bold",
            color = "#1E3A8A") +
  # Y-axis formatting
  scale_y_continuous(
    limits = c(4000, 8500),
    breaks = seq(4000, 8500, by = 500),
    labels = function(x) paste0(format(x, nsmall = 0), "mm")
  ) +
  scale_x_continuous(breaks = decade_summary$decade, labels = decade_summary$decade_label) +
  labs(
    title = "Precipitation by Decade",
    subtitle = "Hamburg Fuhlsbüttel\nPeriod: 1891-2024",
    x = "",
    y = "Total Precipitation",
    caption = "Source: NCEI NOAA"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      family = "MouldyCheeseRegular",
      size = 24,
      face = "bold",
      color = "#0C2D7A"  # Slightly lighter title color
    ),
    plot.background = element_rect(fill = "white"),
    plot.title.position = "plot",
    plot.subtitle = element_text(
      size = 18,
      margin = margin(b = 20),
      color = "#3874CB"  # Lighter subtitle color
    ),
    axis.title.y = element_text(
      size = 16,
      margin = margin(r = 10),
      color = "#3874CB"  # Lighter axis title
    ),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10, color = "#3874CB"),  # Lighter axis text
    axis.line = element_line(color = "#98B7E5", linewidth = 1),  # Lighter axis line
    axis.text.y = element_text(size = 15, color = "#3874CB"),  # Lighter y-axis text
    panel.grid.major = element_line(color = "#DCE6F7", linetype = "dotted"),  # Much lighter grid lines
    panel.grid.minor = element_blank()
  )
print(Hamburg_PRCP_Decade_plot)


ggsave("Precipitation_Plots/Hamburg_PRCP_Decade_plot.png", width = 10, height = 6, dpi = 300)

# decade_summary |> 
#   ggplot(aes(x = decade, y = PRCP)) +
#   # Use annotate instead of geom_rect to avoid the warning
#   annotate("rect", xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf,
#            fill = "aliceblue", alpha = 0.3) +
#   # Use a gradient color for the line based on precipitation values
#   geom_line(aes(color = PRCP), linewidth = 1.5) +
#   # Use larger points with a nice border
#   geom_point(aes(fill = PRCP), color = "white", size = 4, shape = 21, stroke = 1.2) +
#   # Add labels with a subtle shadow effect
#   geom_text(aes(label = paste0(round(PRCP, 0), "mm")), 
#             vjust = -0.8, hjust = 0.5, size = 3.5, fontface = "bold",
#             color = "navy") +
#   # Create a blue gradient color scheme
#   scale_color_gradient(low = "#4169E1", high = "#00008B", guide = "none") +
#   scale_fill_gradient(low = "#4169E1", high = "#00008B", guide = "none") +
#   # Maintain your y-axis scale with nicer formatting
#   scale_y_continuous(
#     limits = c(4000, 8500),
#     breaks = seq(4000, 8500, by = 500),
#     labels = function(x) paste0(format(x, nsmall = 0), "mm")
#   ) +
#   scale_x_continuous(breaks = decade_summary$decade, labels = decade_summary$decade_label) +
#   labs(
#     title = "Precipitation by Decade",
#     subtitle = "Hamburg Fuhlsbüttel\nPeriod: 1891-2024",
#     x = "",
#     y = "Total Precipitation",
#     caption = "Source: NCEI NOAA"
#   ) +
#   theme_minimal() +
#   theme(
#     plot.title = element_text(
#       family = "MouldyCheeseRegular",
#       size = 24,
#       face = "bold",
#       color = "#00008B"
#     ),
#     plot.background = element_rect(fill = "white"),
#     plot.title.position = "plot",
#     plot.subtitle = element_text(
#       size = 18,
#       margin = margin(b = 20),
#       color = "#4169E1"
#     ),
#     axis.title.y = element_text(
#       size = 16,
#       margin = margin(r = 10),
#       color = "#4169E1"
#     ),
#     axis.text.x = element_text(angle = 45, hjust = 1, size = 10, color = "#4169E1"),
#     axis.line = element_line(color = "#7393B3", linewidth = 1),
#     axis.text.y = element_text(size = 15, color = "#4169E1"),
#     panel.grid.major = element_line(color = "lightblue", linetype = "dotted"),
#     panel.grid.minor = element_blank()
#   )

##### 


