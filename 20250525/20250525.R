# 벡터 복습
# 1. 벡터는 비슷한 데이터를 한 줄로 모아놓은 상자
# 2. 벡터를 생성할 때는 c()라는 문법 사용. 'c'는 'combind'의 약자.
# 3. 벡터에서 값을 꺼낼 때는 []를 사용.

colors=c('red','blue','green')            #벡터 생성

print(colors[1])

print(colors[c(1,3)])

# 별5개! 벡터와조건문 활용- 시험 자주 출제
# ifelse: 만약~라면(조건문)
x=c(1,2,3,4,5)
result=ifelse(x%%2==0,'짝수','홀수')
print(result)

# 별100개!!!!데이터프레임
# 가로(행)와 세로(열)가 있는 테이블\

#벡터 생성
id=c(1,2,3)
name=c('김길동','홍길동','박길동')
age=c(20,30,40)
# 데이터프레임 생성
df=data.frame(id,name,age)
print(df)
# 테이블형태로 출력
# View(df)


# EMPNO : 사원번호
# ENAME : 사원명
# JOB   : 직책
# MGR   : 사수번호
# HIREDATE : 입사날짜
# SAL : 급여
# COMM : 보너스(커미션)
# DEPTNO : 부서번호


emp = data.frame(
  empNO = c(7369, 7499, 7521, 7566, 7698, 7782, 7788, 7839, 7844, 7900),
  ENAME = c("SMITH", "ALLEN", "WARD", "JONES", "BLAKE", "CLARK", "SCOTT", "KING", "TURNER", "ADAMS"),
  JOB = c("CLERK", "SALESMAN", "SALESMAN", "MANAGER", "MANAGER", "MANAGER", "ANALYST", "PRESIDENT", "SALESMAN", "CLERK"),
  MGR = c(7902, 7698, 7698, 7839, 7839, 7839, 7566, NA, 7698, 7788),
  HIREDATE = as.Date(c("1980-12-17", "1981-02-20", "1981-02-22", 
                       "1981-04-02", "1981-05-01", "1981-06-09",
                       "1982-12-09", "1981-11-17", "1981-09-08",
                       "1983-01-12")),
  SAL = c(800, 1600, 1250, 2975, 2850, 2450, 3000, 5000, 1500, 1100),
  COMM = c(NA, 300, 500, NA, NA, NA, NA, NA, NA, NA),
  DEPTNO = c(20, 30, 30, 20, 30, 10, 20, 10, 30, 20)
)
# View(emp)
# 데이터프레임 조회

# 별3개!데이터프레임 타입 확인 -ADSP 1,2번 문제로 나옴.
str(emp)     #str: structure(구조)의 줄임말
# 1행부터 6행까지 출력
print(head(emp))
# 1행부터 2행까지 출력
print(head(emp,2))
# 아래에서부터 6행까지 출력
print(tail(emp))
# 아래에서부터 2행까지 출력
print(tail(emp,2))
# 전체 컬럼 조회
print(colnames(emp))
# 행과 열 개수 조회
print(dim(emp))             #dim(dimension):'차원'이라는 뜻
# 결과: 10행 8열

# 데이터프레임 특정 열 조회
# 사원 이름만 조회
cat('사원이름 : ',emp$ENAME,'\n')
# 부서 번호만 조회
cat('부서 번호 : ',emp$DEPTNO,'\n')

# 새로운 열 생성
emp$bonus=100

# View(emp)

# 데이터프레임 ->엑셀로 전환
# ,file='emp.csv' : 저장할 파일 이름
# row.names=FALSE : 행 번호가 파일에 저장되지 않음
# write.csv(emp,file='emp.csv',row.names=FALSE)

# 집계함수
# 엑셀 총합,평균,최댓값,최솟값...
# R도 엑셀처럼 통계 내는 도구 존재

x=c(10,20,30,40,50)
# 최솟값
최솟값=min(x)
# 최댓값
최댓값=max(x)
# 총합
총합=sum(x)
# 평균
평균=mean(x)
# 표준편차
# sd: Standard Deviation
표준편차=sd(x)

