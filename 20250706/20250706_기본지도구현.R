# install.packages('sf')   - 설치는 딱 한 번만!
# 공간 데이터를 처리하고 시각화하기 위한 패키지(프로그램)
library(sf)
library(ggplot2)

# R 경로확인
setwd('C:/Users/admin/Desktop/r_workspaces/data') #강제 경로 설정
#print(getwd())

# SHP파일 불러오기
# SHP파일? 공간데이터를 저장하고 표한하는 데 사용하는 파일.
shp = 'sig.shp' # 파일이름
korea_map = st_read(shp, quiet = TRUE) # 지도파일 불러오기
# print(korea_map)

library(dplyr)
# substr : 특정 위치의 부분 문자열 출력
# 서울은 11로 시작
seoul_map = korea_map %>% filter(substr(SIG_CD,1,2) == '11')


result = ggplot(seoul_map) +
  geom_sf(fill = 'white', color = 'black') + # 흰색 채우기, 검은색 경계선
  labs(x = '경도', y = '위도', title = '서울시 행정구역') +
  coord_sf() + 
  theme_minimal()# 지도 비율 유지
print(result)