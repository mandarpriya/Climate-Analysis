library(tidyverse)
library(SPEI)
library(ggplot2)
library(extrafont)
library(extrafontdb)
library(showtext)
font_add("MouldyCheeseRegular", regular = "MouldyCheeseRegular-WyMWG.ttf")
showtext_auto()  # This is essential!
font_add("Luminari", regular = "Luminari.ttf")
font_path <- "/System/Library/Fonts/Supplemental/Trattatello.ttf"
font_add("Trattatello", regular = font_path)
font_add("Angelos", regular = "Angelos.ttf")
showtext_auto()



## reading the monthly data from the folder
monthly_tbl <- readRDS("data/monthly_tbl.rds")
monthly_tbl <- monthly_tbl |> mutate(date = ymd(date)) |> drop_na()
#### Average Temperature ####
Hamburg_TAVG_plot <- monthly_tbl |> 
  ggplot(aes(date, TAVG)) +
  geom_point(color = "white", fill = "#FF8109", size = 2.5, shape = 21, stroke = 1) +
  geom_line(color = "#FDA666")  +

  scale_x_date(breaks = c(seq(as.Date("1891-01-01"), as.Date("2021-01-01"), by = "10 years"), 
             as.Date("2025-01-01"))) +
  scale_y_continuous(
    breaks = seq(-10, 25, by = 5),
    labels = function(x) paste0(format(x, nsmall = 0), " °C")
  ) + 
  coord_cartesian(xlim = c(as.Date("1891-01-01"), as.Date("2025-01-01")),
                  ylim = c(-10, 25)) +
  theme_minimal() +
theme(
plot.title = element_text(hjust = 0),
plot.title.position = "plot",
plot.subtitle = element_text(hjust = 0),
axis.text.x = element_text(angle = 45, hjust = 1, color = "#3D4551"),
axis.text.y = element_text( color = "#3D4551"),
axis.title = element_text( color = "#3D4551" ),
axis.line = element_line(color = "#7393B3", linewidth  = 1),
panel.background = element_blank(),
plot.background = element_blank(),
panel.grid.minor = element_blank(),
panel.grid.major = element_line(color = "lightgrey", linewidth  = 0.5),
axis.line.y.right = element_line(color = "#7393B3", linewidth = 0.5),
axis.text.y.right = element_text(color = "#3D4551"),
axis.title.y.right = element_text( angle = 90)) +
  labs(title = "Hamburg Fuhlsbüttel Average Temperature",
       subtitle = "Period:-1891-2024",
        x = "", 
       y = "Average Temperature",
       caption = "Source:-NCEI NOAA") 

print(Hamburg_TAVG_plot)
ggsave("Temperature_Plots/Hamburg_TAVG_plot.png", width = 10, height = 6, dpi = 300)

#### Maximum Temperature ####

Hamburg_TMAX_plot <-  monthly_tbl |> 
  ggplot(aes(date, TMAX)) +
  geom_point(color = "white", fill = "#c60002", size = 2.5, shape = 21, stroke = 1) +
  geom_line(color = "#b71c1a")  +

  scale_x_date(breaks = c(seq(as.Date("1891-01-01"), as.Date("2021-01-01"), by = "10 years"), 
             as.Date("2025-01-01"))) +
  scale_y_continuous(
    breaks = c(seq(-5, 30, by = 5),30),
    labels = function(x) paste0(format(x, nsmall = 0), " °C")
  ) + 
  coord_cartesian(xlim = c(as.Date("1891-01-01"), as.Date("2025-01-01")),
                  ylim = c(-5, 30)) +
  theme_minimal() +
theme(
plot.title = element_text(hjust = 0,face = "bold"),
plot.title.position = "plot",
plot.subtitle = element_text(hjust = 0,face = "bold"),
axis.text.x = element_text(angle = 45, hjust = 1, color = "#3D4551"),
axis.text.y = element_text( color = "#3D4551"),
axis.title = element_text( color = "#3D4551" ),
axis.line = element_line(color = "#7393B3", linewidth  = 1),
panel.background = element_blank(),
plot.background = element_blank(),
panel.grid.minor = element_blank(),
panel.grid.major = element_line(color = "lightgrey", linewidth  = 0.5),
axis.line.y.right = element_line(color = "#7393B3", linewidth = 0.5),
axis.text.y.right = element_text(color = "#3D4551"),
axis.title.y.right = element_text( angle = 90)) +
  labs(title = "Hamburg Fuhlsbüttel Maximum Temperature",
       subtitle = "Period:-1891-2024",
        x = "", 
       y = "Maximum Temperature",
       caption = "Source:-NCEI NOAA") 

print(Hamburg_TMAX_plot)
ggsave("Temperature_Plots/Hamburg_TMAX_plot.png", width = 10, height = 6, dpi = 300)

