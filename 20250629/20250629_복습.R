data = data.frame(     # 벡터 집합
  name = c('a','b','c','d','e','f'),    #벡터(하나의 열)
  heights  = c(120, 130, 140, 150, 160, 200)   #벡터
)
print(data$heights)   #$ : 열 접근
print(data[3,c('name', 'heights')])    # ','을 기준으로 왼쪽은 행, 오른쪽은 열

# $ : 새로운 컬럼을 생성할 수 있음
data$birth = c('1999-01-01','1999-01-01','1999-01-01','1999-01-01','1999-01-01','1999-01-01')

# 데이터 구조 확인(중요!!)
str(data)
 
# 문자를 날짜형으로 변환
# 날짜데이터에 년/월/일만 있으면
# $ : 조회, 수정, 추가(삭제는 불가능)
# []: 조회(행, 열)
data$birth = as.Date(data$birth)
str(data)

# 이상치 제거 -> IQR
# IQR => 소득(비대칭 데이터) 이런 데이터를 탐지할 때 사용

# 1. Q1과 Q3을 구하기
Q1 = quantile(data$heights, 0.25) # 하위 25$
cat('Q1 :', Q1, '\n')
Q3 = quantile(data$heights, 0.75) # 하위 75%
cat('Q3 :', Q3, '\n')

# 2. IQR(사분위 범위) 구하기
IQR_VALUE = Q3-Q1   # 157.5 - 132.5 = 25
cat('IQR_VALUE: ', IQR_VALUE, '\n')

# 변수 이름이 대문자면:'상수'를 의미. 프로그래밍에서 변수 이름이 대문자면 
# 암묵적으로 수정하지 말라는 의미.
# 변수 이름이 소문자: 암묵적으로 수정해도 된다는 의미.

# 3. 이상치 기준선 만들기
# 1.5(존 튜키, 통계학자가 제안한 것. 표준 기준으로 널리 사용하고 있음)
# 키 95~195가 아닌 학생들 데이터는 이상치로 판단
lower_bound = Q1-1.5*IQR_VALUE
upper_bound = Q3+1.5*IQR_VALUE
cat('lower_bound: ', lower_bound, '\n')
cat('upper_bound: ', upper_bound, '\n')

# 4. 이상치 확인
library(dplyr)
outliers = data %>% filter(heights < lower_bound | heights>upper_bound)
print(outliers)

# 키 데이터 변환
data$heights  = c('120cm', '130cm', '140cm', '150cm', '160cm', '200cm')
str(data)    # 키가 문자로 수정됨

# 숫자로 변환하기
# 1. 문자열 처리 => 'cm' 제거
# gsub : 문자에서 특정 패턴(cm)을 찾아 다른 문자('')로 `대체`
data$heights = gsub('cm','',data$heights)
str(data)   # 확인
data$heights = as.numeric(data$heights)   # 숫자로 형변환
# str(data)  # 확인
print(sum(data$heights))   # 키 총합. 이렇게 문자데이터를 숫자로 형변환을 해야 연산이 가능
