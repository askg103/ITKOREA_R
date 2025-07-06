# CSV파일 불러오기
weather = read.csv('날씨데이터.csv', na.strings = c(""), fileEncoding = 'CP949',
                   encoding = 'UTF-8', check.names = FALSE)
# 구조 및 데이터 확인
#hint str, head, tail

# 한글->영어로 바꾸기
colnames(weather) =  c("station_id", "station_name", "datetime", "temp", "precip",
                       "windspeed", "winddir", "humidity","CA")

# 데이터 다시 확인
# View(weather)
# 데이터 요약
# View(weather)
#hint summary, table
# summary : 내가 분석하고자 하는 컬럼 통계 확인
# print(summary(weather$temp))

# table : 각 열의 행 수를 세어줌.
# print(table(weather$station_name))


# 데이터 행 수 조회
# nrow() : 총 행의 수
# print(nrow(weather))

# 데이터 형변환
# str(weather)
weather$datetime = as.POSIXct(weather$datetime, format='%Y-%m-%d %H:%M')
weather$station_name = as.factor(weather$station_name)

# str(weather)

# 결측값 조회및 0으로 대체
# print(colSums(is.na(weather)))
weather$precip = ifelse(is.na(weather$precip), 0, weather$precip) 
weather$CA = ifelse(is.na(weather$CA), 0, weather$CA)
# print(colSums(is.na(weather)))

# STEP 3 : 기초 통계량 확인 및 시각적 탐색(EDA)
# 풍속, 풍향, 습도의 통계량을 확인합니다.
# 풍속 통계량
# print(summary(weather$windspeed))
# 풍향 통계량
# print(summary(weather$winddir))
# 습도 통계량
# print(summary(weather$humidity))

# 습도의 표준편차와 변동계수 구하기
# 습도의 표준편차
humi_avr = mean(weather$humidity)
# cat('humi_avr: ', humi_avr, '\n')
humi_sd = sd(weather$humidity)
# cat('humi_sd: ', humi_sd, '\n')
# 변동계수 공식 : (표준편차/평균)*100
# cat('변동계수: ', (humi_sd/humi_avr)*100, '\n')

# 풍속과 습도의 상관관계 조회
# print(cor(weather$windspeed, weather$humidity))

# 기온, 풍속, 풍향, 습도, 전운량 상관관계 확인 및 시각화
# 기온, 풍속, 풍향, 습도, 전운량 상관관계 확인
weather_var = weather[, c("temp", "windspeed", "winddir", "humidity", "CA")]
cor_mat = cor(weather_var, use='complete.obs')
print((cor_mat))

# 기온, 풍속, 풍향, 습도, 전운량 상관관계 시각화
library(corrgram)
corrgram(cor_mat, main = '기온, 풍속, 풍향, 습도, 전운량 상관관계 그래프',
         upper.panel = panel.cor)

# 온도와 습도 데이터 분포를 히스토그램으로 표현
# 온도데이터 히스토그램
hist(weather$temp, main = '온도데이터 히스토그램',
     xlab = '온도(c)')

# 습도데이터 히스토그램
hist(weather$humidity, main = '습도데이터 히스토그램', xlab = '습도(%)')

# 풍속의 이상치를 탐색하기 위해 박스플롯 표현
boxplot(weather$windspeed, main = '풍속데이터 박스플롯', 
        ylab = '풍속(m/s)')

# 온도와 습도의 상관관계 표현
colors = rainbow(6) # 도시별 색깔 다르게 지정 : 'colors=rainbow(6)' => 지점이 총 6개니까 6개 색깔로.
# 시각화
plot(weather$temp, weather$humidity, col = colors,
     xlab = '온도', ylab = '습도', main = '온도와 습도의 관계')
# pch : 점크기 'pch=19'는 점 크기를 19로 한다는 뜻.
# cex : 크기 줄임. 'cex=0.8'은 크길ㄹ 80%로 줄인다는 뜻.
legend('topright', legend = unique(weather$station_name), col = colors, 
       pch=19, cex=0.8)

# 풍속과 풍향 시각화
library(openair)
windRose(weather, ws = 'windspeed', wd = 'winddir')

# 풍속과 습도의 K평균 군집화 시각화
weather_var = weather[, c('windspeed', 'humidity')]
set.seed(123)  # 항상 같은 결과가 나오게 설정
clusters = kmeans(weather_var, centers = 3)
plot(weather$windspeed, weather$humidity, col=clusters$cluster)

