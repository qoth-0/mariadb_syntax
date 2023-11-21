
-- inner join
-- author의 id와 post의 author_id가 같은 값만 조회
select * from author a inner join post p on a.id = p.author_id;
-- 원하는 컬럼 조회(중복된 컬럼명이 있을 경우 해당 테이블명을 붙여줘야 함)
select a.id, name author, title, contents, author_id from author a inner join post p on a.id = p.author_id;
-- 글을 작성한 모든 저자의 이름(name)과 해당 글의 제목(title)을 조회
SELECT name, title from author a inner join post p on a.id = author_id;

-- outer join
-- author의 테이블은 일단 다 조회하고 author가 작성한 글정보를 join하여 추가적으로 조회
select * from author a LEFT JOIN post p on a.id = p.author_id;
--모든 저자의 이름과 해당 저자가 작성한 글의 제목을 조회(글을 작성하지 않은 저자의 경우, 글 제목은 NULL로 표시)
select name, title from author a left join post p on a.id = p.author_id;
-- 나이가 25세 이상인 저자가 작성한 글의 제목을 조회
select name, title from author a left join post p on a.id = p.author_id where a.age >= 25;

