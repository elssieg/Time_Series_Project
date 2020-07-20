# Project Overview

This is the final project that I worked on, with one other classmate, for **DCS-425: Time Series and Forecasting.** It was developed in R-Studio, and revolved around greenhouse gas emissions in Europe from 1990 to 2014.

## Europe's Greenhouse Gas Emissions (1990 - 2014)

This project uses a dataset provided by the United Nations, which covers 43 countries in Europe. The dataset has a total of 8,406 observations, and consists of the following columns: 

* Country/Region
* Year (1990-2014)
* Value (Volume of Pollutant in Kilotonnes)
* Category of Pollutant (CO2, NF3, SF6, CH4, N2O, HFCS, PFCs, SF6, NF3)

For simplicity's sake, all of the European countries were grouped into 4 different regions: 

* Western
* Eastern
* Northern
* Southern Europe. 

Results gathered for each grouping showed downward trends. Therefore, we decided to group all of the 4 regions together. 

### Project Timeline

1. Reviewed the ACF and PACF.
2. Performed Ljung-Box test to see if the data is independently distributed.
3. Looked into different ARIMA models to see which one gave us the best AIC, and BIC.
4. Performed Analysis of Residuals.
5. Split data into training and testing.
6. Drew Conclusions from the results.

