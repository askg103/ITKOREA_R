# 산점도
# ggplot2 : 시각화에 주로 쓰이는 프로그램

# ggplot2 설치(설치는 한 번만!)
# install.packages('ggplot2')

# 설치한 ggplot2 불러오기
library(ggplot2)
# library(dplyr)
scereal = read.csv('UScereal.csv')

# 기본 산점도 표현 칼로리 vs 단백질
# aes : aesthetics(미적 속성)의 줄임말
# lm : linear model(선형모델)
# se : 회귀선에서 신뢰구간 표시
plot = ggplot(scereal, aes(x = calories, y = protein)) +  # 산점도 데이터
  geom_point() +                                          # 산점도에 점     
  labs(title = '칼로리 vs 단백질',
       x = '칼로리', y = '단백질') + 
  geom_smooth(method = 'lm', se = TRUE) +                                         # 회귀선 추가
  theme_minimal()                                         # 그래프 배경 깔끔하게 처리

# print(plot)
# 시퀀스
scereal$label = rownames(scereal)
# View(scereal)

# 산점도 그래프에 텍스트 추가
plot = ggplot(scereal, aes(x = calories, y = protein)) +
  geom_point() +                                            
  labs(title = '칼로리 vs 단백질',
       x = '칼로리', y = '단백질') + 
  geom_smooth(method = 'lm', se = TRUE) + 
  geom_text(aes(label = label), hjust=0, vjust=1, size=3, check_overlap = TRUE)
  theme_minimal() 
  # print(plot)
  # check_overlab : 점이 겹칠 경우 일부 라벨을 표시하지 않도록 함.
  
  # 문제)칼로리가 낮은 제품은 Good,  높은 제품은 Bad를 구분하는 새로운 열을 추가
  # 칼로리가 평균보다 낮으면 Good, 아니면 Bad
  # 새로운 열 'grade' 추가
  칼로리_평균 = mean(scereal$calories, na.rm = TRUE)
  # '\n' : 개행(줄바꿈) - 이걸 쓰지 않으면 데이터가 붙어서 나옴.
  cat('칼로리 평균 : ', 칼로리_평균, '\n')
  
  scereal$grade = ifelse(scereal$calories<칼로리_평균, 'Good', 'Bad')
  #print(head(scereal))
  
  # 상관계수
  칼로리_단백질_상관계수 = round(cor(scereal$calories, scereal$protein, use = 'complete.obs'),2)
  cat('칼로리와 단백질 상관계수 : ',  칼로리_단백질_상관계수, '\n')
  
  # Good이면 동그라미, Bad면 세모 표시
  # 16 : 동그라미, 17 : 세모
  # 15 : 네모, 8 : 별, 4 : 엑스(x)

  plot = ggplot(scereal, aes(x = calories, y = protein, shape = grade, color = grade)) +
    geom_point() +                                            
    labs(title = '칼로리 vs 단백질',x = '칼로리', y = '단백질') + 
    scale_shape_manual(values = c('Good' = 16, 'Bad' = 15)) +
    scale_color_manual(values = c('Good' = 'blue', 'Bad' = 'red'))+ 
    geom_smooth(method = 'lm', se = TRUE) + 
    geom_text(aes(label = label), hjust=0, vjust=1, size=3, check_overlap = TRUE) + 
    annotate('text', x = 300, y = 15, 
             label = paste0('단백질 vs 칼로리 상관계수 :', 칼로리_단백질_상관계수), 
             color ='black', 
             size = 4) + 
    theme_minimal()
  print(plot)
  
  # 저장하기
  # ggplot에서는 ggsave라는 명령어로 쉽게 저장할 수 있다.
  # ggsave('myplot.pdf', width = 10, height = 6, dpi = 300)
  