# 데이터프레임에서 특정 열(벡터) 조회
# cat을 이용해서 emp의 급여만 조회         cat 공식:cat(제목, 테이블이름$구하고자 하는 데이터. '\n')
cat('사원급여 : ',emp$SAL,'\n')

# 사원 급여 평균 구하기
cat('사원 급여 평균 : ',mean(emp$SAL),'\n')

# 사원 급여 총합
cat('사원 급여 총합 : ',sum(emp$SAL),'\n')

# 사원 급여 최댓값
cat('사원 급여 최댓값 : ',max(emp$SAL),'\n')

# 사원 급여 최솟값
cat('사원 급여 최솟값 : ',min(emp$SAL),'\n')

# 사원 급여 중앙값
cat('사원 급여 중앙값 : ',median(emp$SAL),'\n')

# 사원 급여 표준편차
cat('사원 급여 표준편차 : ',sd(emp$SAL),'\n')

# COMM : 커미션의 총합
# NA(결측값)이 있으면 집계함수를 써도 NA밖에 안 나옴.
# 이런 경우 odit나 na.rm으로 NA를 제거해주거나 NA를 제외한 나머지값으로라도 집계함수를 실행해야 함.\
# rm:'remove'의 약자. rm 공식: print(실행하고자 하는 집계함수(테이블이름$집계하려는 컬럼명,na.TRUE))
cat('COMM의 총합 : ',emp$COMM,'\n')
print(sum(emp$COMM,na.rm=TRUE))

# 제어문을 활용한 열 생성
# 사원급여가 3000 이상이면 High, 나머지는 Low입니다.
emp$Grade=ifelse(emp$SAL>=3000,'High','Low')
# View(emp)

# 기존 열 수정
emp$bonus=emp$bonus*2
# View(emp)

# 사원 근속일 컬럼 추가하기
# 콤마, 대문자, 오타, 괄호 주의!
# 단, 해당 열(벡터)가 데이터타입이 날짜형(as.Date)이어야 함.
print(Sys.Date())
cat('사원 근속일 : ',difftime(Sys.Date(),emp$HIREDATE),'\n')

print(Sys.Date())
cat('사원 근속일 : ',difftime(Sys.Date(),emp$HIREDATE),'\n')

# 데이터프레임 행 조건 필터링
# 문법: 데이터프레임[행조건,열조건]

# 문제. 사원 급여가 2000 이상인 사원 전체 조회
emp[emp$SAL>=2000,]
emp[emp$SAL>=2000,]

# 문제2. 사원 급여가 2000 이상인 사원의 이름과 급여만 조회
결과=emp[emp$SAL>=2000,c('ENAME','SAL')]
# print(결과) 
결과=emp[emp$SAL>=2000,c('ENAME','SAL')]
# print(결과)
# 문제3. 직책(JOB이 SALESMAN인 사원의 이름과 직책, 입사날짜 조회)
# == : 비교
결과2=emp[emp$JOB=='SALESMAN',c('ENAME','JOB','HIREDATE')]
# print(결과2)
결과2=emp[emp&JOB=='SALESMAN',c('ENAME','JOB','HIREDATE')]
# print(결과2)
# 문제4. 급여가 1500이상 3000 이하인 직원 조회
결과3=emp[emp$SAL >= 1500 & emp$SAL <= 3000,]
print('문제4 : ')
print(결과3)
결과3=emp[emp$SAL>=1500 & emp$SAL<=3000,]
print(결과3)

# 문제5. 커미션(COMM)을 받은 직원조회(NA제외)
# is.na() : na니?
x=c(1,2,NA,4)
print(is.na(x))
# !:부정,반대
print(!is.na(x))
# COMM이 NA가 아닌 사원 조회
print(emp[!is.na(emp$COMM),c('ENAME','COMM')])

print(emp[!is.na(emp$COMM),c('ENAME','COMM')])
# '조회하라'는 문제가 나오면 무조건 []로 묶을 것. 조회하고자 하는 테이블 명[조회하고자 하는 테이블명$조건, 조건을 충족할때 보려는 컬럼]
