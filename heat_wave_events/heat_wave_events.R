library(ggplot2)
library(dplyr)
library(scales)
library(ggrepel)  # For repelling labels






identify_heatwaves <- function(dates, tmax, threshold, min_duration = 3) {
  # Ensure inputs are valid
  stopifnot(length(dates) == length(tmax))
  stopifnot(is.numeric(tmax))
  stopifnot(inherits(dates, "Date"))
  
  # Sort data (important for chronological consistency)
  data <- data.frame(date = dates, tmax = tmax)
  data <- data[order(data$date), ]
  data$above_threshold <- data$tmax > threshold
  
  # Initialize output
  heatwaves <- data.frame(
    start_date = as.Date(character()),
    end_date = as.Date(character()),
    duration = integer(),
    avg_intensity = numeric(),
    total_intensity = numeric(),
    mean_tmax = numeric(),
    peak_tmax = numeric(),
    stringsAsFactors = FALSE
  )
  
  # Tracking variables
  in_heatwave <- FALSE
  heatwave_start <- NULL
  heatwave_length <- 0
  
  # Loop through all dates
  for (i in seq_len(nrow(data))) {
    if (data$above_threshold[i]) {
      if (!in_heatwave) {
        in_heatwave <- TRUE
        heatwave_start <- data$date[i]
        heatwave_length <- 1
      } else {
        heatwave_length <- heatwave_length + 1
      }
    } else {
      if (in_heatwave) {
        if (heatwave_length >= min_duration) {
          end_date <- data$date[i - 1]
          heatwave_days <- which(data$date >= heatwave_start & data$date <= end_date)
          
          if (length(heatwave_days) > 0) {
            exceedance <- data$tmax[heatwave_days] - threshold
            avg_intensity <- mean(exceedance)
            total_intensity <- sum(exceedance)
            mean_tmax <- mean(data$tmax[heatwave_days])
            peak_tmax <- max(data$tmax[heatwave_days])
            
            heatwaves <- rbind(heatwaves, data.frame(
              start_date = heatwave_start,
              end_date = end_date,
              duration = heatwave_length,
              avg_intensity = avg_intensity,
              total_intensity = total_intensity,
              mean_tmax = mean_tmax,
              peak_tmax = peak_tmax
            ))
          }
        }
        in_heatwave <- FALSE
        heatwave_length <- 0
      }
    }
  }
  
  # Handle a heatwave that continues until the end
  if (in_heatwave && heatwave_length >= min_duration) {
    end_date <- data$date[nrow(data)]
    heatwave_days <- which(data$date >= heatwave_start & data$date <= end_date)
    
    if (length(heatwave_days) > 0) {
      exceedance <- data$tmax[heatwave_days] - threshold
      avg_intensity <- mean(exceedance)
      total_intensity <- sum(exceedance)
      mean_tmax <- mean(data$tmax[heatwave_days])
      peak_tmax <- max(data$tmax[heatwave_days])
      
      heatwaves <- rbind(heatwaves, data.frame(
        start_date = heatwave_start,
        end_date = end_date,
        duration = heatwave_length,
        avg_intensity = avg_intensity,
        total_intensity = total_intensity,
        mean_tmax = mean_tmax,
        peak_tmax = peak_tmax
      ))
    }
  }
  
  # Add year column
  if (nrow(heatwaves) > 0) {
    heatwaves$year <- format(heatwaves$start_date, "%Y")
  }
  
  return(heatwaves)
}


observation_tbl <- observation_tbl[!is.na(observation_tbl$TXK), ]

heatwave_events_tbl <- identify_heatwaves(
  dates = observation_tbl$date,
  tmax = observation_tbl$TXK,
  threshold = 28,
  min_duration = 3
)

heatwave_count_per_year <- heatwave_events_tbl %>%
  group_by(year) %>%
  summarise(num_events = n())

heatwave_summary <- heatwaves_events %>%
  group_by(year) %>%
  summarise(
    total_duration = sum(duration),
    avg_intensity = mean(intensity),
    num_events = n()
  )
# Convert date columns
heatwaves_events$start_date <- as.Date(heatwaves_events$start_date)
heatwaves_events$end_date <- as.Date(heatwaves_events$end_date)

heatwaves_events$year <- as.numeric(heatwaves_events$year)


# Custom color palette
custom_colors <- c("#f8f800", "#fdc70c", "#f3903f", "#ff4d00", "#e60000", "#5e0000")

# Identify recent events since 1990 with intensity > 5
recent_events <- heatwaves_events %>% 
  filter(year >1990) %>%
  summarize(count = n()) %>%
  pull(count)

# Total events and percentage
total_events <- nrow(heatwaves_events)
percent_recent <- round((recent_events / total_events) * 100)

# 95th percentile extreme threshold
threshold_95 <- quantile(heatwaves_events$intensity, 0.95, na.rm = TRUE)

