all_data <- read.csv("../data/eleanors-traffic+sales-2012.csv");

start_date <- as.Date('2012-04-01');
end_date <- as.Date('2013-03-01');

start_days <- as.numeric(start_date - as.Date('2012-01-01'));
end_days <- as.numeric(end_date - as.Date('2013-01-01'));

all_data_ts <- ts(all_data, start=c(2012, start_days), end=c(2013, end_days), frequency=365);
