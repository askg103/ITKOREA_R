# 정규분포 : 확률밀도 그래프의 한 종류. 키, 점수처럼 연속적인 값 분포를 '정규분포'라고 함.
# 이항분포 : 결과가 2개밖에 없는 것. ex) 동전 앞 뒤

# 정규분포
students = data.frame(
  name = c("Alice", "Bob", "Charlie", "David", "Eve", "Jose"),
  score = c(85, 92, 78, 95, 88, 200)
)
View(students)
# 평균, 표준편차 조회
# 평균(mean)
mu = mean(students$score)
# 표준편차(sd)
sigma=sd(students$score)

# 2. 정규분포 곡선용 x, y값 생성
# min : 최솟값
# max : 최댓값
# length : 곡선을 부드럽게 그려주는 옵션
x = seq(min(students$score), max(students$score), length=50)
# dnorm : density의 d와 normal distribution(정규분포)의 norm이 결합된 단어
# dnorm은 주어진 평균과 표준편차를 갖는 정규분포에서 특정 x에 대한 확률밀도를 계산(데이터가 특정 구간에 있을 확률)
y = dnorm(x, mu, sigma)

# 정규분포 시각화
# type : 'l' 은 'line'을 의미함
# plot(x, y, type='l', lwd = 2, col = 'blue', 
     # main = '학생 점수 정규분포', xlab = '점수',  ylab = '확률')

# 조제 200점 때문에 정규분포 그래프가 이상하게 나옴. 이럴 땐 어떻게 해야 할까?
# 이상치 제거(데이터 전처리 과정 중 하나)를 해야함
# 데이터의 분포에서 극단적으로 벗어난 값을 탐지하고 처리하는 방법

# Z-score : z스코어의 결과가 0이면 데이터값이 평균과 동일함을 의미
# 만약 z스코어가 양수라면, 양수 데이터 값이 평균보다 크며, 양수 값이 클수록 평균에서 멀리 떨어져있음을 의미

print(students)

# 평균과 표준편차를 구해야 함.
# 평균 구하기
mu = mean(students$score)
# 표준편차 구하기
sigma = sd(students$score)
# 평균
# print(mu)
# 표준편차
# print(sigma)
# z_score
# abs : 절대값
students$z_score = abs((students$score -mu) / sigma)
# print(students)   - 나머지는 다 0.XXX인데, 조제만 2.XXX가 나옴. 

# 2~3 (임계값) : 상황에 따라 조절하면 됨

library(dplyr)

# z_score가 2 이하인 데이터 조회하기
이상치제거_데이터 = students %>% filter(z_score<=2)
View(이상치제거_데이터)

# 이상치 제거 후 정규분포 그래프 시각화
# 평균(mean) 구하기
mu = mean(이상치제거_데이터$score)
# 표준편차(sd) 구하기
sigma=sd(이상치제거_데이터$score)
# -10, +10 추가로 데이터 범위를 넘어선 부드러운 곡선 생성.
x = seq(min(이상치제거_데이터$score)-10, max(이상치제거_데이터$score)+10, length=50)
y = dnorm(x, mu, sigma)

plot(x, y, type='l', lwd = 2, col = 'blue', main= '학생 점수 정규분포',
     xlab = '점수', ylab = '확률')

# 중앙값, 상위 20%, 하위 20% 선 추가
# median : 중앙값
med = median(이상치제거_데이터$score)
# print(quantile(이상치제거_데이터$score))   -사분위수 출력

#하위 20% 
q20 = quantile(이상치제거_데이터$score, 0.2)
# 상위 20%
q80 = quantile(이상치제거_데이터$score, 0.8)

# add line으로 선 추가하기
# lwd : 선 두께
# lty : 점선
abline(v=med, col = 'purple', lwd=2, lty=2)
abline(v=q20, col = 'orange', lwd=2, lty=2)
abline(v=q80, col = 'red', lwd=2, lty=2)

# 신뢰구간 추가하기
# 신뢰구간 : 진짜 답이 있을 것 같은 범위(신뢰할 수 있는 데이터 범위)

# 데이터 행의 수 조회
n = nrow(이상치제거_데이터)
# print(n)   - 전체 행의 수 : 5

# 표준오차
# 표준오차 : 내가 구한 평균값이 얼마나 믿을만한지를 알려주는 숫자
# 표준오차가 작다 : 내가 구한 평균이 진짜 평균에 가까울 확률이 높다.
# 표준오차가 크다 : 내가 구한 평균이 진짜 평균과 많이 다를 수 있다.\
# sqrt : 제곱근(Square root)
# 예) sqrt(4) => 2, sqrt(9) => 3
se = sigma / sqrt(n)
# 1.96? 통계 분석에서 일반적으로 사용되는 신뢰수준 값 -> 95% 신뢰
ci_low = mu - 1.96 * se
ci_high = mu + 1.96 * se

# 신뢰구간 그래프 표현
abline(v= ci_low, col = 'black', lwd=2)
abline(v= ci_high, col = 'black', lwd=2)
