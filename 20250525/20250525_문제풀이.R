# emp.csv 불러오기
emp = read.csv('emp.csv')
# 데이터프레임 구조 확인
str(emp)

#<문제풀이>
#  총 20문제 입니다. 1번 ~ 10번까지는 힌트가 제공됩니다.
#문제 1: 급여(SAL)가 3000 이상인 직원들의 이름(ENAME)과 직업(JOB)을 출력하세요.
# 힌트 : filter(), select()
결과 = emp %>% filter(SAL>=3000) %>% select(ENAME,JOB)               
print(결과)

# 문제 3: 직업(JOB)별 평균 급여(SAL)를 계산하고 출력하세요.
# 힌트 : group_by(), summarize()
결과 = emp %>% group_by(JOB) %>% summarize(avg_sal=mean(SAL))
print(결과)

# 문제 5: 고용일(HIREDATE)이 "1981-01-01" 이후인 직원들의 이름(ENAME), 직업(JOB), 고용일(HIREDATE)을 출력하세요.
# 힌트 : filter(), select()
결과 = emp %>% filter(HIREDATE>as.Date('1981-01-01')) %>% select(ENAME,JOB,HIREDATE)
print(결과)

# 문제 6: 부서별(DEPTNO)로 그룹화하여 총 급여(SAL)의 합계를 계산하고 출력하세요.
# 힌트 : group_by(), summarize()
결과 = emp %>% group_by(DEPTNO) %>% summarize('총 급여'=sum(SAL))
print(결과)
                                          

# 문제 7: 커미션(COMM)이 결측치가 아닌 직원들의 이름(ENAME), 커미션(COMM)을 출력하세요.
# 힌트 : filter(!is.na()), select()

결과 = emp %>% filter(!is.na(COMM)) %>% select(ENAME,COMM)
print(결과)

# 문제 11: 부서번호가 20번이고 직책이 MANAGER인 사원 번호와 사원 이름 조회
str(emp)
결과=emp %>% filter(DEPTNO==20 & JOB=='MANAGER') %>% select(empNO, ENAME)
print(결과)

# 문제 12: 각 직업별 사원 수 구하기
결과= emp %>% group_by(JOB) %>% summarize(count=n())
print(결과)

# 문제 13: 부서 번호가 20인 직원들의 직업(JOB)별 평균 급여(SAL)를 계산하세요.
결과= emp %>% filter(DEPTNO==20) %>% group_by(JOB) %>% summarise(평균급여=mean(SAL))
print(결과)

# 문제 14: 급여가 2000 이상인 직원들만 필터링한 후, 부서 번호(DEPTNO)별 직원 수를 계산하세요.
결과= emp %>% filter(SAL>=2000) %>% group_by(DEPTNO) %>% summarise(count=n())
print(결과)

# 문제 15: 커미션(COMM)이 결측치가 아닌 직원들만 필터링한 후, 부서 번호(DEPTNO)별 평균 커미션과 최대 커미션을 계산하세요.
결과=emp %>% filter(!is.na(COMM)) %>% group_by(DEPTNO) %>% summarise(avg_COMM=mean(COMM),max_COMM=max(COMM))
print(결과)

# 문제 16: 직업(JOB)이 "MANAGER"인 직원들만 필터링한 후, 부서 번호(DEPTNO)별 총 급여(SAL)의 합계를 계산하세요.
결과= emp %>% filter(JOB=='MANAGER') %>% group_by(DEPTNO) %>% summarise('총 급여합계'=sum(SAL))
print(결과)

# 문제 17: 고용일(HIREDATE)이 "1981-01-01" 이후인 직원들만 필터링한 후, 직업(JOB)별 평균 급여(SAL)와 직원 수를 계산하세요.
emp$HIREDATE = as.Date(emp$HIREDATE)
str(emp) # 데이터타입을 먼저 확인하고 ! 형변환!

결과 = emp %>% filter(HIREDATE > as.Date("1981-01-01")) %>%
  group_by(JOB) %>% summarise(평균급여 = mean(SAL), 직원수 = n())

#결과= emp %>% filter(mutate(HIREDATE=as.date(HIREDATE) %>% filter(HIREDATE>date('1981-01-01')) %>% group_by(JOB) %>% summarise(avg_sum=mean(SAL), count=n())
print('17번 문제 : ')
print(결과)

# 문제 18: 각 부서별로, 입사일(HIREDATE)이 가장 오래된 직원의 이름과 입사일만 출력
str(emp)
결과= emp %>% group_by(DEPTNO) %>% summarise((HIREDATE) 
# 문제 19: 매니저(MGR)가 없는 직원과, 매니저(MGR)가 있는 직원 중 급여가 2,000 이상인 직원만 추출
# NA는 매니저가 없음->is.na
# 매니저가 있는 직원 ->!is.na
결과=emp %>% filter(is.na(MGR) | (!is.na(MGR) & SAL>=2000))
# 19번 힌트: mutate(근속일수 : 오늘날짜-입사일수) 구해서 근속일수가 가장 큰 것(slice_max)을 구하면 됨.
print(결과)
# 문제 20: 각 직무(JOB)별로, 급여가 상위 2위 이내에 드는 직원의 이름, 급여, 직무만 급여 내림차순으로 출력
결과= emp %>% group_by(JOB) %>% slice_max(SAL,n=2) %>% select(ENAME,SAL,JOB) %>% arrange(desc(SAL))
print(결과)
