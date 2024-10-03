# Climate_Droughts :- 
This objective of this project is about analysing the Climate data and Drought Indices for Hamburg based on the data from the following 
https://www.dwd.de/DE/wetter/wetterundklima_vorort/schleswig-holstein_hamburg/hamburg/_node.html
The data collected  is from the time period  1936-2023 based on daily frequency. 

# Station i.d. :-  Hamburg Fuhlsbüttel Latitutde 53.6332 Longitude is 9.9881 

# Software:- R studio has been used for the whole analysis 

# This repository contains R code and data for climate and drought analysis, including:
- SPEI and SPI index estimation
- Time Series Plots for SPEI and SPI Indices ( monthly & annual)
- Temperature analysis (Average Temperature, Maximum Temperature) based on Annual , Monthly and Seasonality.

## Drought Indices 

## SPI Index :- Standardized Precipitation index (SPI) 
The Standardized Precipitation Index (SPI) is the most commonly used indicator worldwide fordetecting and characterizing meteorological droughts. The SPI indicator, which was developed by McKee et al. (1993), and described in detail by Edwards and McKee (1997), measures precipitation anomalies at a given location, based on a comparison of observed total precipitation amounts for an accumulation period of interest (e.g. 1, 3, 12, 48 months), with the long-term historic rainfallrecord for that period. The historic record is fitted to a probability distribution (the “gamma” distribution), which is then transformed into a normal distribution such that the mean SPI value for
that location and period is zero. For any given region, increasingly severe rainfall deficits (i.e.,meteorological droughts) are indicated as SPI decreases below ‒1.0, while increasingly severe excess rainfall are indicated as SPI increases above 1.0. Because SPI values are in units of standard deviation from the long-term mean, the indicator can be used to compare precipitation anomalies for any geographic location and for any number of time-scales. Note that the name of the indicator
is usually modified to include the accumulation period. Thus, SPI-3 and SPI-12, for example, refer to accumulation periods of three and twelve months, respectively. T
### The spi_index folder contains the  script for spi_index analysis 
### The spi_plots folder includes the plots for spi_index for 3,6,9,12 monthly and annual series respectively

## SPEI Index :- Standardised Precipitation Evapotranspiration Index (SPEI) 
The Standardized Precipitation Evapotranspiration Index (SPEI) is an extension of the widely used Standardized Precipitation Index (SPI). The SPEI is designed to take into account both precipitation and potential evapotranspiration (PET) in determining drought. Thus, unlike the SPI, the SPEI captures the main impact of increased temperatures on water demand. Like the SPI, the SPEI can be calculated on a range of timescales from 1-48 months.
### The spei_index folder contains the script for spei_index analysis
### The spei_plots folder contains the plots for spei_index for 3,6,9,12 and annual series respectively.

## Palmer Drought Severity Index (Self Calibrated):- To be added ......


# Climate

## Temperature  :-
### The average_temp folder contains the script for Average Temperature Analysis
### The Average_Temperature_Plots folder contains the plots for Average Temperature based on annual and seasonal and monthly data.
### The Maximum_Temperature folder contains the script for Maximum Temperature Analysis
### The Maximum_Temperature_Plots contains the plots for Maximum Temperature based on annual, seasonal data


## Precipitation :- To be added


###  Analysis :- To be added.........

