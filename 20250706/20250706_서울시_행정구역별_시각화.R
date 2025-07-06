# 공간 데이터를 처리하고 시각화하기 위한 패키지(프로그램)
library(sf)
library(ggplot2)
setwd('C:/Users/admin/Desktop/r_workspaces/data')

# install.packages('ggiraph') - 지도 이벤트 패키지
library(ggiraph)
shp = 'sig.shp' # 파일이름
korea_map = st_read(shp, quiet = TRUE)

library(dplyr)
seoul_map = korea_map %>% filter(substr(SIG_CD,1,2) == '11')

# csv파일 불러오기
서울시_상권분석_데이터 = read.csv('서울시_상권분석서비스.csv', na.strings = c(""), fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)

서울시_상권분석_데이터$행정동_코드 = as.character(서울시_상권분석_데이터$행정동_코드) # 타입 변환

# 불러온 csv 데이터타입 확인
str(서울시_상권분석_데이터)
print(head(서울시_상권분석_데이터))

# 각 컬럼별 결측값 조회
print(colSums(is.na(서울시_상권분석_데이터)))

# 데이터 요약하기
print(summary(서울시_상권분석_데이터))
options(scipen = 999) # 10진수 표현
print(summary(서울시_상권분석_데이터$음식_지출_총금액))

# 서울시 각 행정구 월 평균 소득 금액을 지도로 시각화
# 1. shp 파일과 서울시 CSV파일을 병합
# 2. 병합하려면 교집합 컬럼 필요

# shp파일에 있는 행정동 코드와 서울시 행정동 코드 데이터타입이 서로 다름.
# 따라서 행정동코드를 문자로 바꿔줘야 함.(위에다 써줬음)

# inner_join : 두 파일을 병합
# 22년~25년까지 데이터가 존재해서 group_by로 각 자치구별 평균소득 조회
merged_data = inner_join(seoul_map, 서울시_상권분석_데이터, 
                         by = c('SIG_CD' = '행정동_코드')) %>% 
  group_by(SIG_CD, 행정동_코드_명) %>% 
  summarise(월평균소득 = mean(월_평균_소득_금액, na.rm = TRUE)) %>% 
  select(SIG_CD, 행정동_코드_명, 월평균소득)

# View(merged_data)

# 지도 시각화
result = ggplot(merged_data) + 
scale_fill_gradient(low = '#ececec', high = 'blue', name =
                      '월평균소득') + # 농도에 따라 색상 조절
  geom_sf_interactive(aes(
    fill = 월평균소득,
    tooltip = 행정동_코드_명,
    data_id = SIG_CD))
  labs(title = '서울시 22~25년 월평균 소득', x = '경도', y = '위도') + 
  theme_minimal()   # 회색 배경 제거

giraph = girafe(ggobj = result) # 지도 이벤트 추가(마우스 호버)
# 결과 출력
print(giraph)