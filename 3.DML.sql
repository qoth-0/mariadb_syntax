-- INSERT, SELECT, UPDATE, DELETE
insert into author(id, name, email) values(1, 'kim', 'abc@naver.com');

update author set email='abc2@test.com' where id=1;

delete from author where id=2;


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

-- alias를 이용한 select문
select name as 이름, email from author; --name속성이 이름이라는 문자로 출력됨(as 생략가능)
select name, email from author as a; -- 테이블에도 as 가능

