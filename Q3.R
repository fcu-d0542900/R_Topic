library(ggplot2)
library(dplyr)

#載入資料
path_sample <- "C:\\Users\\Yuru\\Documents\\YURU\\FCU\\課\\1061\\1061 R語言資料科學基石(資電綜班)[4441]\\專題\\dw_exercise1\\sample.csv"
sample <- read.csv(pathsample,TRUE,",")
sample <-filter(sample,trip_distance>0)

path_temperature <- "C:\\Users\\Yuru\\Documents\\YURU\\FCU\\課\\1061\\1061 R語言資料科學基石(資電綜班)[4441]\\專題\\dw_exercise1\\temperature.txt"
temperature <- read.csv(path_temperature,FALSE,",")
temperature <- sapply(temperature,"[[",1)
names(temperature)<-NULL

path_humidity <- "C:\\Users\\Yuru\\Documents\\YURU\\FCU\\課\\1061\\1061 R語言資料科學基石(資電綜班)[4441]\\專題\\dw_exercise1\\humidity.txt"
humidity <- read.csv(path_humidity,FALSE,",")
humidity <- sapply(humidity,"[[",1)
names(humidity)<-NULL

path_precipitation <- "C:\\Users\\Yuru\\Documents\\YURU\\FCU\\課\\1061\\1061 R語言資料科學基石(資電綜班)[4441]\\專題\\dw_exercise1\\precipitation.txt"
precipitation <- read.csv(path_precipitation,FALSE,",")
precipitation <- sapply(precipitation,"[[",1)
names(precipitation)<-NULL

#讀出計程車乘車日期
info_day <- dplyr::select(sample,tpep_pickup_datetime,tpep_dropoff_datetime) %>%
  mutate(day=substring(tpep_pickup_datetime,9,10),hot,wet,rain) %>%
  select(day)

class(info_day$day) <- "integer"
day <- info_day$day
hot <- temperature[day]>mean(temperature)
wet <- humidity[day]>mean(humidity)
rain <- precipitation[day]>mean(precipitation)
info_day$hot <- hot
info_day$wet <- wet
info_day$rain <- rain

#計算總和
sum(hot)   #72781
sum(!hot)  #49686
sum(wet)   #57551
sum(!wet)  #64916
sum(rain)  #35815
sum(!rain) #86652

ggplot(info_day,aes(x=hot)) +
  geom_bar() +
  ggtitle("Weather(temperature) affects customers to take taxi?") + 
  theme_bw() +
  theme(plot.title=element_text(hjust=0.5,size=18))

ggplot(info_day,aes(x=wet)) +
  geom_bar() +
  ggtitle("Weather(humidity) affects customers to take taxi?") + 
  theme_bw() +
  theme(plot.title=element_text(hjust=0.5,size=18))

ggplot(info_day,aes(x=rain)) +
  geom_bar() +
  ggtitle("Weather(precipitation) affects customers to take taxi?") + 
  theme_bw() +
  theme(plot.title=element_text(hjust=0.5,size=18))

View(info_day)
