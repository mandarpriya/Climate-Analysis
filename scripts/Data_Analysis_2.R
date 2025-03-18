
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

