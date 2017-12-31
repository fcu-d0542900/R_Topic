library(ggplot2)
library(dplyr)

path_sample <- "C:\\Users\\Yuru\\Documents\\YURU\\FCU\\課\\1061\\1061 R語言資料科學基石(資電綜班)[4441]\\專題\\dw_exercise1\\sample.csv"
sample <- read.csv(pathsample,TRUE,",")

info_tip <- select(sample,trip_distance,tip_amount) %>%
  filter(trip_distance>0,tip_amount>0)%>%
  filter(tip_amount<50)
cor(info_tip)

ggplot(info_tip,aes(x=trip_distance,y=tip_amount)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Does long distance trip imply more tip?") + 
  theme_bw() +
  theme(plot.title=element_text(hjust=0.5,size=18))
