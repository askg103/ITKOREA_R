# library(dplyr)

# csv파일 불러오기
센서_데이터 = read.csv('sensor_data.csv', fileEncoding = 'CP949',
                  encoding = 'UTF-8', check.names=FALSE)
# View(센서_데이터)

# 데이터타입 확인하기(꼭!!! 잊어버리지 말고 항상)
str(센서_데이터)

# 이상치 제거하기 (임계값=3)
# 먼저, 평균을 구한다.
mu = mean(센서_데이터$온도)
# print(avg_result)  - 결과 : 25.40022

# 그다음, 표준편차를 구한다.
sigma= sd(센서_데이터$온도)
# print(sd_result)   - 결과 : 13.08198

# z_score 열 추가하기
센서_데이터$z_score = abs((센서_데이터$온도-mu) / sigma)
print(센서_데이터)

# z_score가 임계값 3 미만인 데이터 조회하기
# 임계값 2는 비교적 넓은 범위의 이상치를 탐지할 때 사용
센서_데이터= 센서_데이터 %>% filter(z_score<3)
print(센서_데이터)

# 정규분포 시각화
# x, y축 그리기
온도_최솟값 = min(센서_데이터$온도) 
# print(온도_최솟값)     -결과 : -13.59254
온도_최댓값 = max(센서_데이터$온도)
# print(온도_최댓값)     - 결과 : 63.75382
x = seq(온도_최솟값 - 10, 온도_최댓값 + 10, length=50)
y = dnorm(x, mu, sigma)

# PDF 저장하기
pdf('sensor_data.pdf', family = 'Korea1deb')# PDF 선언

# 정규분포 그리기
plot(x, y, type='l', main = '온도센서 정규분포도', xlab = '온도', ylab = '확률')

# 중앙값, 하위 20%, 상위 20% 조회
med = median(센서_데이터$온도)
q20 = quantile(센서_데이터$온도, 0.2)
q80 = quantile(센서_데이터$온도, 0.8)

# 선 표시
abline(v=med, col='purple')
abline(v=q20, col='forestgreen')
abline(v=q80, col='orange')

# 신뢰구간 표시
n = nrow(센서_데이터)
se = sigma/sqrt(n)
# 신뢰구간(confidence interval, 줄여서 ci)
ci_low = mu - 1.96 * se
ci_high = mu + 1.96 * se

# 신뢰구간 표기
# lwd : 선 두께, lty : 점선
abline(v=ci_low, col = 'red', lwd=2, lty=4)
abline(v=ci_high, col = 'red', lwd=2, lty=4)

dev.off()
# 주의사항 : 꼭 필요한 공식 주석처리하지 않도록 주의할 것. 식이 길어지다 보면 
# 꼭 필요한 건지 모르고 주석처리 할 때가 있음. 주의!!

# bike = read.csv('서울특별시_공공자전거_이용정보'.csv,
#                 fileEncoding = 'CP949', 
#                 encoding = 'UTF-8', 
#                 check.names = FALSE)

View(bike)