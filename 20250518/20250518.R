# 2025. 5. 18. 데이터분석 수업 1강

# ctrl+s : 저장, 습관적으로 저장할 것. 입력하면 무조건 저장!
# ctrl+shift+s : 실행

`print('안녕하세요 R을 시작합니다.')

# 주석
# 주석은 프로그래밍에 있어서 '메모'하는 목적을 ㅗ상용됩니다.

print('Hello World') #단일 주석

# ctrl + shift + c : 다중 주석 처리
# 주석은 단순히 코드 설명만 하는 게 아닙니다.
# 작성자, 날짜, 수정이력 등 다양한 정보를 포함시킬 수 있습니다.
# 
# Author : 현상원 
# Date : 2025-05-18
# Comment : 프로그램 테스트
# 실무에서는 작성자, 코드작성날짜 등 상세히 입력한다.
# Why? 코드는 팀으로 프로젝트를 하기 때문에.



# 출력하기
# 첫번째 방법 print
print('hello')

# 두번째 방법 cat
# cat 'concaternate'의 줄임말로 '연결하다', '이어 붙이다'라는 뜻.
cat('hello', 'world','/n')
# /n : 개행(엔터), 항상 꼭 해줘야 함.
# 이런 식으로 콤마(,)를 기준으로 문자를 이어붙인다. 


# 자료형
# 우리가 사용하는 데이터는 문자 아니면 숫자.
# 숫자형 데이터 출력
print(35) 
# ctrl + enter : 코드 한 줄 실행
# 문자형 데이터 출력
print(홍길동) # - ctrl + enter 치면 에러 발생
# 왜 에러 발생? R이 문자를 인식 못 한 것이 아니라 문자를 입력할 때 약속한 조건이 있기 때문.
# 컴퓨터가 문자로 인식하게 하려면 작따 or 큰따를 써줘야 함.
print('홍길동')

# 인간이 정보를 주고받을 때 숫자와 문자로 충분, 하지만 컴퓨터는 한 가지 자료형을 더 필요로 함.
# 그 자료형을 '논리형'이라고 한다.
'논리형'은 TRUE 혹은 FALSE를 의미한다.
# 주의할 점: 논리형에서 TRUE, FALSE는 소문자는 인식 X, 대문자만 인식 함.

# 참
print(TRUE) 
# 거짓
print(FALSE)

# 범주형 데이터타입
# 범주형? 항목으로 구분된 데이터
# 수치적은 계산보단 분류와 그룹화에 적합.

# 범주형 데이터 타입
# 1. 혈액형 2. 성별 3. 고객만족도(매우만족, 만족, 보통...)

print(factor(c('A','B','O','A/B'))) # 범주형 데이터 출력


#특수 데이터형(R에서 더 특히 중요)
# R에서 특수 데이터형이란, 데이터 분석과정에서 자주 마주치는 특별한 의미를
# 가진 값들을 의미.

# 1. *****별 5개만큼 중요!!! 시험에 무조건 나옴.
# NA : 결측값(missing value), 데이터가 있어야 할 자리에
#  값이 빠져 있음을 의미.(즉, 누락된 데이터)
print(NA) # 결측값 출력

# 2. NULL : 비어 있는 값(데이터 자체가 존재하지 않음을 의미)
print(NULL) # NULL 출력
# NULL은 Python이나 C 다른 언어에서 중요함. 
# R에서 중요한 건 NULL 보단 NA가 훨씬 중요함. 
# NA는 시험에서 무조건 나옴!!

# 자료형(문자형,숫자형,논리형) 확인
# R에서 자료형을 확인할 때는 typeof을 사용.
print(typeof(30)) #double(실수, mistake 아님)
# double(실수)가 나오는 이유?
# R에서 숫자를 기본적(디폴트)으로 실수로 인식함.
print(typeof(30L)) #integer(정수)
print(typeof('apple')) #character(문자)
print(typeof(TRUE)) #logical(논리)
print(typeof(NULL)) #NULL('값이 없다')
print(typeof(NA)) #안 나옴. 누락된 것이기 때문(결측값)


# 별3개. 중요!!)데이터 타입 변환
# R에서 데이터 타입 변환(형 변환)은 원하는 자료형으로 바꾸는 작업
# 실무에서 엄청 많이 사용.

# 숫자를 문자로 변경
print(as.character(123))
# 문자를 숫자로 변경
print(as.numeric('123'))
# 문자를 숫자로 변경할 때 주의할 점?
오로지 숫자여야 함. 문자와 숫자가 섞여있으면 에러가 남. 완벽한 숫자여야 함.
print(as.numeric('123'))

# 숫자에서 논리형으로 변경
print(as.logical(0)) #FALSE
print(as.logical(1)) #TRUE
# 0은 FALSE가 나오고 1은 TRUE가 나오는 이유?
# 컴퓨터는 0을 거짓(FALSE), 1을 참(TRUE)으로 이해함.

# 변수: 값이 변할 수 있는 상자, 그 상자에는 '자료형'이 들어감.

# 저금통이라는 상자(변수)에 1000이라는 숫자형 대입. 값이 왼쪽에서 오른쪽으로 대입
저금통 = 1000
print(저금통)
# 2000 출력
저금통2 = 2000
저금통2=5000 # 기존의 2000은 없어지고, 5000값이 출력. 
# 프로그래밍은 왼쪽에서 오른쪽으로 대입하고, 위에서 아래로 해석한다.(매우 중요)
print(저금통2)
# '=' : 대입연산자
# '저금통' : 변수
# a라는 변수에 apple이라는 문자형을 대입함.
a='apple'
a='banana'
print(a)

# apple이 아니라 banana가 나올 수 있게 만들어보세요.
a='apple'
a='banana'
print(a)

# 연산자(+,-,*,/)
num=3+2
print(num)

num=5-2
print(num)

num=4*2
print(num)

num=10/2
print(num)
# ** : 지수
num=2**3
print(num)

# 비교연산자
# 5는 2보다 크다=TRUE로 출력
print(5>2)
# 3은 2보다 작지 않다=FALSE로 출력
print(3<2)
# 5는 5보다 크거나 같다=TRUE로 출력
print(5<=5)
# 3은 3과 같다=TRUE로 출력
print(3==3)
# 3과 2는 다르다,'!'은 프로그래밍에서 '부정'을 의미한다.
print(3!=2)

# 논리연산자
print((3>2)&(5>4)) # &: AND연산자, 두 조건이 모두 참이면 참(TRUE)을 출력
print((3>2)|(5>4)) # |: OR연산자, 두 조건 중 하나만 참이면 참(TRUE)을 출력
print(!(3>2)) # 3은 2보다 크지 않다.느낌표(부정), False가 출력
# (50+30)/(10-2)*3
result = (50+30) / (10-2) * 3

# 별 50개 매우 중요!!!!!!!
# 벡터(Vector)
# 벡터는 여러 개의 값을 한 줄로 쭉 늘어 놓은 상자
# 동일한 데이터를 쭉 늘어놓은 것(1차원 배열(Array))

# 예) 친구 5명의 시험점수를 입력한다고 가정해보겠습니다.
# c() : combind(묶다, 결합된)의 약자
점수=c(90,85,70,100,95) #벡터로 친구 5명의 점수를 한 번에 입력함.
print(점수)

# 문자 벡터
색깔=c('red','blue','green')
print(색깔)

# 벡터에서 값 꺼내기
# 벡터에서 특정값을 꺼낼 때는 대괄호[]를 사용.
# 예를 들어 점수 벡터에서 2번째 친구의 점수를 알고 싶다면?
print(점수[2]) #85출력 

# 여러 값 꺼내기
print(점수[c(1,3,5)])
# 연속된 숫자를 벡터로 만들기
# 1부터 10까지 숫자를 벡터로 한번에 만들어보기
숫자=1:10 #연속된 숫자를 생성할 땐 ':' 기호 사용.
print(숫자)

# 별3개, 벡터 형 변환
숫자벡터=as.numeric(c('1','3','5')) # 문자열 벡터를 숫자형 벡터로 변환
print(숫자벡터)
# 왜 문자를 순자로 변환할까? 그냥 쓰면 되는데..
# 왜냐하면, 순자로 변환해야 연산이 가능하기 때문.
# 숫자를 문자로 형변환
문자열벡터=as.character(c(1,2,100)) # 숫자형 벡터를 문자형 벡터로 변환
print(문자열벡터)
# numieric과 character은 무조건 외울 것. 실무에서 가장 많이 씀.

# 벡터연산
# 벡터는 수학적 연산이 가능하다
x=c(2,4,6) 
y=c(1,2,3)
z=x+y
print(z) #3,6,9 출력.괄호 안에 있는 것을 더하는게 아니라 위아래로 더함.

# 벡터 연습문제

1. 숫자 10, 20, 30으로 이루어진 벡터 num_vec을 선언하세요.
(힌트: c() 함수를 사용하세요.)

num_vec=c(10,20,30)
print(num_vec=c)

2. 문자형 벡터 fruit_vec이 "apple", "banana", "orange"로 선언되어 있을 때, 두 번째 값을 출력하는 코드를 작성하세요.

fruit_vec = c("apple", "banana", "orange")
print(fruit_vec[2])

3. 1부터 5까지의 정수로 이루어진 벡터 seq_vec에서 1, 3, 5번째 값을 한 번에 출력하는 코드를 작성하세요.

seq_vec = 1:5
print(seq_vec[c(1,3,5)])

4. 숫자형 벡터 num_char가 문자형(c("1", "2", "3"))으로 선언되어 있을 때, 이를 숫자형 벡터로 변환하는 코드를 작성하세요.

num_char = c("1", "2", "3")
num_char = as.numeric(c('1','2','3'))
print(num_char)

5. 논리형 벡터 logic_vec이 c(TRUE, FALSE, TRUE)로 선언되어 있을 때, 이를 문자형 벡터로 변환하는 코드를 작성하세요.

logic_vec = c(TRUE, FALSE, TRUE)
logic_vec =as.character(c(TRUE, FALSE, TRUE))
print(logic_vec)

# 별3개!벡터 조건문
# 조건문,'문'=문장을 의미
# 즉, 조건이 들어있는 문장.
# 특정 조건이 만족하면 한 가지 일을 하고, 아니면 다른 일을 하게 하는 명령어
# ~만약에 ~라면
나이=25
if(나이>20){# 나이가 20보다 크다면?
  print('구매할 수 있습니다.') #조건이 만족하면 실행
} else{
  print('구매할 수 없습니다.') #아니면 해당 문장 실행
}-R에서는 이 공식은 별로 사용하지 않으므로 그냥 이런 게 있다 정도만 알고 있어도 됨.

# R은 벡터와 조건문을 자주 사용
x=c(1,2,3,4,5)

# 짝수만 출력하고 싶을 때 #2,4
# # x %% 2==0 : 벡터의 원소들을 2로 나눴을 때 나머지가 0이라면
# %% : 나머지값 구하기
짝수=ifelse(x %% 2==0, '짝수','홀수')
print(짝수)
# 점수가 90점 이상인 학생은 A, 아니면 B
점수=c(80,90,100,90,70)
A학점=ifelse(점수>=90,'A','B')
print(A학점)

# 80점에서 90점 사이인 학생은A, 아니면 B
점수=c(80,90,100,90,70)
A학점=ifelse(점수>=80&점수<=90, 'A','B')
print(A학점)

연습문제
1. 1부터 10까지의 정수 벡터 num_vec에서 각 값이 짝수면 "even", 홀수면 "odd"라는 문자 벡터를 만드세요.

num_vec=c(1:10)
결과=ifelse(num_vec%%2==0,'even','odd')
print(결과)

2. 점수 벡터 score_vec = c(85, 42, 77, 64, 58)에서 60점 이상은 "PASS", 미만은 "FAIL"로 표시하는 문자 벡터를 만드세요.
score_vec=c(85,42,77,64,58)
결과=ifelse(score_vec>=60,'PASS','FAIL')
print(결과)

3. 몸무게 벡터 weight = c(69, 50, 55, 71, 89, 64, 59, 70, 71, 80)에서 60~70kg 사이 값만 추출하여 새로운 벡터로 만드세요.
weight = c(69, 50, 55, 71, 89, 64, 59, 70, 71, 80)
결과=weight[weight>=60&weight<=70]
print(결과)

# 별3개!문자열 처리
# R에서 특정 문자를 바꾼다거나 잘라내기 같은 기능이 필요할 때 사용
# 다음의 3개는 꼭 외울것!
# 1.substr : 특정 위치의 부분 문자열을 `추출`
# 2.strsplit : 특정 구분자를 기준으로 나누어 `분리`
# 3. gsub : 다른 문자로 `대체`

# substr
text='안녕하세요, 오늘은 R을 배워요.'
결과=substr(text,1,5) #1번째부터 5번째까지만 조회
print(결과)
결과=substr(text,3,6) #3번째부터 6번째까지만 조회
print(결과)

# strsplit
text='홍길동@gmail.com'
결과=strsplit(text, split='@') #split:쪼개다, 분리하다
print(결과) #'@'을 기준으로 문자를 나눈다.
# gsub
text='고양이가 방에서 놀고 있어요'
결과=gsub('고양이','강아지',text)
print(결과)

text='15000$'
# gsub으로 달러($)기호를 제거하고 제거한 문자를 숫자로 형변환
결과=gsub('\\$','',text)
print(as.numeric(결과))

# 같이 연습문제
1번. substr() 활용 문제
# 학생 이름이 벡터로 주어졌습니다. 각 이름의 첫 글자만 뽑아서 새로운 벡터로 만들어 보세요.
names = c("민수", "지영", "철수", "영희")
# 각 이름의 첫 글자만 추출하는 코드를 작성하세요.

names = c("민수", "지영", "철수", "영희")
결과=substr(names,1,1)
print(결과)
2번. substr() 활용 문제
# 휴대폰 번호 벡터가 있습니다. 각 번호에서 가운데 4자리만 추출해 벡터로 만드세요.
# 가운데 4자리(1234, 9876)만 추출하는 코드를 작성하세요.

phones = c("010-1234-5678", "010-9876-4321")
결과=substr(phones,5,8)
print(결과)

3번. strsplit() 활용 문제
fruits = c("사과,바나나,포도", "딸기,수박")
# 쉼표(,)를 기준으로 과일 이름을 나누는 코드를 작성하세요.

fruits = c("사과,바나나,포도", "딸기,수박")
결과=strsplit(fruits,split=',')
print(결과)

4번. gsub() 활용 문제
아래 벡터에서 모든 'a'를 'A'로 바꾼 새로운 벡터를 만드세요.
words = c("apple", "banana", "grape")
# 모든 'a'를 'A'로 바꾸는 코드를 작성하세요.

words = c("apple", "banana", "grape")
결과=gsub('a','A',words)
print(결과)

5번. gsub() + strsplit() 활용 문제
# 문장 벡터에서 마침표(.)를 공백(' ')으로 바꾸고, 다시 공백을 기준으로 단어별로 나누는 코드를 작성하세요.
sentences = c("I like apple.", "You like banana.")
# 1. 마침표를 공백으로 바꾸고
sentences = c("I like apple.", "You like banana.")
결과=gsub('\\.',' ',sentences)
print(결과)
# 2. 공백으로 단어를 나누세요.
결과2=strsplit(결과, split=' ')
print(결과2)\

10. 연습문제
각 카테고리에 해당하는 문제를 모두 풀어주세요.

자료형
숫자 10을 R에서 저장하면 어떤 자료형일까요?
  print(typeof(10)) #double

  "사과"처럼 따옴표로 감싼 것은 어떤 자료형일까요?
  print(typeof('사과'))
  
  참(True) 또는 거짓(False)은 어떤 자료형일까요?
  print(typeof(TRUE))
  print(typeof(FALSE))
  날짜를 저장하는 자료형을 무엇이라고 하나요?
  아래 코드에서 변수 a의 자료형은 무엇일까요?
  a = 3.14
  print(typeof(a))
변수
변수에 5를 저장하고, 그 값을 출력하는 코드를 써 보세요.
숫자=5
print(숫자)

변수 x에 7을 저장하고, x에 3을 더한 값을 출력하는 코드를 써 보세요.
x=7
print(x+3)

변수란 무엇을 저장하는 상자라고 했나요?
  자료형

  아래 코드에서 변수의 이름은 무엇인가요?  my_age
  my_age = 12
  
연산자
8 + 2의 식과 결과를 R로 구현하세요.
print(8+2)

10 - 4의 식과 결과를 R로 구현하세요.
print(10-4)

3 * 5의 식과 결과를 R로 구현하세요.
print(3*5)

12 / 4의 식과 결과를 R로 구현하세요.
print(12/4)

7 > 5의 결과를 R로 구현하세요.
print(7>5)

조건문
아래 코드에서 "어린이"가 출력되려면 age에 어떤 숫자를 넣어야 하는지 R로 구현하세요.

age=c(10)
  if (age < 13) {
    print("어린이")
  } else {
    print("청소년")
  }
print(age)

숫자 1, 2, 3을 담은 벡터를 만들어 보세요.
num_vec=c(1,2,3)
print(num_vec)

아래 벡터에서 두 번째 값을 출력하는 코드를 써 보세요.
fruits = c("사과", "바나나", "포도")
print(fruits[2])

11. 숙제
아래는 R 벡터 10문제입니다.

1. 벡터에서 두 번째 값을 출력하는 코드를 써 보세요.
colors = c("red", "green", "blue")
print(colors[2])

2. 벡터에서 1, 3번째 값을 한 번에 출력하는 코드를 써 보세요.
nums = c(10, 20, 30, 40)
print(nums[c(1,3)])

3. 벡터의 각 값이 50 이상이면 "PASS", 아니면 "FAIL"을 출력하는 코드를 ifelse로 써 보세요.
scores = c(80, 45, 60, 30)
print(ifelse(scores>=50,'PASS','FAIL'))

4. 벡터의 각 값이 "apple"이면 "과일", 아니면 "모름"을 출력하는 코드를 ifelse로 써 보세요.
items = c("apple", "car", "apple", "dog")
print(ifelse(items=='apple','과일','모름'))

5. 벡터의 각 값에서 첫 글자만 뽑아 새로운 벡터로 만들어 보세요.
names = c("민수", "지영", "철수")
print(substr(names,1,1))

6. 벡터의 각 값에서 모든 "a"를 "A"로 바꾼 새로운 벡터를 만들어 보세요.
words = c("apple", "banana", "grape")
print(gsub('a','A',words))

7. 쉼표(,)로 연결된 과일 이름 벡터를 과일별로 나누어 리스트로 만들어 보세요.
fruits = c("사과,바나나", "포도,딸기")
print(strsplit(fruits,split=','))
8. 숫자 벡터를 문자 벡터로 바꾸는 코드를 써 보세요.
nums = c(1, 2, 3)
print(as.character(nums))
9. 문자 벡터를 숫자 벡터로 바꾸는 코드를 써 보세요.
str_nums = c("10", "20", "30")
print(as.numeric(str_nums))

10.문자 벡터를 숫자 벡터로 바꾸는 코드를 써 보세요.
price = c("15000$", "22000$", "18000$")
결과=gsub('\\$','',price)
print(결과)
결과2=as.numeric(결과)
print(결과2)

# 별5개.벡터 집계함수
# 집계함수란?
# 엑셀에서 총합, 평균, 최댓값 등...
x=c(10,20,30,40,50)
# 최솟값 구하기
최솟값=min(x)
print(최솟값)
# 최댓값 구하기
최댓값=max(x)
print(최댓값)

# 총합 구하기
총합=sum(x)
print(총합)

# 평균 구하기
평균=mean(x)
print(평균)
# 중앙값
# 중앙값: 데이터의 크기 순으로 정렬했을 때 가장 가운데 위치한 값
# 데이터 개수가 짝수일 경우엔 값의 평균을 중앙값으로 사용
중앙값=median(x)
print(중앙값)

#표준편차: 데이터가 평균으로 얼마나 퍼져있는지를 나타내는 통계적 지표
# 예를 들어서 학생 평균 점수가 80점일 때 대부분의 학생이 78~82점 사이에 있다면 
# 표준편차는 작다. but, 점수가 60~100점까지 다양하게 분포되어 있다면 
# 표준편차는 크다
# 표준편차:Standard Deviation
표준편차=sd(x)
print(표준편차)

# 위의 6개 집계함수 꼭 외울 것!

# 벡터에 결측값(누락된 값)이 있을 때
x = c(1,2,NA,4) #결측치가 포함된 벡터
# 결측치가 포함된 데이터는 바로 계산했을 때 NA가 나온다.
평균=mean(x)
print(평균)
# 따라서, 결측값(NA)를 처리 후 계산해야 함.
# 결측값이 있는지 없는지 확인하기(결측값 확인)
data=c(1,2,NA,4,NA,6)
# is.na : 결측값이 존재하는지 판단
# is: na가 있니? 결과가 TRUE니? FALSE니?
print(is.na(data)) #NA가 있는 원소는 TRUE가 출력됨.

# 결측값을 제거하기
# 1. na.omit
# 2. na.rm(rm:remove)
결과=na.omit(data)
print(결과)
data=c(1,2,NA,4,NA,6)
결과=mean(data,na.rm=TRUE) #결측값을 제외한 나머지 값 평균 구함
print(결과)

# 퀴즈
# 다음 벡터에서 결측치(NA)를 벡터의 중앙값으로 대체한 벡터를 만드세요.
x = c(NA,20,35,NA,50,10)
결과=median(x,na.rm=TRUE)
print(결과)

# 벡터들의 집합:별5개! 데이터프레임
# 데이터프레임을 잘 다루면 R은 50% 끝남
# 데이터프레임: 행과 열로 구성된 표 형태의 데이터 구조

# 벡터 생성 
ID=c(1,2,3)
Name=c('홍길동','박길동','최길동')
Age=c(25,30,35)
Salary=c(5000,6000,7000)

# 데이터프레임 생성
# 벡터들을 한번에 묶은 게 데이터프레임(DataFrame)이다.
df=data.frame(ID,Name,Age,Salary)
# 출력
print(df)

View(df)

data=c(20,NA,170,NA,52)
결과=sum(data,na.rm=TRUE)
print(결과)

library(dplyr)

문제11. 부서번호가 20이고 직책이 MANAGER인 사원 번호와 사원 이름 조회
결과=emp %>% filter(DEPTNO==20 & JOB=='MANAGER') %>% select(empNO,ENAME)
print(결과)
View(emp)

문제12. 각 직업별 사원 수 구하기
결과=emp %>% group_by(JOB) %>% summarize(사원수=n())
print(결과)

문제13. 부서 번호가 20인 직원들의 직업(JOB)별 평균 급여(SAL)를 계산하세요.
결과=emp %>% filter(DEPTNO==20) %>% group_by(JOB) %>% summarize(avg_SAL=mean(SAL))
print(결과)

문제14. 급여가 2000 이상인 직원들만 필터링한 후, 부서 번호(DEPTNO)별 직원 수를 계산하세요.
결과=emp %>% filter(SAL>=2000) %>% group_by(DEPTNO) %>% summarize(count=n())
print(결과)

문제15. 커미션(COMM)이 결측치가 아닌 직원들만 필터링한 후, 부서 번호(DEPTNO)별 평균 커미션과 최대 커미션을 계산하세요.
결과=emp %>% filter(!is.na(COMM)) %>% group_by(DEPTNO) %>% summarize(avg_COMM=mean(COMM),max_COMM=max(COMM))
print(결과)

문제16. 직업(JOB)이 'MANAGER'인 직원들만 필터링한 후, 부서 번호(DEPTNO)별 총급여(SAL)의 합계를 계산하세요.
결과=emp %>% filter(JOB=='MANAGER') %>% group_by(DEPTNO) %>% summarize(sum_SAL=sum(SAL))
print(결과)

문제17. 고용일(HIREDATE)이 '1981-01-01' 이후인 직원들만 필터링한 후, 직업(JOB)별 평균 급여(SAL)와 직원 수를 계산하세요.
str(emp)
결과= emp %>% filter(HIREDATE>as.Date('1981-01-01')) %>% group_by(JOB) %>% summarize(avg_SAL=mean(SAL),count=n())
print(결과)

결과=emp %>% filter(HIREDATE>as.Date('1981-01-01')) %>% group_by(JOB) %>% summarize(avg_SAL=mean(SAL),count=n())
print(결과)