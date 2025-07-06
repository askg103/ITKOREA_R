# 교육_지출_총금액 지도로 시각화하기
library(sf)
library(ggplot2)
library(ggiraph)

# 1. 지도 파일 불러오기
shp = 'sig.shp'
korea_map = st_read(shp, quiet = TRUE)

# 데이터타입 확인
str(korea_map) # 행정구역 코드(SIG_CD) ex) 종로구 -> 11110

# 서울 행정구역만 조회
library(dplyr)
seoul_map = korea_map %>% filter(substr(SIG_CD,1,2) == '11')

# csv파일 불러오기
서울시_상권분석_데이터 = read.csv('서울시_상권분석서비스.csv', na.strings = c(""), fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)
서울시_상권분석_데이터$행정동_코드 = as.character(서울시_상권분석_데이터$행정동_코드)

# 불러온 csv파일 확인
str(서울시_상권분석_데이터)
print(head(서울시_상권분석_데이터))
print(colnames(서울시_상권분석_데이터)) # 컬럼이름만 조회

# csv에 있는 행정구역코드와 shp(지도파일)에 있는 행정구역 코드의 데이터타입이 
# 서로 다름.
# 두 파일을 병합하기 위해서는 교집합컬럼(행정구역코드) 데이터타입이 서로 동일해야함
# 따라서 숫자형을 문자형으로 형변환해야함.

merged_data= inner_join(seoul_map, 서울시_상권분석_데이터,
                        by = c('SIG_CD' = '행정동_코드')) %>%
  group_by(SIG_CD, 행정동_코드_명) %>%
  summarize(교육지출 = mean(교육_지출_총금액, na.rm = TRUE)) %>% 
  select(SIG_CD, 행정동_코드_명, 교육지출) %>% arrange(desc(교육지출)) %>% 
  head(5)

View(merged_data)

# 지도시각화
result = ggplot(merged_data) +
  scale_fill_gradient(low = '#ececec', high = 'blue', name = '교육지출총금액') +
  geom_sf_interactive(aes(
    fill = 교육지출, 
    tooltip = 행정동_코드_명,
    data_id = SIG_CD # 각 영역을 고유하게 식별하기 위한 ID
  )) + 
  theme_minimal() +
  labs(title = '서울시 월평균소득', x = '경도', y = '위도')
giraph = girafe(ggobj = result)   # 지도 이벤트 추가(마우스 호버)

print(giraph)