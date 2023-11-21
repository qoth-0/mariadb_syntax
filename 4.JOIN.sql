
-- inner join

-- author의 id와 post의 author_id가 같은 값만 조회
select * from author a inner join post p on a.id = p.author_id;

-- 원하는 컬럼 조회(중복된 컬럼명이 있을 경우 해당 테이블명을 붙여줘야 함)
select a.id, name author, title, contents, author_id from author a inner join post p on a.id = p.author_id;

