
-- INNER JOIN
-- author의 id와 post의 author_id가 같은 값만 조회
select * from author a inner join post p on a.id = p.author_id;
-- 원하는 컬럼 조회(중복된 컬럼명이 있을 경우 해당 테이블명을 붙여줘야 함)
select a.id, name author, title, contents, author_id from author a inner join post p on a.id = p.author_id;
-- 글을 작성한 모든 저자의 이름(name)과 해당 글의 제목(title)을 조회
SELECT name, title from author a inner join post p on a.id = author_id;

-- OUTER JOIN
-- author의 테이블은 일단 다 조회하고 author가 작성한 글정보를 join하여 추가적으로 조회
select * from author a LEFT JOIN post p on a.id = p.author_id;
-- 같은 전체 조회라도 테이블의 순서를 바꿀 수 있음
select p.*, a.* from author a LEFT JOIN post p on a.id = p.author_id;
--모든 저자의 이름과 해당 저자가 작성한 글의 제목을 조회(글을 작성하지 않은 저자의 경우, 글 제목은 NULL로 표시)
select name, title from author a left join post p on a.id = p.author_id;
-- 나이가 25세 이상인 저자가 작성한 글의 제목을 조회
select name, title from author a left join post p on a.id = p.author_id where a.age >= 25;

-- UNION(필드 갯수와 타입이 같을 경우)
SELECT name, email FROM author UNION SELECT title, contents FROM POST; -- 중복제거
SELECT name, email FROM author UNION ALL SELECT title, contents FROM POST; -- 중복포함조회

-- 서브 쿼리(JOIN 대체 가능)
SELECT a.* FROM author a INNER JOIN post p ON a.id = p.author_id;
SELECT a.* FROM author a WHERE a.ID IN (SELECT p.author_id FROM post p);

-- 집계함수
SELECT count(*) from post;
SELECT min(price) from post;
SELECT max(price) from post;
SELECT sum(price) from post;
SELECT round(avg(price), 0) from post; -- round(대상값, 소숫점자리)

-- GROUP BY
select author_id, count(*) from post group by author_id;
select author_id, sum(price), avg(price) from post group by author_id;

select author_id, avg(price) from post where price > 5000 group by author_id; -- where로 데이터 거른 후 group by
select author_id, avg(price) from post group by author_id having avg(price) > 5000; -- group by 후 having으로 거름

SELECT USER_ID, PRODUCT_ID FROM ONLINE_SALE GROUP BY USER_ID, PRODUCT_ID HAVING COUNT(PRODUCT_ID) >= 2 ORDER BY USER_ID, PRODUCT_ID DESC; -- GROUP BY 연달아 가능

-- UNION WITH RECURSIVE
WITH RECURSIVE number_sequence(HOUR) AS  --테이블명, 컬럼명 지정
( 
	SELECT 0        -- HOUR에 0 부터 입력
	UNION ALL
	SELECT HOUR + 1 FROM number_sequence WHERE HOUR < 23  -- HOUR +1이 23이 될 때 까지 반복
)SELECT HOUR, 0 AS COUNT FROM number_sequence;