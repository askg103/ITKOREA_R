# <20250601_그래프.R 파일 새로 생성>
# 시각화
# emp.csv 파일 불러오기
emp=read.csv('emp.csv')
# View(emp)
# dplyr도 임포트하기
library(dplyr)

# 1.박스플롯
# 박스플롯은 여러 그룹의 데이터 분포를 비교하여 중앙값과 퍼짐 정도의 차이를 분석
# 예) 남 vs 녀 영어점수 비교, A팀 vs B팀 영업성과 비교

# 부서별 급여 박스플롯으로 시각화
# main : 그래프 이름
# xlab : x축
# ylab : y축
pdf('부서별 급여_박스플롯.pdf', family='Korea1deb')
boxplot(emp$SAL ~ emp$DEPTNO, main= '부서별 급여 현황', xlab = '부서', ylab = '급여', col = c('orange','green','blue'))

dev.off()

# 막대그래프
# 범주형 데이터 빈도나 크기를 비교할 때 사용
# 예) 제품별 판매량 비교, 직업에 따른 평균 소득

# 부서별 평균 급여를 막대그래프로 표현
# 전처리로 평균 급여 조회
dept_avg_sal= emp %>% group_by(DEPTNO) %>% summarize(avg_SAL=mean(SAL))
# names.arg : x축 데이터 표시
# main : 그래프 이름
# ylab : y축
barplot(dept_avg_sal$avg_SAL, names.arg = dept_avg_sal$DEPTNO, main='부서 별 평균 급여', ylab='급여')
# 안 됨

# 히스토그램
# 데이터를 일정한 구간으로 나누고, 각 구간에 속하는 데이터의 빈도를 막대의 높이로 표현

# 문제1. mutate를 사용해서, 직원COMM이 NA인 직원만 100 지급
emp = emp %>% mutate(COMM = ifelse(is.na(COMM),100,COMM))
print(emp)
# 문제2. Mutate를 사용해서, 직원 급여와 직원 커미션을 더한 새로운 컬럼, Sum_SAL_COMM 만들기
emp = emp %>% mutate(SUM_SAL_COMM= SAL+COMM)
print(emp)

hist(emp$SUM_SAL_COMM, main='직원 급여+커미션 분포', xlab='급여+커미션', ylab='빈도')
# 안됨

# 평균선 추가
# abline: add a lint(직선을 추가하다)
# lwd : line Width(선두께)
abline(v=mean(emp$SUM_SAL_COMM), col='red',lwd=10)

