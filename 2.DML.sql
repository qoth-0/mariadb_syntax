-- 테이블에 새로운 레코드 추가(INSERT)
insert into author(id, name, email) values(1, 'kim', 'abc@naver.com');
INSERT INTO post(id, title, contents, author_id) VALUES (1, '가', '하하', 1);


-- 테이블의 레코드 내용을 수정(UPDATE)
update author set email='abc2@test.com' where id=1;
update post set author_id = null where author_id is not null;
-- author 데이터 중 id가 4인 데이터를 email을 abc@naver.com, name을 abc로 변경
update author set email='abc@naver.com', name='abc' where id=4;


-- 테이블의 데이터 삭제(DELETE)
delete from author where id=2;

-- post에 글쓴적이 있는 author 데이터 1개 삭제 -> 에러 -> 조치 후 삭제
-- 방법 1
delete from post where author_id = 2;
delete from author where id = 2;
-- 방법 2
update post set author_id = null where author_id = 2;
delete from author where id = 2;


-- 테이블의 데이터 조회(SELECT)
select * from author where id=1;
select name, email from author where id=1;
select * from author where id > 1;
select * from author where id > 1 and name = 'kim'; 

-- 이름 중복제거하고 조회
select distinct name from author;

-- order by (asc:오름차순, desc:내림차순)
select * from author order by name desc;

-- order by 멀티 : 먼저 쓴 컬럼 우선정렬, asc/desc 생략 시 asc 적용
select author order by name, email desc; -- name으로 오름차순 후 email로 내림차순 적용
select author order by name desc, email desc; -- name도 내림차순 적용하고 싶으면 뒤에 desc 넣어줘야 함

--  limit number : 특정 숫자로 결과값 개수 제한
select * from author order by id desc limit 2;
select * from post order by title asc, contents desc limit 3;

-- alias를 이용한 select문
select name as 이름, email from author; --name속성이 이름이라는 문자로 출력됨(as 생략가능)
select name, email from author as a; -- 테이블에도 as 가능

-- 비교연산자 사용
select *from post where id != 1; -- 같지않음
select *from post where id <> 1; -- 같지않음
select * from post where id not in(1,2,3); -- 1,2,3이 아닌 값 조회

-- 논리연산자 사용
SELECT * from author where name = ‘홍길동’ AND  age=20; --AND
select * from author where name= ‘홍길동’ or age = 20; -- OR

-- post  테이블의 id가 2~4까지의 데이터 조회
select * from post where id between 2 and 4;  -- between 활용
select * from post where id > 1 and id < 5; -- and 조건 활용
select * from post where not (id < 2 or id > 4); -- or 조건 활용

-- 문자열 검색(LIKE)
SELECT * FROM author WHERE name LIKE ‘동%’; -- 동으로 시작하는 문자
SELECT * FROM author WHERE name LIKE ‘%동%’; -- 동이 들어가는 문자

-- 정규표현식 패턴 연산(REGEXP)
SELECT * FROM author WHERE name REGEXP ‘[a-z]’; -- a~z까지를 포함한 문자
SELECT * FROM author WHERE name REGEXP ‘[가-힣]’; -- 한글이 들어있는 문자

-- 이미지 파일을 이진 데이터로 레코드 저장
create table table_blob(id int, myimg longblob);
insert into table_blob (id, myimg) values (1, load_file('C:\\test_picture.jpg'));
select * from table_blob; -- blob으로 조회됨
select hex(myimg) from table_blob where id = 1; -- 16진수로 조회됨

-- TYPE 변환(정수 값을 DATE 타입으로 변환)
SELECT CAST(20200101 AS DATE); -- CAST
SELECT CONVERT(’20200101’, DATE); -- CONVERT
SELECT DATE_FORMAT(’2020-01-01 17:12:00’, ‘%Y-%m-%d’); -- DATE_FORMAT

-- CAST, CONVERT 사용 시 유의사항
SELECT CAST(’123’ as signed); -- 문자열 정수 변환 (구버전, 신버전 모두 가능)
SELECT CAST(’123’ as INT); -- 신버전만 가능

-- DATE_FORMAT사용 해당 날짜 작성글 조회
SELECT *FROM post where DATE_FORMAT(created_time, ‘%Y-%m-%d’) = ‘2023-11-17’;

-- 하드코딩 없이 now()로 현재날짜로 조회
SELECT * FROM post where DATE_FORMAT(created_time, '%Y-%m-%d') = DATE_FORMAT(now(), '%Y-%m-%d');

-- 날짜 데이터 조회
SELECT * FROM post WHERE  create_time like ‘2023%’; -- LIKE
WHERE create_time BETWEEN ‘2021-01-01’ AND ‘2023-11-17’; -- BETWEEN
WHERE created_time ≥ ‘2021-01-01’ AND created_time ≤ ‘2023-11-17’; -- AND 조건

-- 제약조건명 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'author';

-- 흐름제어
--CASE WHEN
SELECT id, title, contents, 
case author_id
	when 1 then 'First Author'
    when 2 then 'Second Author'
	ELSE 'Others'
end
as author_type from post;

--IF
SELECT id, title, contents, 
if (author_id=1, 'First Author', 'Others') as author_type from post; --참이면 First Author, 거짓이면 Others

--IFNULL
select id, title, contents, ifnull(author_id, 'anonymous') from post; --NULL이면 anonymous