#### Minimum Temperature ####
Hamburg_TMIN_plot <-  monthly_tbl |> 
  ggplot(aes(date, TMIN)) +
  geom_point(color = "white", fill = "#0774d2", size = 2.5, shape = 21, stroke = 1) +
  geom_line(color = "#17619f")  +
  
  scale_x_date(breaks = c(seq(as.Date("1891-01-01"), as.Date("2021-01-01"), by = "10 years"), 
                          as.Date("2025-01-01"))) +
  scale_y_continuous(
    breaks = c(seq(-15, 20, by = 5),20),
    labels = function(x) paste0(format(x, nsmall = 0), " °C")
  ) + 
  coord_cartesian(xlim = c(as.Date("1891-01-01"), as.Date("2025-01-01")),
                  ylim = c(-15, 20)) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0,face = "bold"),
    plot.title.position = "plot",
    plot.subtitle = element_text(hjust = 0,face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, color = "#3D4551"),
    axis.text.y = element_text( color = "#3D4551"),
    axis.title = element_text( color = "#3D4551" ),
    axis.line = element_line(color = "#7393B3", linewidth  = 1),
    panel.background = element_blank(),
    plot.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "lightgrey", linewidth  = 0.5),
    axis.line.y.right = element_line(color = "#7393B3", linewidth = 0.5),
    axis.text.y.right = element_text(color = "#3D4551"),
    axis.title.y.right = element_text( angle = 90)) +
  labs(title = "Hamburg Fuhlsbüttel Minimum Temperature",
       subtitle = "Period:-1891-2024",
       x = "", 
       y = "Minimum Temperature",
       caption = "Source:-NCEI NOAA") 

print(Hamburg_TMIN_plot)
ggsave("Temperature_Plots/Hamburg_TMIN_plot.png", width = 10, height = 6, dpi = 300)


######################### Decadal Analysis #####################################



# First, create your decade tibble correctly
decade_tbl <- monthly_tbl %>% 
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


# Calculate the average for each decade 
decade_summary <- decade_tbl %>% 
  group_by(decade, decade_label) %>% 
  summarize(
    avg_tavg = mean(TAVG, na.rm = TRUE),
    avg_tmax = mean(TMAX, na.rm = TRUE),
    avg_tmin = mean(TMIN, na.rm = TRUE),
    .groups = "drop"
  ) 

##### Decadal analysis for Average Temperature #####

# Create the plot with NUMERIC y-axis (not discrete)
Hamburg_TAVG_Decade_plot <- ggplot(decade_summary, aes(x = decade, y = avg_tavg)) +
  geom_line(color = "blue", linewidth = 1) +
  geom_point(color = "white", fill = "#FF8109", size = 2.5, shape = 21, stroke = 1) +
  geom_text(aes(label = round(avg_tavg, 2)), vjust = -1, hjust = 0.35, size = 4) +
  scale_y_continuous(
    limits = c(8, 11),
    breaks = c(seq(8, 11, by = 0.5), 11),
    labels = function(x) paste0(format(x, nsmall = 2), " °C")
  ) +
  scale_x_continuous(breaks = decade_summary$decade, labels = decade_summary$decade_label) +
  labs(
    title = "Hamburg Fuhlsbüttel Average Temperature:Trend by Decade",
    subtitle = "Period:1891-2024",
    x = "",
    y = "",
    caption = "Source:- NCEI NOAA"
  ) +
  theme(
    
    plot.title = element_text(
      family = "MouldyCheeseRegular",
      size = 24,
    ),
    plot.title.position = "plot",
    plot.subtitle = element_text( # For subtitle
      size = 18
      
    ),
    axis.title.y = element_text(
      # Using your new font
      size = 18
    ),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.line = element_line(color = "#7393B3", linewidth = 1),
    axis.text.y = element_text(  size = 15)
  )

print(Hamburg_TAVG_Decade_plot)
ggsave("Temperature_Plots/Hamburg_TAVG_Decade_plot.png", width = 10, height = 6, dpi = 300)

##### Decadal analysis for Maximum  Temperature #####
Hamburg_TMAX_Decade_plot <- ggplot(decade_summary, aes(x = decade, y = avg_tmax)) +
  geom_line(color = "#b71c1a", linewidth = 1) +
  geom_point(color = "white", fill = "#b81c1a", size = 2.5, shape = 21, stroke = 1) +
  geom_text(aes(label = round(avg_tmax, 2)), vjust = -.65, hjust = 0.5, size = 4) +
  scale_y_continuous(
    limits = c(11,15),
    breaks = c(seq(11, 15,by = 0.5),15),
    labels = function(x) paste0(format(x, nsmall = 1), "°C"),
    #expand = c(0,0)
    
  ) +
  scale_x_continuous(breaks = decade_summary$decade, labels = decade_summary$decade_label) +
  coord_cartesian(ylim = c(11,15)) +

  labs(
    title = "Hamburg Fuhlsbüttel Maximum Temperature:Trend by Decade",
    subtitle = "Period:1891-2024",
    x = "",
    y = "",
    caption = "Source:- NCEI NOAA"
  ) +
  theme(
    
    plot.title = element_text(
      family = "MouldyCheeseRegular",
      size = 24,
    ),
    plot.title.position = "plot",
    plot.subtitle = element_text( # For subtitle
      size = 18
    ),
    axis.title.y = element_text(
      # Using your new font
      size = 18
    ),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10,),
    axis.line = element_line(color = "#7393B3", linewidth = 1),
    axis.text.y = element_text(  size = 15)
  )
