# 현재 디렉토리의 파일 목록 출력
print(list.files())

# emp.csv파일 불러오기
emp=read.csv('emp.csv')
# 잘 불러왔는지 확인
# View(emp)

# 여기까지 만약 안 되면 아래 방법으로 해볼 것
# 폴더(디렉토리) 변경
# setwd('C:/Users/admin/Desktop/r_workspces/data') # 입력
# 현재 디렉토리 경로 확인
# print(getwd()) 
# 현재 디렉토리의 파일 목록 출력
# print(list.files())

# 문제풀이
# 문제 1: 행과 열의 개수 파악
print(dim(emp))
# 문제 2: 전체 칼럼만 조회
print(colnames(emp))
# 문제 3: 데이터 상위 1~4행 출력하기
print(head(emp,4))
# 문제 4: 데이터 마지막 3행을 출력하기
print(tail(emp,3))
# 문제 5: 데이터 타입 확인(가장 중요!!!!이건 꼭 외우기)
str(emp)

# dplyr(디플리알) : Data Frame Plier의 줄임말. 직역하면 '데이터프레임을 다루는 공구' 
# 실무에서 자주 사용되고, 특히 대규모 데이터셋에서 빠른 속도를 제공.

# 설치 명령어
# install.packages('dplyr')

# 설치된 dplyr 불러오기
# library(dplyr)

# 문제1. 급여가 3000 이상인 사원 조회
# %>%(실무에선, 람다식 표현) : 방향을 가리킴.(화살표 기능)
급여3000 = emp %>% filter(SAL>=3000)
print(급여3000)

# 문제2. 급여가 3000 이상인 사원 이름, 급여, 사원번호 조회
급여3000이름=emp %>% filter(SAL>=3000) %>% select(ENAME,SAL,empNO)
print(급여3000이름)

# 문제3. 사원 직책(JOB)이 MANAGER인 사원의 이름, 직책, 부서번호, 급여 조회
MANAGER사원= emp %>% filter(JOB=='MANAGER') %>% select(ENAME,JOB,DEPTNO,SAL)
print(MANAGER사원)

# 새로운 열 추가&수정
# mutate : 변화하다
# 새로운 열 이름 : TOTAL_COMM 
# SAL+100 : 직원급여+100
결과=emp %>% mutate(TOTAL_COMM=SAL+100)
# View(결과)

# 급여와 커미션의 합계를 TOTAL_COMM에 수정
결과=emp %>%mutate(TOTAL_COMM=SAL+ifelse(is.na(COMM),0,COMM))
# View(결과)

# group by
# 데이터를 특정 기준으로 묶어 그룹화함.
# 단, group by 단독으로는 못 쓰고, summarize(요약하다)와 함께 사용.=내가 grouping한 것을 요약하겠다.

# 직책별(JOB)별 평균급여
group_result=emp %>% group_by(JOB) %>% summarise(avg_SAL=mean(SAL))
print(group_result)
# View(group_result)

# 부서번호별(DEPTNO)별 평균급여
dept_result=emp %>% group_by(DEPTNO) %>% summarise(avg_SAL=mean(SAL))
# print(dept_result)

# 부서별(DEPTNO) 최소, 최대, 평균 급여 조회
dept_result=emp %>% group_by(DEPTNO) %>% summarise(min_SAL=min(SAL),max(SAL),mean(SAL))
print(dept_result)

# 직책별 직원수 조회
# n() : 각 그룹의 행 개수 계산
job_count=emp %>% group_by(JOB) %>% summarise(count=n())
print(job_count)

# 정렬(arrange : 정렬하다, 배열하다)
# arrange : 오름차순
job_count=emp %>% group_by(JOB) %>% summarise(count=n()) %>% arrange(count)
print(job_count)

# 내림차순
# desc : Descending(내림차순)
job_count=emp %>% group_by(JOB) %>% summarise(count=n()) %>% arrange(desc(count))
print(job_count)

# 급여 기준으로 내림차순 정렬
급여내림차순=emp %>% arrange(desc(SAL))
print(급여내림차순)

# 급여 기준으로 내림차순 정렬(급여하고 이름만 출력)
# 항상 정렬은 공식에서 마지막에 진행
급여내림차순= emp %>% select(ENAME,SAL) %>% arrange(desc(SAL))

# 부서별 최대 급여 직원 조회
# 문제에 '~별'이 들어가면 Group by.
# summarise는 통계 구할 때 주로 사용하므로 여기에선 쓰지 않음.
# slice=자르다
# n : 줄(행)을 의미. 각 부서별로 급여 최댓값 1명만 조회해야 하니까 n=1.
# 즉 'n=2'로 바꾸면 각 부서별로 급여가 가장 많은 사람을 2명씩 조회하게 됨.
부서별급여킹=emp %>% group_by(DEPTNO) %>% slice_max(SAL,n=2)
# print(부서별급여킹)

# 박스플롯
# boxplot(emp$SAL ~ emp$DEPTNO, main='부서별 급여', xlab='부서번호', ylab='급여', col=c('orange','green','lightblue'))


# 문제1. 근속연수일 컬럼 추가

# 오늘날짜 = Sys.Date()

# 데이터프레임 데이터타입 확인 
str(emp)
# 문자 데이터를 날짜데이터로 형변환
방법1. emp=emp %>% mutate(HIREDATE = as.Date(HIREDATE))
방법2. emp$HIREDATE = as.Date(emp$HIREDATE)
# 다시 데이터타입 확인
str(emp)
# difftime이 무슨 의미라고 했지?
# mutate : 컬럼 추가 또는 수정할 때 사용
결과 = emp %>% mutate(근속일= difftime(오늘날짜, HIREDATE))
View(결과)

# 문제2. 급여가 2000 이상인 직원 중 세후 급여(SAL_TAX) 컬럼 추가
# 단, 사원 이름,급여만 조회, 급여 내림차순
# 3.3% 원천징수

결과=emp %>% filter(SAL>+2000) %>% select(ENAME, SAL) %>% mutate(SAL_TAX=SAL * 0.967) %>% arrange(desc(SAL))
# print(결과)

# 문제3. 부서번호가 30인 직원 중 이름, 직업, 부서번호만 조회. 단, 이름 오름차순 정렬
결과 = emp %>% filter(DEPTNO==30) %>% select(ENAME, JOB, DEPTNO) %>% arrange(ENAME)
# print(결과)

# 문제4. 1981-01-01 이후 입사한 직원의 이름, 입사일, 급여, 근무연수 조회
# 먼저 데이터타입 확인 후 HIREDATE(입사일)의 데이터타입이 DATE인지 확인\
str(emp)
결과 = emp %>% filter(HIREDATE > as.Date('1981-01-01')) %>% select(ENAME, HIREDATE, SAL)%>%
  mutate(근무연수=as.numeric(오늘날짜-HIREDATE) /365)      #날짜->숫자
print(결과)