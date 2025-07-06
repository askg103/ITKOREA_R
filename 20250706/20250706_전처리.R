library(dplyr)
library(sf)
library(ggplot2)
library(ggiraph)
setwd('C:/Users/admin/Desktop/r_workspaces/data')
서울시_상권분석_데이터 = read.csv('서울시_상권분석서비스.csv', na.strings = c(""), fileEncoding = 'CP949', encoding = 'UTF-8', check.names = FALSE)

# View(서울시_상권분석_데이터)

# 24년도 서울시 행정동 코드명별 평균 월소득금액, 평균 지출총금액, 
# 평균 교육지출 총금액 조회

서울시_24년도 = 서울시_상권분석_데이터 %>% filter(substr(기준_년분기_코드,1,4) == 
                 '2024') %>% group_by(행정동_코드_명) %>% 
                 summarise(
                 평균_소득금액 = mean(월_평균_소득_금액, na.rm = TRUE),
                 평균_지출총금액 = mean(지출_총금액, na.rm = TRUE),
                 평균_교육지출금액 = mean(교육_지출_총금액, na.rm = TRUE)
                 )
print(서울시_24년도)

# 25년도 행정동 코드명별 월_평균_소득_금액 평균 조회
서울시_25년도 = 서울시_상권분석_데이터 %>% filter(substr(기준_년분기_코드,1,4) == 
                '2025') %>% group_by(행정동_코드_명) %>% 
  summarise(
    평균_소득금액 = mean(월_평균_소득_금액, na.rm = TRUE)
  )
print(서울시_25년도)

# 별5개!!!substr
year = '202502'
print(substr(year,1,4)) # 2025만 출력

# 25년도 행정동 코드명별 월_평균_소득_금액 히스토그램으로 시각화
par(mfrow = c(1,2)) # 1행 2열로 그래프 배치(단, 기본그래픽)
# 히스토그램
hist(서울시_25년도$평균_소득금액, col = 'skyblue', main = '25년
     행정동별 평균 소득 분포',
     xlab = '평균소득(원)', ylab = '수')

# 박스플롯
barplot(서울시_25년도$평균_소득금액,
        names.arg = 서울시_25년도$행정동_코드_명,
        col = 'orange',
        xlab = '행정동명',
        ylab = '소득금액',
        main = '25년도 행정동별 평균 소득')

# 24년 4분기 지출 총금액 조회
서울시_24년도_4분기 = 서울시_상권분석_데이터 %>% filter(기준_년분기_코드=='20244') %>% 
  select(기준_년분기_코드, 행정동_코드_명, 지출_총금액)

par(mfrow=c(1,1))
print(서울시_24년도_4분기)

#1e8 : 1 뒤에 0이 8개 있다. 
# 억 원 단위로 변환
total_money = 서울시_24년도_4분기$지출_총금액 / 1e8

# 박스플롯
barplot(total_money, 
        names.arg = 서울시_24년도_4분기$행정동_코드_명,
        col = 'pink',
        xlab = '행정동명',
        ylab = '지출 금액',
        main = '24년도 4분기 지출_총금액(억 원 단위)')

# 교통지출과 문화지출 간의 상관계수 조회
# 24년도 데이터를 가지고 조회

# 1. 24년도로 필터링
서울시_24년도= 서울시_상권분석_데이터 %>% filter(substr(기준_년분기_코드,1,4) == '2024')  # 24년도만 필터링

# 2. 상관계수 조회
cor_mat = cor(서울시_24년도[, c('교통_지출_총금액', '여가_문화_지출_총금액')])
print(cor_mat)

# 상관계수가 0.3~0.7 중간, 0.7 이상이면 강함, 0.3 미만은 약함

# 박스플롯 구현
# 박스플롯으로 이상치를 초기 확인
# 행정동별 식료품 지출 총금액 박스플롯
boxplot(식료품_지출_총금액 ~ 행정동_코드_명,
        data = 서울시_24년도,
        main = '행정동별 식료품 지출 분포',
        xlab = '행정동',
        ylab = '식료품 지출 총금액',
        col = 'lightgreen')

# 행정동별 유흥지출 박스플롯 조회
boxplot(유흥_지출_총금액 ~ 행정동_코드_명,
        data = 서울시_24년도,
        main = '행정동별 유흥지출 분포',
        xlab = '행정동',
        ylab = 'red')

# 교통지출 많은 곳, 문화지출 많은 곳 지도시각화
library(ggplot2)
library(ggiraph)
library(sf)
shp = 'sig.shp'
korea_map = st_read(shp, quiet = TRUE)  # 지도파일 불러오기
seoul_map = korea_map %>% filter(substr(SIG_CD,1,2)=='11')  # 서울지도만 조회

# 서울시_24년도 행정동 코드 문자로 형변환
# 병합하기 위해서 형 변환
서울시_24년도$행정동_코드 = as.character(서울시_24년도$행정동_코드)

merged_data = inner_join(seoul_map, 서울시_24년도, by = c('SIG_CD' = '행정동_코드')) %>%
  group_by(SIG_CD, 행정동_코드_명) %>% 
  summarise(평균교통지출 = mean(교통_지출_총금액, na.rm = TRUE)) %>% 
  select(SIG_CD, 행정동_코드_명, 평균교통지출) %>% 
  arrange(desc(평균교통지출)) %>%
   head(5)

plot1 = ggplot(merged_data) + 
  scale_fill_gradient(low = '#ececec', high = 'blue', name = '평균교통지출') + 
  geom_sf_interactive(aes(
    fill = 평균교통지출, 
    tooltip = 행정동_코드_명,
    data_id = SIG_CD)) + 
  theme_minimal() + 
  labs(title = '서울시 평균 교통지출', x = '경도', y = '위도')
giraph1 = girafe(ggobj = plot1)
print(giraph1)

# 24년 1분기 
merged2 = inner_join(seoul_map, 서울시_24년도, by =c('SIG_CD' = '행정동_코드')) %>%
  group_by(SIG_CD, 행정동_코드_명) %>%
  summarize(평균문화지출 = mean(여가_문화_지출_총금액, na.rm = TRUE)) %>%
  select(SIG_CD, 행정동_코드_명, 평균문화지출) %>%
  arrange(desc(평균문화지출)) %>%
  head(5)
plot2 = ggplot(merged2) +
  scale_fill_gradient(low = '#ececec', high = 'purple', name = '평균문화지출') + 
  geom_sf_interactive(aes(
    fill = 평균문화지출,
    tooltip = 행정동_코드_명,
    data_id = SIG_CD)) +
  theme_minimal() + 지출', x = '경도', y = '위도')
giraph2 = girafe(ggobj = plot2)
print(giraph2)