print(Hamburg_TMAX_Decade_plot)
ggsave("Temperature_Plots/Hamburg_TMAX_Decade_plot.png", width = 10, height = 6, dpi = 300)

##### Decadal Analysis of Minimum Temperature #####

Hamburg_TMIN_Decade_plot <- ggplot(decade_summary, aes(x = decade, y = avg_tmin)) +
  geom_point(color = "white", fill = "#0774d2", size = 2.5, shape = 21, stroke = 1) +
  geom_line(color = "#17619f",linewidth = 1)  +
  geom_text(aes(label = round(avg_tmin, 1)), vjust = -.65, hjust = 0.35, size = 4) +
  scale_y_continuous(
    limits = c(4,6.5),
    breaks = c(seq(4, 6.5,by = 0.5),6.5),
    labels = function(x) paste0(format(x, nsmall = 1), "°C"),
    #expand = c(0,0)
    
  ) +
  scale_x_continuous(breaks = decade_summary$decade, labels = decade_summary$decade_label) +
  coord_cartesian(ylim = c(4,6.5)) +
  
  labs(
    title = "Hamburg Fuhlsbüttel Minimum Temperature:Trend by Decade",
    subtitle = "Period:1891-2024",
    x = "",
    y = "Minimum Temperature",
    caption = "Source:- NCEI NOAA"
  ) +
  theme(
    
    plot.title = element_text(
      family = "MouldyCheeseRegular",
      size = 24,
    ),
    plot.title.position = "plot",
    plot.subtitle = element_text( # For subtitle
      size = 18
    ),
    axis.title.y = element_text(
      # Using your new font
      size = 18
    ),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10,),
    axis.line = element_line(color = "#7393B3", linewidth = 1),
    axis.text.y = element_text(  size = 15)
  )
print(Hamburg_TMIN_Decade_plot)
ggsave("Temperature_Plots/Hamburg_TMIN_Decade_plot.png", width = 10, height = 8, dpi = 300)

#### Monthly Distribution ####

##### Average Temperature #####




monthly_tbl |> 
  mutate(month = factor(month(date), levels = 1:12, 
                        labels = month.abb)) |>
  ggplot(aes(x = month, y = TAVG)) +
  geom_boxplot() +
  labs(title = "Monthly Temperature Distribution (1891-2024)",
       x = "Month",
       y = "Average Temperature") +
  theme_minimal()

#### Seasonal Temperature Variation ####
Hamburg_seasonal_temperature_variation_plot <- monthly_tbl |> 
  mutate(month = factor(month(date), levels = 1:12, 
                        labels = month.abb),
         season = case_when(
           month %in% c("Dec", "Jan", "Feb") ~ "Winter",
           month %in% c("Mar", "Apr", "May") ~ "Spring",
           month %in% c("Jun", "Jul", "Aug") ~ "Summer",
           TRUE ~ "Autumn"
         )) |>
  ggplot(aes(x = month, y = TAVG, fill = season)) +
  geom_boxplot() +
  scale_fill_manual(values = c("Winter" = "#A1D6E2", 
                               "Spring" = "#81C784", 
                               "Summer" = "#FFB74D", 
                               "Autumn" = "#A1887F")) +
  scale_y_continuous(breaks = seq(-10, 25, by = 5),
                     labels = function(x) paste0(format(x, nsmall = 0), " °C") ) +
  coord_cartesian(ylim = c(-10,25)) +
  labs(title = "Seasonal Temperature Variation",
       subtitle = "Hamburg (1891-2024)",
       x = "",
       y = "",
       fill = "Season", 
       caption = "Source:- NCEI NOA") +
  theme_minimal() +
  theme(
    plot.title = element_text(
      family = "MouldyCheeseRegular",
      size = 24,
    ),
    plot.title.position = "plot",
    plot.subtitle = element_text(family = "Angelos", size = 16)
      
  )
print(Hamburg_seasonal_temperature_variation_plot)

ggsave("Temperature_Plots/Hamburg_seasonal_temperature_variation_plot.png", width = 10, height = 8, dpi = 300)
