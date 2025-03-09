library(tidyverse)
library(SPEI)
library(ggplot2)


## reading the monthly data from the folder
monthly_tbl <- readRDS("data/monthly_tbl.rds")
monthly_tbl <- monthly_tbl |> mutate(date = ymd(date)) |> drop_na()

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


ggsave("Temperaure_Plots/Hamburg_TAVG_plot.png", width = 10, height = 6, dpi = 300)


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


ggsave("Temperaure_Plots/Hamburg_TAVG_plot.png", width = 10, height = 6, dpi = 300)




