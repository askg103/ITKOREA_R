# <건강검진.R>파일 새로 생성
# 컬럼이 한국어일 때 아래와 같이 설정할 것.
health = read.csv('국민건강보험공단_건강검진정보.csv', 
                  fileEncoding = 'CP949', 
                  encoding = 'UTF-8', 
                  check.names = FALSE)

# View(health)
# 혈색소 데이터를 min-max 스케일링 하시오.
혈색소_최솟값=min(health$혈색소)
혈색소_최댓값=max(health$혈색소)
health$혈색소_스케일링=(health$혈색소-혈색소_최솟값)/(혈색소_최댓값-혈색소_최솟값)
# View(health)

# 로드
library(dplyr)
# nrow() : 행 수
# 0.8을 기준으로 하는 이유: 0.8 ~ 1 사이 데이터를 '이상치값'이라고 하기 때문.
결과=health %>% filter(혈색소_스케일링>0.8) %>% nrow()
# print(결과)

# 문제1. 데이터 구조 확인
str(health)

# 문제2. 상위 5행까지 출력
head(health,5)

# 컬럼명에 괄호가 있는 경우 백틱(``)을 사용해야 제대로 된 결과값이 나옴.  
결과=health %>% select(`혈청지오티(AST)`)
View(결과)

# 데이터셋 dplyr 기초
# 문제: dplyr 패키지를 불러오고 현재 작업 폴더 경로 출력하기
library(dplyr)
print(list.files())
# 문제: 국민건강보험공단_건강검진정보.csv 파일 불러와 View로 출력하기.
health = read.csv('국민건강보험공단_건강검진정보.csv', 
                  fileEncoding = 'CP949', 
                  encoding = 'UTF-8', 
                  check.names = FALSE)
# View(health)
# 문제: 데이터프레임의 앞부분 출력 단, 10행 까지
# head(health,10)
# 문제: 데이터프레임의 뒷부분 출력 단, 5행 까지
# tail(health,5)
# 문제: 데이터프레임의 데이터 타입 확인
# str(health)
# 문제: 성별, 연령대, 그리고 지역 열만 조회
결과=health %>% select(성별, `연령대코드(5세단위)`,시도코드)
# print(결과)

# 문제: 2022년에 건강검진을 받은 사람 중 음주여부가 1인 사람의 가입자일련번호, 성별 조회
# str(health)
결과=health %>% filter(기준년도==2022&음주여부==1) %>% select(가입자일련번호, 성별) 
# print(결과)

# 문제: 키(height)와 몸무게(weight) 열을 사용하여 새로운 열 BMI를 추가하세요.
# BMI공식은 아래와 같습니다.
# BMI=weight/(height/100)2승
# health=helath : 기존의 health에 health 결과값을 덮어씌움
# ** : 지수 
health=health %>% mutate(BMI=`신장(5cm단위)`/ (`체중(5kg단위)`/100)**2)             
# print(health)
# View(health)
# 문제: 음주여부와 흡연상태가 1인 사람의 수축기혈압 , 성별 조회. 단, 혈압 내림차순으로 정렬하세요.
결과=health %>% filter(음주여부==1 & 흡연상태==1) %>% select(수축기혈압, 성별) %>% arrange(desc('혈압'))
# print(결과)

# 문제: 성별(성별)로 데이터를 그룹화하고, 각 그룹별 평균 BMI를 계산하세요. 결과는 성별과 평균_BMI 열로 구성되어야 합니다.
결과=health %>% group_by(성별) %>% summarize(평균_BMI=mean(BMI,na.rm=TRUE)) %>% select(성별,평균_BMI)
# print(결과)

# 문제: 식전혈당 126 이상인 사람 중 수축기혈압 상위 5명 출력
# 상위~명 : 정렬(내림차순) 이용
결과= health %>% filter(`식전혈당(공복혈당)`>=126) %>% arrange(desc(수축기혈압)) %>% slice(1:5)
# View(결과)

# 문제: 허리둘레 중앙값 조회
결과=health %>% summarize(허리둘레_중앙값=median(허리둘레,na.rm=TRUE))
# print(결과)
# 성별로 음주여부가 1인 평균 체중을 막대그래프로 표현
avg_weight_by_gender=health %>% filter(음주여부==1) %>% group_by(성별) %>% summarize(평균체중=mean(`체중(5kg단위)`,na.rm=TRUE))
# View(avg_weight_by_gender)
# 데이터 시각화
barplot(avg_weight_by_gender$평균체중, names.arg = avg_weight_by_gender$성별,     # 그래프 데이터
        col=c('blue', 'red'),             # 그래프 색상 표현
        main='음주를 하는 성별 평균체중',           # 그래프 이름
        ylab='평균 체중(kg)'                       # y축 이름
        )

# 연령별 식전혈당과 표준편차 평균 구하기->상향된 막대그래프로 표현

# 연령대별 평균 식전혈당, 표준편차
avg_result_by_age=health %>% group_by(`연령대코드(5세단위)`) %>% summarize(식전혈당_표준편차=sd(`식전혈당(공복혈당)`,na.rm=TRUE),식전혈당_평균=mean(`식전혈당(공복혈당)`,na.rm=TRUE)
)
print(avg_result_by_age)

# 사분위수 계산
q=quantile(avg_result_by_age$식전혈당_표준편차)
print(q)

# 행렬로 묶기
# bind : 묶다 
mat=rbind(avg_result_by_age$식전혈당_표준편차,avg_result_by_age$식전혈당_평균)
print(mat)

# 위에서 묶은 것들을 가지고 막대그래프 시각화
barplot(mat,names.arg = avg_result_by_age$`연령대코드(5세단위)`,
        beside = TRUE,    #beside : 두 막대 표현
        main = '연령대 별 식전혈당 평균과 표준편차',
        ylab='식전혈당',
        xlab = '연령대코드(5세단위)',
        col=c('blue','red'),
        legend.text = c('표준편차','평균')       #legend : 범례(전설X)
        )

# 산점도
# 남성의 혈청지오티(간기능)을 min-max로 변환 후, 
# 변환된 값이 0.8보다 큰 남성의 가입자일련번호, 신장, 체중, 
# 혈청지오티 조회하기. 단, 혈청지오티 기준으로 내림차순

# 데이터 스케일링
ast_result_by_male=health %>% filter(성별==1) %>% 
  mutate(AST_SCALED=(`혈청지오티(AST)`-min(`혈청지오티(AST)`))/(max(`혈청지오티(AST)`)-min(`혈청지오티(AST)`)))
View(ast_result_by_male)

# 0.8보다 큰 남성 조회
high_ast_male=ast_result_by_male %>% filter(AST_SCALED >= 0.8) %>%
  select(가입자일련번호,`신장(5cm단위)`,`체중(5kg단위)`,`혈청지오티(AST)`) %>%
  arrange(desc(`혈청지오티(AST)`))
print(high_ast_male)

# 간수치와 나이 관계(산점도 표현)
age=ast_result_by_male$`연령대코드(5세단위)`
ast=ast_result_by_male$AST_SCALED
plot(age, ast, main='연령대와 혈청지오티 관계',
     xlab='연령대코드',
     ylab='혈청지오티',
     col='blue',      #점 색깔
     pch=20           #점 크기
     )
# 회귀선 추가
# lm:회귀선
model=lm(ast~age)
# abline : add a line(선을 추가하다)
abline(model, col='red',lwd=2)
