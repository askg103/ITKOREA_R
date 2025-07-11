# <20250601_문제풀이.R파일 새로 생성>
# 문제풀이
bike = read.csv('서울특별시_공공자전거_이용정보.csv', 
                fileEncoding = 'CP949', 
                encoding = 'UTF-8', 
                check.names = FALSE)
View(bike)
04. 서울시 공공자전거
서울특별시_공공자전거_이용정보.csv를 활용한 문제입니다.

# 한국어 파일의 경우, CP949 또는 EUC-KR 인코딩을 사용하는 것이 일반적
data = read.csv('서울특별시_공공자전거_이용정보.csv',
                na.strings = c(""), # ""를 NA로 표현한다.
                fileEncoding = 'CP949', 
                encoding = 'UTF-8', 
                check.names = FALSE)
View(data)
# 데이터전처리만 진행해주세요.
library(dplyr)
# 문제 1: 이동거리(M)가 2000 이상인 데이터 중 해당 대여소명과 이동거리(M), 이용시간(분)만 조회.
결과=bike %>% filter(`이동거리(M)`>=2000) %>% select(대여소명,`이동거리(M)`,`이용시간(분)`)
View(결과)

# 문제 2: 대여소 별 이용건 수 조회.
결과=bike %>% group_by(대여소명) %>% summarize(이용건수)
View(결과)

# 문제 3: 일일회원과 정기회원 이용 건 수, 평균 이용시간 조회. 단, 일일회원권 중 비회원은 제외
결과= bike %>% filter(대여구분코드=!`일일권(비회원)`) %>% select()- 모르겠음
# 문제 4: 탄소량이 0.8 이상인 이용 건수는 몇 건인지 조회.
# min-max로 변환
스케일링=기존값 - 최솟값 / 최댓값-최솟값
x=bike %>% mutate(탄소량sc=탄소량-min(탄소량)/max(탄소량)-min(탄소량)
)
View(x)
# min-max로 변환한 값을 이용해서 0.8 이상인 이용건수 조회
모르겟음

# 문제 5: 연령대별로 평균 이동거리(M) 조회.
결과=bike %>% group_by(연령대코드) %>% summarize(avg_이동거리=mean(`이동거리(M)`)) 
View(결과)

# 문제 6: 연령대별로 이용건수의 합과 평균 운동량을 구한 뒤, 운동량 평균이 가장 높은 연령대 조회.
결과=bike %>% group_by(연령대코드) %>% summarize(이용건수합계=sum(이용건수),평균운동량=mean(운동량)) %>% arrange(desc(평균운동량))
View(결과)-모르겠음

# 문제 8: 10대 여성 회원의 평균 운동량, 평균 이동거리 조회. 단, 평균 운동량으로 내림차순 할 것
결과= bike %>% filter(연령대코드=='10대') %>% summarize(평균운동량=mean(운동량),평균이동거리=mean(`이동거리(M)`)) %>% arrange(desc(평균운동량)) 
print(결과)
# 문제 9: 운동량을 데이터 스케일링 min-max로 변환한 scaled_운동량 컬럼을 추가 0.8 이하인 회원 이동거리 사분위수 출력
# 
# 데이터전처리 ~ 시각화까지 진행해주세요. 최종 그래프 결과는 PDF로 저장하시오.
# 문제 1: 성별 운동량 박스플롯 표현. 단, 이용시간(분) 3분 이하는 제외
# 
# 문제 2: 연령대별 평균 이동거리(M)를 막대그래프로 표현.
# 
# 문제 3: 이동거리를 데이터 스케일링 min-max로 변환한 scaled_이동거리 컬럼을 추가하고, 값이 0.5 이상인 이용자를 연령대별 평균 운동량과 평균 이용시간을 막대그래프로 표현.
# 
# 문제 4: 정기권을 구매한 이용자 중 연령대 별 평균 운동량 파이차트로 표현. 단, 이용시간(분) 5분 이하는 평균에서 제외
# 
# 문제 5: 정기권 회원 중 연령대가 10대에서 50대 사이의 이용시간과 운동량을 비교하는 산점도그래프 표현하시오.(이용시간 x축, 운동량 y축) 회귀선까지 추가하시오.
