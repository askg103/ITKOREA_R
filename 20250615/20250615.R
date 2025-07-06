# library(dplyr)
# Screal.csv 파일 불러오기
scereal = read.csv('UScereal.csv')
# View(scereal)

# 상관간계 시각화(매우 많이 씀!!)
# cor : (correlation)의 약자로 '상관계수'라는 뜻.

# 설탕과 칼로리의 상관관계
설탕과칼로리_상관관계 = cor(scereal$sugars, scereal$calories, use = 'complete.obs')
cat('설탕과 칼로리 상관관계 : ', round(설탕과칼로리_상관관계, 2), '\n')
# complete.obs : 결측값 처리(is.na)
# round : 반올림 처리
# 결과값 : 0.5 -0.5는 보통의 상관관계를 의미. 즉, 상관이 보통 정도로 있다는 뜻.
# -1 ~ 1: -1(음의 관계,=반비례), 0(관계없음), 1(양의 관계,=정비례)
# 상관계수 해석 : 0.3 이하 => 약한 관계, 0.3 ~ 0.7 => 중간, 0.7 이상 => 강한관계

# install.packages('corrgram')
library(corrgram)

테스트 = scereal %>% select(calories, protein)
print(head(테스트))

corrgram(테스트,     # 그래프에 들어갈 데이터
         main= '칼로리, 단백질, 지방 상관관계 행렬',   # 그래프 제목
         lower.panel = panel.shade,      # 아래쪽 색상으로 상관관계 표현
         upper.panel = panel.cor,         # 위쪽 상관관계 수치 표현
         diag.panel =  panel.minmax       # 대각선은 최솟값, 최댓값 표현
)

# Scereal 데이터에서 제조사(mfr) 별로 평균 칼로리(calories), 평균 단백질(protein), 
# 평균 식이섬유(fibre)를 구하고, 이 세 변수로 상관관계 행렬을 만들어 corrgram으로 시각화하시오

제조사별_데이터 = scereal %>% group_by(mfr) %>% summarize(cal_avg = mean(calories, na.rm=TRUE), pro_avg = mean(protein, na.rm=TRUE), fi_avg = mean(fibre, na.rm= TRUE))
# print(제조사별_데이터)
corrgram(제조사별_데이터,
         main = '제조사별 평균 칼로리, 단백질, 식이섬유 상관관계',
         lower.panel = panel.shade,            -# 아래쪽 색상으로 상관관계 표현
         upper.panel = panel.pie,              -# 위쪽 상관관계 수치 표현, panel.pie : 원형 표 생성
         diag.panel =  panel.minmax)           -# 대각선은 최솟값, 최댓값 표현

# 데이터에서 나트륨(sodium), 식이섬유(fibre), 복합탄수화물(carbo), 
# 칼륨(potassium) 컬럼을 선택하고, 결측치가 아닌 데이터만 corrgram으로 
# 상관관계 시각화하시오.
결측치가_아닌_데이터 = scereal %>% filter(!is.na(sodium) & !is.na(fibre) & !is.na(carbo) & !is.na(potassium)) %>%
  select(sodium, fibre, carbo, potassium)
# print(결측치가아닌데이터)
# !is.na : 결측값(NA, 누락된 데이터)이 아니라면(별500개!!!!!)

corrgram(결측치가_아닌_데이터,
         main = '나트륨, 식이섬유, 복합탄수화물, 칼륨 상관관계',
         lower.panel = panel.shade,     
         upper.panel = panel.cor,         
         diag.panel =  panel.minmax) 



