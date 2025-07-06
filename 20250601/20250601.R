# <20250601.R 파일 생성>
# 경로확인
# print(getwd())
# 해당 경로에 있는 파일 조회
# print(list.files())
# csv파일 불러오기
# emp=read.csv('emp.csv')
# 불러온 데이터 확인
# View(emp)
# 데이터 확인
# 문제1. 행과 열의 개수 파악
결과1=dim(emp)
# print(결과1)
# dim(dimension: 차원)
# 문제2. 전체 컬럼만 조회
결과2= colnames(emp)
# print(결과2)
# col : 컬럼 + names[이름(들)]
# 문제3. 데이터 상위 1~2행 출력하기
결과3=head(emp,2)
# print(결과3)
# 문제4. 데이터 마지막 3개행을 출력하기
결과4=tail(emp,3)
# print(결과4)
# 문제5. 데이터 타입 확인             #별3개!!!꼭 무조건 반드시 외울 것 
답: str(emp)
# str: structure(구조)

# dyplr(디플리알) -> 데이터 가공(전처리)
# 데이터 전처리가 실무에서 80~90% 하는 일
# 1.설치 필요
# install.package('dplyr')
# 2.설치한 프로그램 가져오기[실무에선 '임포트(import : 가져오다)라고 함.]
library(dplyr)

# 급여(SAL)가 3000 이상인 직원들의 이름(ENAME)과 직업(JOB)을 출력하세요
결과=emp %>% filter(SAL>=3000) %>% select(ENAME,JOB)
print(결과)

# 직업(JOB)별 평균 급여(SAL)를 계산하고 출력하세요.
결과=emp %>% group_by(JOB) %>% summarize(avg_SAL=mean(SAL))
print(결과)
# ~별: group_by
# R은 group_by만 단독으로 사용시 의미없는 결과가 나온다.(그룹핑되지 X)
# 그룹별 평균, 총합, 최댓값, 최솟값, 중앙값, 표준편차 ... 이러한 것들을 구하고 싶다면, summarize(요약하다)도 같이 사용해주어야 함.
# Group_by 다음에 무조건 Summarize를 쓰는 것은 아님. summarize를 써야하는 상황이 있음.

# mean : 평균, n(): 행의 수, sum : 총합
결과=emp %>% group_by(JOB) %>% summarize(avg_SAL=mean(SAL),EMP_COUNT=n(),SOM_SAL=sum(SAL))
print(결과)

# 급여가 2000 이상인 직원들만 필터링 한 후, 부서 번호(DEPTNO)별 직원수를 계산하세요.
결과=emp %>% filter(SAL>=2000) %>% group_by(DEPTNO) %>% summarize(count=n())
print(결과)

# dept 데이터 불러오기, str로 구조확인
dept=read.csv('dept.csv')
str(dept)
View(dept)

# 디플리알 병합(JOIN)
# 두 데이터 프레임을 특정 컬럼을 기준으로 병합.
# 조인결과 = emp %>% inner_join(dept, by = 'DEPTNO')
# View(조인결과)     #dept에 있는 컬럼까지 확인 가능

# 근무지가 'DALLAS'인 직원들의 이름 출력하기
조인결과 = emp %>% inner_join(dept, by = 'DEPTNO') %>% filter(LOC=='DALLAS') %>% select(ENAME,JOB)
print(조인결과)

# slice : 자르다(DBMS=limit)
결과 = emp %>% slice(2,4)
# print(결과)- 2번째 행과 4번째 행 출력

# 첫 번째~세번째 직원 출력
결과 = emp %>% slice(1:3)
# print(결과) - 대부분의 경우 slice는 맨 마지막에 작성. 
# 만약, slice와 arrange(정렬)이 함께 쓰이는 경우 거의 99% slice가 맨 마지막에 온다.

# 문제풀기
# 문제2. 'RESEARCH' 부서에 근무하는 직원들의 이름(ENAME)과 급여(SAL)를 출력하세요.
조인결과 = emp %>% inner_join(dept, by = 'DEPTNO')  %>% filter(LOC=='RESEARCH') 
%>% select(ENAME, SAL)
print(조인결과)

문제4. 각 부서(DNAME)별 직원 수를 계산하고 출력하세요.
조인결과 = emp %>% inner_join(dept, by = 'DEPTNO') %>% group_by(DNAME) %>% summarize(count=n())
print(조인결과)

# 문제8. 'SALES' 부서에서 근무하는 직원들의 이름(ENAME), 커미션(COMM)을 출력하세요.
조인결과 = emp %>% inner_join(dept, by = 'DEPTNO') %>%  filter(DNAME=='SALES') %>% select(ENAME,COMM)
print(조인결과)

# 문제10. 직업(JOB)이 'MANNAGER'인 직원들의 이름(ENAME), 부서명(DNAME, 급여(SAL))을 출력하세요.
조인결과 = emp %>% inner_join(dept, by = 'DEPTNO') %>%

# 문제4. 각 부서(DNAME)별 직원 수를 계산하고 출력하세요.
# arrange : 정렬 , desc : 내림차순
조인결과 = emp %>% inner_join(dept, by = 'DEPTNO') %>% group_by(DNAME) %>% summarize(EMP_COUNT=n()) %>% arrange(desc(EMP_COUNT)) %>% slice(1:2)
print(조인결과)

