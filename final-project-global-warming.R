# Elssie Guerra & Jillian Stoller
#Final Project Code
#DSC 425

gw<- read.csv("Green House Emission.csv")

gw

str(gw)
head(gw)
gw$Date <-as.Date(gw$Date, format="%m/%d/%y")
gw$Year = as.numeric(format(gw$Date, "%Y"))
head(gw)

summary(gw)
# Start diving into subgroups
EE<- gw[c(7,2)]
NE<- gw[c(7,3)]
SE<- gw[c(7,4)]
WE<- gw[c(7,5)]
Europe <- gw[c(7,6)]

# Eastern Europe
EE$GreenHouseinMil<- (as.numeric(EE$Eastern_Europe)/1000000)
head(EE)
library(ggplot2)

tail(EE)
p <- ggplot(EE, aes(x=Year, y=GreenHouseinMil)) +
  geom_line(color="#69b3a2", size = 1.5) + ggtitle("                                   Greenhouse Emissions at Eastern Europe")+
  xlab("Year")+ylab("Greenhouse Emission (Millions Kilottones)")
p

# Northern Europe
NE$GreenHouseinMil<- (as.numeric(NE$Northern_Europe)/1000000)
head(NE)
tail(NE)
q <- ggplot(NE, aes(x=Year, y=GreenHouseinMil)) +
  geom_line(color="#69b3a2", size = 1.5) + ggtitle("                                   Greenhouse Emissions at Northern Europe")+
  xlab("Year")+ylab("Greenhouse Emission (Millions Kilottones)")
q

#Southern Europe
SE$GreenHouseinMil<- (as.numeric(SE$Southern_Europe)/1000000)
head(SE)
tail(SE)
r <- ggplot(SE, aes(x=Year, y=GreenHouseinMil)) +
  geom_line(color="#69b3a2", size = 1.5) + ggtitle("                                   Greenhouse Emissions at Southern Europe")+
  xlab("Year")+ylab("Greenhouse Emission (Millions Kilottones)")
r

# Western Europe

WE$GreenHouseinMil<- (as.numeric(WE$Western_Europe)/1000000)
head(WE)
tail(WE)
s <- ggplot(WE, aes(x=Year, y=GreenHouseinMil)) +
  geom_line(color="#69b3a2", size = 1.5) + ggtitle("                                   Greenhouse Emissions at Western Europe")+
  xlab("Year")+ylab("Greenhouse Emission (Millions Kilottones)")
s

# Europe
Europe$GreenHouseinMil<- (as.numeric(Europe$Europe)/1000000)
head(Europe)
tail(Europe)
t <- ggplot(Europe, aes(x=Year, y=GreenHouseinMil)) +
  geom_line(color="#69b3a2", size = 1.5) + ggtitle("                                   Greenhouse Emissions at Europe")+
  xlab("Year")+ylab("Greenhouse Emission (Millions Kilottones)")
t
Green_House_Emissions=ts(Europe$GreenHouseinMil, start=1990, frequency=1 )
plot(Green_House_Emissions, main="Greenhouse Emission in  Europe")

#plot of first difference
plot(diff(Green_House_Emissions), main="Greenhouse Emission in  Europe")
summary(diff(Green_House_Emissions))

#plot of second difference
plot(diff(diff(Green_House_Emissions)), main="Greenhouse Emission in  Europe")
summary(diff(diff(Green_House_Emissions)))

# Now I will start plotting to see if there is stationarity and if it's and MA, AR or Linear model.
library(magrittr)
acf(Green_House_Emissions)
pacf(Green_House_Emissions)

Box.test(Green_House_Emissions, lag=4 ,type = 'Ljung-Box')
Box.test(Green_House_Emissions, lag=6 ,type = 'Ljung-Box')
Box.test(Green_House_Emissions, lag=8 ,type = 'Ljung-Box')
Box.test(Green_House_Emissions, lag=10 ,type = 'Ljung-Box')

library(magrittr)
library(forecast)

#Best model fit exploration
library(fpp2)
auto= auto.arima(Green_House_Emissions)
auto

m1 = Arima(Green_House_Emissions, order=c(1,0,1))
library(lmtest)
m1
coeftest(m1)
plot(m1$residuals)

m2=Arima(Green_House_Emissions, order=c(1,0,2))
m2
coeftest(m2)
m2$bic

m3 = Arima(Green_House_Emissions, order=c(1,1,2))
m3
coeftest(m3)
plot(m3$residuals)

m4= Arima(Green_House_Emissions, order=c(1,0,0))
m4
coeftest(m4)

# This is the best model so far
m5= Arima(Green_House_Emissions, order=c(1,1,1))
m5


coeftest(a)

coeftest(m5)
plot(m5$residuals)
hist(m5$residuals)
qqnorm(m5$residuals)
qqline(m5$residuals)
acf(m5$residuals)
# Do the Ljung-Box test to see if Residuals are white nois
Box.test(m5$residuals, lag=4 ,type = 'Ljung-Box')
Box.test(m5$residuals, lag=6, type= 'Ljung-Box')
Box.test(m5$residuals, lag=8, type= 'Ljung-Box')

#prueba=auto.arima(Green_House_Emissions, ic=c("bic"), seasonal=F) 
prueba
coeftest(prueba)
plot(forecast(prueba, h=6))
plot(prueba$residuals)
Box.test(prueba$residuals, lag=2, type="Ljung-Box")
Box.test(prueba$residuals, lag=4, type="Ljung-Box")
Box.test(prueba$residuals, lag=6, type="Ljung-Box")
Box.test(prueba$residuals, lag=8, type="Ljung-Box")

plot(forecast(m1, h =5))
plot(forecast(m2, h=5))
plot(forecast(m3, h=6))
plot(forecast(m4, h=6))
plot(forecast(m5, h=6))

# Divide the data into Testing/Training
# 80% and 20%
xtr=window(Green_House_Emissions, start=1990, end=2009)
x_test=window(Green_House_Emissions, start=2009)

forecast(m5_model, h=5)
x_test
m5_model = Arima(xtr, order=c(1,1,1))
plot(forecast(m5_model, h=5))
lines(x_test)

sqrt(mean(m5_model$residuals))
m5_model$fitted.values
