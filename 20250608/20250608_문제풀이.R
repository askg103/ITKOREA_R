# 데이터전처리만 진행해주세요.
# 컬럼명에 괄호가 있는 경우 꼭 ``(백틱)을 써줄 것.
# View(bike)  
str(bike)
# 문제 1: 이동거리(M)가 2000 이상인 데이터 중 해당 대여소명과 이동거리(M), 이용시간(분)만 조회.
결과 = bike %>% filter(`이동거리(M)`>=2000) %>% select(대여소명, `이동거리(M)`, `이용시간(분)`)
# View(결과)
# 문제 2: 대여소 별 이용건 수 조회.
문제2= bike %>% group_by(`대여소번호`) %>% summarize(이용건수_합계=sum(이용건수, na.rm=TRUE))
View(문제2)
# 문제 3: 일일회원과 정기회원 이용 건 수, 평균 이용시간 조회. 단, 일일회원권 중 비회원은 제외
회원타입= bike %>% group_by(대여구분코드) %>% summarize(CNT = sum(이용건수))
print(회원타입)
문제3 = bike %>% filter(대여구분코드!='일일권(비회원)') %>% 
  group_by(대여구분코드) %>% summarize(총이용건수 = sum(이용건수, na.rm = TRUE),
                                 평균이용시간 = mean(`이용시간(분)`,na.rm = TRUE))
View(문제3)
# 문제 4: 탄소량이 0.8 이상인 이용 건수는 몇 건인지 조회.
# n() : 행의 수
문제4= bike %>% filter(탄소량 >= 0.8) %>% summarize(CNT= n())
# print(문제4)

# 문제 5: 연령대별로 평균 이동거리(M) 조회.
문제5 = bike %>% group_by(연령대코드) %>% summarize(평균거리=mean(`이동거리(M)`))
# View(문제5)
# 문제 6: 연령대별로 이용건수의 합과 평균 운동량을 구한 뒤, 운동량 평균이 가장 높은 연령대 조회.
# arrange : 정렬
# desc : 내림차순 
# slice : 자르다.(가장 ~한 한 사람만 구하거나 두사람만 구할 때) 공식: slice(n)
문제6 = bike %>% group_by(연령대코드) %>% summarize(이용건수합 = sum(이용건수), 평균운동량=mean(운동량)) %>% arrange(desc(평균운동량)) %>% slice(1)
# View(문제6)

# 문제 7: 대여소명에 "역"이 포함된 대여소에서 발생한 총 운동량의 합 조회.
# 예제)
text = c('apple', 'banana', 'grape', 'bread')
# 'ap'가 들어간 단어 찾기
# grep(잡다) logical(TRUE/FALSE) : 직역하면 TRUE/FALSE를 잡다
# print(grepl('ap',text))

문제7= bike %>% filter(grepl('역', 대여소명)) %>% summarize(총운동량 = sum(운동량, na.rm = TRUE))
print(문제7)

# 문제 8: 10대 여성 회원의 평균 운동량, 평균 이동거리 조회. 단, 평균 운동량으로 내림차순 할 것
# 생략

# 문제 9: 운동량을 데이터 스케일링 min-max로 변환한 scaled_운동량 컬럼을 추가 0.8 이하인 회원 이동거리 사분위수 출력
min_운동량 = min(bike$운동량)
# print(min_운동량)    -결과 : 0
max_운동량 = max(bike$운동량)
# print(max_운동량)    -결과 : 1042.23
# min_max 공식 : (기존값-최솟값) / (최댓값-최솟값)
min_max_결과 = (bike$운동량-min_운동량) / (max_운동량-min_운동량)
print(min_max_결과)
bike$scaled_운동량= min_max_결과
print(bike$scaled_운동량) 
View(bike)
운동량_0.8_이하_회원 = bike %>% filter(scaled_운동량 <=0.8)
View(운동량_0.8_이하_회원)
# 사분위수 출력
# quantile : 사분위수
 print(quantile(운동량_0.8_이하_회원$`이동거리(M)`))   

# 문제 10. 연령대 별 운동량과 이동거리의 상관관계 조회.
 # use = 'complete.obs' : 결측값이 있을 때 결측값을 제외하고 계산. 
 # 데이터가 방대한 경우 일일히 NA값이 있는지 찾아보기 힘드니까 그냥 예방 차원에서 기본적으로 같이 적어줌
문제10 = bike %>% group_by(연령대코드) %>% summarize(상관계수 = cor(운동량, `이동거리(M)`, use = 'complete.obs'))
print(문제10)

