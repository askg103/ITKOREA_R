# 박스플롯 : 데이터의 분포를 시각적 표현. 최솟값, 최댓값, 중앙값 등 
# 요약 통계치를 보여줌. (보통 그룹핑할 때 많이 사용)

# 예시) 제조사 별 칼로리 분포를 박스플롯으로 표현
# library(ggplot2)
scereal = read.csv('UScereal.csv')

boxplot = ggplot(scereal, aes(x = mfr, y = calories, fill = mfr)) + 
          geom_boxplot() +
          labs(title = '제조사별 칼로리 분포',
               x = '제조사',
               y = '칼로리') + 
          theme_minimal() +
theme(panel.grid = element_blank()) 
# theme(panel.grid= element_blank()) : 회색배경(바둑판) 제거 
# print(boxplot)

# 제조사(mfr)별 나트륨(sodium) 분포 박스플롯
boxplot = ggplot(scereal, aes(x = mfr, y =sodium, fill = mfr)) +
  geom_boxplot() + 
  labs(title = '제조사 별 나트륨 분포',
       x = '제조사',
       y = '나트륨') +
  theme_minimal() +
  theme(panel.grid = element_blank())
print(boxplot)