# 온도 변화 시계열 그래프
# as.Date : 년/월/일까지만 표기(시간은 생략됨)
weather$date = as.Date(weather$datetime)
plot(weather$date, weather$temp, type='l', col='blue',
     main = '날짜별 온도 변화', xaxt='n')
# 월별로 x축 레이블 표기
month = seq(as.Date('2025-01-01'), as.Date('2025-07-01'), by="month")
axis.Date(1, at=month[month<= max(weather$date)],format='%Y-%m', las=1, cex.axis = 0.7)

# 데이터 전처리
# 각 지점별로 평균 기온을 구하시오.
mean_temp_by_station = weather %>% group_by(station_name) %>%
  summarize(평균기온 = mean(temp, na.rm=TRUE))
  
# 풍속이 3 m/s 이상인 데이터만 골라서, 해당 데이터의 평균 습도를 구하시오. (dplyr)
mean_humidity_high_wind = weather %>% filter(windspeed >= 3) %>% 
  summarize(평균습도 = mean(humidity, na.rm=TRUE))

# 3월부터 5월까지 서울의 평균 강수량, 최대 강수량, 최소 강수량을 구하시오.
# 방법1.
seoul_data = weather %>% filter(datetime >='2025-03-01 01:00' & datetime <= 
'2025-05-31 24:00' & station_name =='서울') %>%
  summarize(평균강수량 = mean(precip, na.rm=TRUE), 
            최대강수량= max(precip, na.rm = TRUE,
          최소강수량=min(precip, na.rm = TRUE))
# 방법2.
# seoul_data2 = weather %>% mutate(month = format(datetime, '%m')) %>%
#   filter(month %in% c('03', '04', '05') & station_name == '서울') %>%
#   summarise(평균강수량 = mean(precip, na.rm=TRUE),
#             최대강수량 = max(precip, na.rm=TRUE),
#             최소강수량 = min(precip, na.rm=TRUE))

# 각 지점별로 기온이  가장 높았던 시간대와 그 값을 구하시오.  단, 값을 기준으로 
# 내림차순할 것.
# 방법1)
# max_temp_by_station = weather %>% group_by(station_name) %>%
# filter(temp == max(temp, na.rm=TRUE)) %>%
#   select(station_id, station_name, datetime, temp) %>%
#   arrange(desc(temp))
# # 방법2)
# max_temp_by_station2 = weather %>% group_by(station_name) %>%
#   select(station_id, station_name, datetime, temp) %>%
#   slice_max(temp, n = 1) %>% arrange(desc(temp))
# print(max_temp_by_station2)

# 일자별 습도 평균 구하기
mean_hum_by_date = weather %>% mutate(data = as.Date(datetime)) %>%
  group_by(date) %>%
  summarize(평균습도 = mean(humidity, na.rm = TRUE))
print(mean_hum_by_date)

humidity_ts = ts(mean_hum_by_date$평균습도, frequency = 30)

library(forecast)

# ts로 데이터를 변환해야 arima 시계열 모델에 넣을 수 있다.
# arima : 
auto_model = auto.arima(humidity_ts)
#  h = 에 올바른 값 넣기
forecasted = forecast(auto_model, h = 10) # 향후 10일 습도 예측

predict_data = data.frame(
  time = as.numeric(time(forecasted$mean)),
  forecast = as.numeric(forecasted$mean),
  lower = as.numeric(forecasted$lower[,2]),  # 95% 신뢰구간 하한
  upper = as.numeric(forecasted$upper[,2])   # 95% 신뢰구간 상한
)
actual_data = data.frame(
  time = as.numeric(time(humidity_ts)),
  temp = as.numeric(humidity_ts)
)
library(ggplot2) #고급 시각화

line_plot = ggplot() +
  # 실제값 선그래프
  geom_line(data = actual_data, aes(x = time, y = temp), color = "steelblue", size = 1) +
  # 예측 신뢰구간 리본
  geom_ribbon(data = predict_data, aes(x = time, ymin = lower, ymax = upper), fill = "orange", alpha = 0.3) +
  # 예측값 선그래프
  geom_line(data = predict_data, aes(x = time, y = forecast), color = "red", size = 1.2, linetype = "dashed") +
  labs(
    title = "습도 예측",
    x = "Time",
    y = "습도"
  ) +
  theme_minimal()

print(line_plot)









          