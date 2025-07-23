 # Climate Analysis :- 
 The  project is on analysing the Climate data for Hamburg Fuhlsbüttel. 

## Data Source:-
The source for this data is in the following link :- opendata.dwd.de/climate_environment/CDC/observations_germany/climate/daily
The data collected  is from the time period  1936-2024 based on daily frequency. 
Station i.d. :-  Hamburg Fuhlsbüttel Latitutde 53.6332 Longitude is 9.9881 
Note:- The data has not been updated after 2023. In addition the data for other stations is not complete and time frame is small.
So we decided to use another reliable data source NCEI data, which gets a regular update.


#### Analysis 
This research consists of two complementary analyses: first, an examination of climate variables to identify trends and changes; and second, an analysis of drought indices to determine whether they support the identified climate changes. 


# Climate Analysis for Hamburg Fuhlsbüttel:
I first perform Temperature analysis for  Hamburg Fuhlsbüttel

### Annual Temperature Trend (1936–2024)

![Annual Temperature Trend](DWD_Folder/Plots/Annual_Temperature_Trend.png)

### 📊 Decadal Temperature (Bar Plot)
![Decadal Temperature Bar](DWD_Folder/Plots/Decadal_Temperature_Bar.png)

### 📉 Decadal Temperature Trends (Line Plot)
![Decadal Temperature Line](DWD_Folder/Plots/Decadal_Temperature_Line.png)

### 🔥 Heatwave Intensity Trend (1990–2024)
![Heatwave_Intensity_Trend](DWD_Folder/Plots/Heatwave_Intensity_Trend_1990_2024.png)

### 🌡️ Maximum Daily Exceedance in Heatwaves (1990–2024)
![Max Exceedance](DWD_Folder/Plots/Heatwave_Max_Exceedance_1990_2024.png)

### 🔁 Annual Number of Heatwave Events (HWMId, 1990–2024)
![HWMId Annual Events](DWD_Folder/Plots/HWMId_Annual_Events_1990_2024.png)

### 🗓️ Julian Day of Peak Heatwave Intensity
![Peak Julian Day](DWD_Folder/Plots/HWMId_Peak_Julian_Day_Line.png)

### 📅 Frequency of Heatwave Peak Months (1990–2024)
![Peak Month Count](DWD_Folder/Plots/Heatwave_Peak_Month_Count.png)

### 📆 Peak Months by Decade
![Peak Month by Decade](DWD_Folder/Plots/Peak_Months_by_Decade.png)

### 🧮 Heatwave Frequency per Climatology Period
![Heatwave Frequency by Climatology](DWD_Folder/Plots/Heatwave_Frequency_Climatology_Period.png)

### 📊 Frequency of Heatwave Events (Tmax ≥ 28°C, ≥3 Days)
![Exceedance Frequency](DWD_Folder/Plots/Exceedance_28C_Frequency_Annual.png)

### ↘️ Rate of Decline After Heatwave Peak
![Rate of Decline](DWD_Folder/Plots/Exceedance_Rate_Decline.png)

### 🐢 Top 10 Slowest Heatwave Declines
![Slowest Decline](DWD_Folder/Plots/Top10_Slowest_Decline_Rate.png)

### ⏳ Top 10 Longest Duration Heatwave Events
![Longest Duration](DWD_Folder/Plots/Top10_Longest_Heatwaves.png)

### 📌 Top 10 Heatwaves by Maximum Intensity
![Max Intensity Events](DWD_Folder/Plots/Top10_Max_Intensity_Events.png)








### Drought Analysis:- 

The Reconnaissance Drought Index (RDI) is a meteorological drought index that assesses drought severity by comparing precipitation to potential evapotranspiration (PET). It's a valuable tool for understanding water availability and is often used in agriculture and water resource management.
### RDI 12 monthly Index
![RDI 12 Monthly ](DWD_Folder/Plots/RDI_12_Hamburg.png)

### RDI 24 monthly Index
![RDI 24 Monthly ](DWD_Folder/Plots/RDI_24_Hamburg.png)

### RDI 36 monthly Index
![RDI 36 Monthly ](DWD_Folder/Plots/RDI_36_Hamburg.png)

### RDI 48 monthly Index
![RDI 48 Monthly ](DWD_Folder/Plots/RDI_48_Hamburg.png)







# Analysis:- 
We  extend our analysis by focusing on long term trend, so using annual series of drought indices with a frequency of 3,6,9,12 . The plots shows that last decade has witnesses increase in temperature and on the other decrease in precipitation. This makes the situation worse in future as with further increase in temperature the weather will becoe more dry and will result in a further decrease in precipitation resulting in a severe drought. 









### Software Program:-
R  has been extensively used for the whole analysis, visualiaztion. 

