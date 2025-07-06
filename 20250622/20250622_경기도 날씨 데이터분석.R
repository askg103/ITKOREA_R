# 1. 데이터 수집
# weather2 = read.csv('서울경기_날씨데이터.csv',na.strings = c(""),
#                     fileEncoding = 'CP949', #한글깨짐 방지
#                     encoding = 'UTF-8', #한글깨짐 방지
#                     check.names = FALSE)

colnames(weather) = c('station_id', 'station_name', 'datatime', 'temp', 'precip','windspeed', 'winddir', 'humidity', 'CA')
# 1-1. 수집한 데이터 확인
# View(weather2)

# 2. 데이터 구조와 변수 확인
# str(weather2)

# 2-1. head로 상위 데이터 확인
# print(head(weather2,4))

# 수집한 데이터 전체 개수 확인
# print(nrow(weather2))

# 전체 칼럼 요약(사분위수, 평균)
# print(summary(weather2))
# print(table(weather2$지점명))

# 컬럼명을 한국어에서 영어로 변경
# col+names
열이름 = colnames(weather2)
# print(열이름)
# View(weather2)
colnames(weather2) = c('station_id', 'station_name', 'datetime', 'temp', 'precip',
                       'windspeed', 'humidity')

# 일시(datetime) 문자에서 date 형태로 형 변환
weather2$datetime = as.POSIXct(weather2$datetime, format='%Y-%m-%d %H:%M')
# str(weather2)
# View(weather2)

# 누락된 데이터(결측값) 처리(0으로 대체)
# is.na() : 결측값이니?
# col+sums : 총합
# print(colSums(is.na(weather2)))

# 결측값을 0으로 대체
# weather2$precip[is.na(weather2$precip)]=0         # 방법1
# weather2$precip = ifelse(is.na(weather2$precip), 0, weather2$precip)  # 방법2

# 체감온도 컬럼 만들기
weather2$feels_like = weather2$temp - ((100-weather2$humidity)/5)
# print(head(weather2))

# 3. 기초 통계량 확인 및 시각적 탐색(EDA)
# 3-1. 분석할 컬럼 통계량 산출
# 온도 통계량 요약
# print(summary(weather2$temp, na.rm=TRUE))
# # 습도 통계량 요약
# print(summary(weather2$humidity, na.rm=TRUE))
# # 강수량 통계량 요약
# print(summary(weather2$precip, na.rm=TRUE))
# # 풍속 통계량 요약
# print(summary(weather2$windspeed, na.rm=TRUE))
# 온도 표준편차 구하기
temp_sd = round(sd(weather2$temp, na.rm=TRUE))
# print(temp_sd)   # 표준편차 결과값: 1
# 표준편차가 높은건지 낮은건지 판단하기 위해서는 변동계수를 구해야 함.

# 변동계수 구하기
# 변종계수 공식: (표준편차/평균)*100 
#  온도 평균
temp_evg = mean(weather2$temp, na.rm=TRUE)
# print(temp_evg)        # 결과값 : 23.6

# 변동계수
CV = (temp_sd/temp_evg)*100
# cat('온도 변동계수: ', CV, '\n')    # 결과값 : 4.237288
# 보통 변동계수(CV)가 10~20 이하면 고르게 분포

# 상관계수 행렬
# mat : 행렬, cor : 상관계수
# 상관관계 값은 -1 ~ 1 사이로 0에 가까울수록 상관관계가 약함을 의미
cor_mat = cor(weather2[, c('temp', 'precip', 'windspeed', 'humidity')], use = 'complete.obs')
print(cor_mat)

# 그래프로 해당 상관관계 표현
# library(corrgram)
corrgram(cor_mat, main = '온도, 강수량, 풍속, 습도 상관관계 그래프',
         lower.panel = panel.shade,
         upper.panel = panel.cor)

# 기본 plot으로 시각화하기
# ggplot2는 고급시각화에 적합
# par(mfrow = c(1,3))
# 기본시각화 - 히스토그램
hist(weather2$temp, main = '온도데이터 분포', xlab='온도')
# 습도 히스토그램
hist(weather2$humidity, main = '습도데이터 분포', xlab='습도')
# 박스플롯
 boxplot(weather2$temp, main = '풍속 박스플롯', ylab='풍속')
 
# 1행 1열로 복구
# par(mfrow=c(1,1))

# 두 변수 간의 관계를 시각적으로 표현
# 1. 시간별 풍속 변화
plot(weather2$datetime, weather2$windspeed, type='l', main = '시간에 따른 풍속 변화',
     xlab = '시간', ylab='풍속')
# 습도와 강수량 관계
# 산점도로 회귀선까지 추가
# 습도와 강수량은 양의 관계
plot(weather2$humidity, weather2$precip, main = '습도vs강수량', xlab = '습도', 
     ylab='강수량')
# 회귀선 추가
# lm : linear model(선형모델)
model = lm(weather2$precip ~ weather2$humidity)     # 적는 순서 주의. 강수량이 먼저인지 습도가 먼저인지 주의할 것.
# abline : add line
abline(model, col='blue', lwd=2)

# 풍속과 기온의 관계
plot(weather2$windspeed, weather2$temp, main='풍속vs기온', xlab='풍속', ylab='기온')
# 회귀선 추가
model = lm(weather2$temp ~ weather2$windspeed)
abline(model, col='red', lwd=4)
par(mfrow=c(2,3))

# 오늘 복습은 여기까지. 다음 복습은 '데이터분석 6강, 데이터 전처리'부터 시작 
