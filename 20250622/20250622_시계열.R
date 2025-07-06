weather = read.csv('날씨데이터.csv', #csv파일이름
                   na.strings = c(""),
                   fileEncoding = 'CP949', #한글깨짐 방지
                   encoding = 'UTF-8', #한글깨짐 방지
                   check.names = FALSE)

colnames(weather) = c('station_id', 'station_name', 'datatime', 'temp', 'precip','windspeed', 'winddir', 'humidity', 'CA')

library(dplyr)
# 서울, 대전 1월~6월 일별 온도 평균
weather_daily = weather %>% mutate(date = as.Date(datatime)) %>%
  group_by(date) %>% summarise(temp_avg = mean(temp, na.rm =TRUE))

print(head(weather_daily))

# 시계열 타입으로 변환
# 변환하는 이유 : 예측 모델 대부분이 시계열 타입으로 받는다.
# frequency = 30 : 한 달에 30일 있다고 가정
temp_ts = ts(weather_daily$temp_avg, frequency = 30)      # 시계열 타입
print(head(temp_ts))
str(temp_ts)

library(forecast)
# arima : 시계열 데이터를 분석하고, 미래 값을 예측하는 데 사용되는 머신러닝 통계모델 이름
auto_model = auto.arima(temp_ts)

# 향후 30일 예측
# h = 30
forecasted = forecast(auto_model, h = 30)
print(forecasted)

# 예측 데이터와 실제 데이터를 데이터프레임으로 만들어서 시각화
predict_data = data.frame(
  time = as.numeric(time(forecasted$mean)),
  forecast = as.numeric(forecasted$mean),
  lower = as.numeric(forecasted$lower[,2]),  # 95% 신뢰구간 하한
  upper = as.numeric(forecasted$upper[,2])   # 95% 신뢰구간 상한
)
actual_data = data.frame(
  time = as.numeric(time(temp_ts)),
  temp = as.numeric(temp_ts)
)
line_plot = ggplot() +
  # 실제값 선그래프
  geom_line(data = actual_data, aes(x = time, y = temp), color = "steelblue", size = 1) +
  # 예측 신뢰구간 리본
  geom_ribbon(data = predict_data, aes(x = time, ymin = lower, ymax = upper), fill = "orange", alpha = 0.3) +
  # 예측값 선그래프
  geom_line(data = predict_data, aes(x = time, y = forecast), color = "red", size = 1.2, linetype = "dashed") +
  labs(
    title = "Temperature Forecast",
    x = "Time",
    y = "Temperature"
  ) +
  theme_minimal()

print(line_plot)
# 예측값과 실제값의 차이가 얼마나 날까?
# 신뢰 가능한가?
# MAE  : 모델성능평가

actual = weather_daily$temp_avg
actual_length = length(actual)     # actual 데이터의 길이
cat('actual_length: ',actual_length, '\n')

predicted = as.numeric(forecasted$mean)
predicted_length = length(predicted)
cat('predicted_length: ', predicted_length, '\n')

# MAE : 예측이 얼마나 잘 맞았는지 쉽게 알려주는 '점수'
# 예를들어, '내일 기온이 25도일 거야'라고 예측했는데 실제 온도가 27도였다.
# 오차는 2도. 이런 오차들을 모두 더해서 평균을 내면 MAE가 된다.
# actual[1:predicted_lenth]
MAE = mean(abs(actual[1:predicted_length]-predicted))
cat('MAT: ', MAE, '\n')      # 결과값: 27
# 예측값과 실제값의 차이가 평균적으로 27도라는 뜻

