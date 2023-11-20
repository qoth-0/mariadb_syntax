-- rollback
insert into author(id, name, email) values(10, 'test', 'test@naver,com'); -- 성공
insert into post(title, contents, author_id) values('hello', 'hello is', 100); --실패
select * from author; -- 첫번째 쿼리만 적용됨을 확인(임시저장된 것)
rollback; -- 취소 연산
select * from author; -- 모두 취소되어 첫번째 쿼리 적용되기 전으로 돌아감

--commit
insert into author(id, name, email) values(10, 'test', 'test@naver,com'); -- 성공
insert into post(title, contents, author_id) values('hello', 'hello is', 100); --실패
select * from author; -- 첫번째 쿼리만 적용됨을 확인(임시저장된 것)
commit; -- 확정 연산
select * from author; -- 첫번째 쿼리 적용됨을 확인(확정된 것, 이 후 rollback해도 이전으로 돌아가지 않음)


