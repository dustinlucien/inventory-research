library(zoo);

traffic <- read.csv("../data/eleanors-traffic+sales-2012.csv");

zTraffic <- zoo(traffic[, 2:3], as.Date(traffic[,1], format="%m/%d/%Y"));

plot(zTraffic);

traffic$Date = traffic$Date - round(335/2);

fit1 <- lm(traffic$Visits ~ traffic$Date)
fit2 <- lm(traffic$Visits ~ traffic$Date + I(traffic$Date^2))
fit3 <- lm(traffic$Visits ~ traffic$Date + I(traffic$Date^2) + I(traffic$Date^3))

plot(traffic$Date, traffic$Visits, type="l", lwd=3)
points(traffic$Date, predict(fit2), type="l", col="red", lwd=2)
points(traffic$Date, predict(fit3), type="l", col="blue", lwd=2)

fit1 <- lm(traffic$Sales ~ traffic$Visits)
fit2 <- lm(traffic$Sales ~ traffic$Visits + I(traffic$Visits^2))
fit3 <- lm(traffic$Sales ~ traffic$Visits + I(traffic$Visits^2) + I(traffic$Visits^3))

plot(traffic$Visits, traffic$Sales, type="l", lwd=3)
points(traffic$Visits, predict(fit2), type="l", col="red", lwd=2)
points(traffic$Visits, predict(fit3), type="l", col="blue", lwd=2)

fit <- lm(traffic$Sales ~ traffic$Visits)

#transform date into an integer first
fitt <- lm(traffic$Sales ~ traffic$Date + traffic$Visits)

plot(fitted(fitt), type='l', lwd=4)

#timeseries approach
traffic_series <- ts(traffic[,2:4], frequency=365, start=c(2012,52));

#no trend, no seasonality
traffic_series_smooth <- HoltWinters(traffic_series, beta=false, gamma=false);
#no seasonality
traffic_series_smooth <- HoltWinters(traffic_series, gamma=false);
#trend and seasonality
traffic_series_smooth <- HoltWinters(traffic_series);