# Get max intensity and longest duration values
max_intensity_value <- max(heatwaves_events$intensity)
longest_duration_value <- max(heatwaves_events$duration)

# Label max intensity event
max_intensity_event <- heatwaves_events %>%
  filter(intensity == max_intensity_value) %>%
  mutate(label = paste0("Max intensity:", round(intensity, 1),"\n",format(start_date,"%b %d, %Y")))

# Label longest duration event
longest_duration_event <- heatwaves_events %>%
  filter(duration == longest_duration_value) %>%
  mutate(label = paste0("Longest:", duration, "days\n",format(start_date,"%b %Y")))

# Filter extreme events BUT exclude max intensity to avoid label duplication
extreme_events <- heatwaves_events %>%
  filter(intensity > threshold_95, intensity < max_intensity_value) %>%
  mutate(label = paste0("Extreme:",round(intensity, 1),"\n",format(start_date,"%Y")))

# Plot
p <- ggplot(heatwaves_events, aes(x = year, y = intensity)) +
  
  geom_point(aes(size = duration, color = intensity), alpha = 0.85) +
  
  geom_vline(xintercept = 1990, linetype = "dashed", color = "blue", linewidth = 0.6) +
  annotate("text", x = 1990, y = 6.2, label = "1990", 
           color = "blue", fontface = "bold", size = 3) +
  
  geom_smooth(method = "loess", formula = y ~ x, se = FALSE,
              color = "darkblue", linetype = "solid", linewidth = 0.8, alpha = 0.6) +
  
  geom_text(data = max_intensity_event, aes(label = label),
            hjust = 1, vjust = 1.2, size = 3, fontface = "bold", color = "#5e0000") +
  geom_hline(yintercept = threshold_95, linetype = "dotted", color = "darkred") +
  annotate("text", x = 1940, y = threshold_95 , label = "95th Percentile", color = "darkred", size = 3) +
  # Annotate max intensity
  # ggrepel::geom_text_repel(data = max_intensity_event, aes(label = label),
  #                          size = 3, fontface = "bold", color = "#5e0000",
  #                          max.overlaps = 5, box.padding = 0.4, point.padding = 0.4,
  #                          direction = "both") +
  # Annotate longest duration using repel to avoid overlap
  ggrepel::geom_text_repel(data = longest_duration_event, aes(label = label),
                           size = 3, fontface = "bold", color = "#5e0000",
                           max.overlaps = 5, box.padding = 0.4, point.padding = 0.4,
                           hjust = 1) +
  
  # Annotate extreme events
  ggrepel::geom_text_repel(data = extreme_events, aes(label = label),
                           size = 2.8, fontface = "italic", color = "black",
                           max.overlaps = 10, box.padding = 0.4, point.padding = 0.3) +
  
  # Axis scales
  scale_y_continuous(limits = c(0, 6.25),breaks = seq(0,6.25, 0.5),
                     expand = c(0, 0.05)) +
  
  scale_x_continuous(limits = c(1936, 2025),
                     breaks = c(seq(1936, 2025, by = 10), 2025)) +
  
  scale_color_gradientn(colors = custom_colors,
                        name = "Intensity",
                        guide = guide_colorbar(barwidth = 1, barheight = 10,
                                               title.position = "top", title.hjust = 0.5)) +
  
  scale_size_continuous(range = c(2, 10),
                        name = "Duration (days)",
                        breaks = c(3, 6, 9, 12),
                        guide = guide_legend(title.position = "top",
                                             title.hjust = 0.5,
                                             override.aes = list(color = "darkblue"))) +
  
  # Labels
  labs(
    title = "Heatwave Events in Hamburg Fuhlsbüttel (1936–2025)",
    subtitle = paste0("Based on threshold of 28°C for minimum 3 consecutive days\n",
                      percent_recent, "% of all events occurred since 1990"),
    x = "",
    y = "Intensity",
    caption = "Source:-Deutscher Wetterdienst (DWD)"
  ) +
  
  # Theme
  theme_minimal(base_size = 12) +
  theme(
    plot.title.position = "plot",
    plot.title = element_text(face = "bold", size = 16, margin = margin(b = 15)),
    plot.subtitle = element_text(size = 11, color = "gray30", margin = margin(b = 15), face = "bold"),
    axis.title.y = element_text(margin = margin(r = 10), face = "bold"),
    axis.text = element_text(color = "gray30"),
    legend.position = "right",
    legend.box = "vertical",
    legend.margin = margin(l = 10),
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "gray80", linetype = "dotted")
  )
p



ggsave("/Users/mandarphatak/Climate-Analysis/heat_wave_event_plot/heatwaves_hamburg_fuhlsbüttel_1936_2025.png", plot = p, width = 14, height = 10, dpi = 300, bg = "white")
