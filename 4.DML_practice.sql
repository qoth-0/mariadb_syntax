-- 이미지 파일을 이진 데이터로 레코드 저장
create table table_blob(id int, myimg longblob);
insert into table_blob (id, myimg) values (1, load_file('C:\\test_picture.jpg'));
select * from table_blob; -- blob으로 조회됨
select hex(myimg) from table_blob where id = 1; -- 16진수로 조회됨


-- author 데이터 중 id가 4인 데이터를 email을 abc@naver.com, name을 abc로 변경
update author set email='abc@naver.com', name='abc' where id=4;

-- post에 글쓴적이 있는 author 데이터 1개 삭제 -> 에러 -> 조치 후 삭제
-- 방법 1
delete from post where author_id = 2;
delete from author where id = 2;
-- 방법 2
update post set author_id = null where author_id = 2;
delete from author where id = 2;





