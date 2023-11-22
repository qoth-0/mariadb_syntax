-- rollback
insert into author(id, name, email) values(10, 'test', 'test@naver,com'); -- 성공
insert into post(title, contents, author_id) values('hello', 'hello is', 100); --실패
select * from author; -- 첫번째 쿼리만 적용됨을 확인(임시저장된 것)
rollback; -- 취소 연산
select * from author; -- 모두 취소되어 첫번째 쿼리 적용되기 전으로 돌아감

-- commit
insert into author(id, name, email) values(10, 'test', 'test@naver,com'); -- 성공
insert into post(title, contents, author_id) values('hello', 'hello is', 100); --실패
select * from author; -- 첫번째 쿼리만 적용됨을 확인(임시저장된 것)
commit; -- 확정 연산
select * from author; -- 첫번째 쿼리 적용됨을 확인(확정된 것, 이 후 rollback해도 이전으로 돌아가지 않음)

-- 사용자 관리
CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpw'; -- 신규사용자 생성
SELECT * FROM mysql.user; -- 사용자 목록 조회
GRANT INSERT ON board.author TO 'testuser'@'localhost'; -- 특정DB의 특정테이블에 INSERT권한 부여
REVOKE INSERT ON board.author FROM 'testuser'@'localhost'; -- INSERT권한 해제
FLUSH PRIVILEGES; -- 권한 변경사항 적용
show grants for 'testuser'@'localhost'; -- 특정 사용자 권한 조회
DROP USER 'testuser'@'localhost'; -- 사용자 삭제

-- 뷰 생성
CREATE VIEW author_for_view AS
SELECT name, email
FROM author;
-- 뷰 조회
SELECT * FROM author_for_view;
-- 뷰 조회 권한 부여
GRANT SELECT ON author_for_view TO 'testuser'@'localhost'; 
