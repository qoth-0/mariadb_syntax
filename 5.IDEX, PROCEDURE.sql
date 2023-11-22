CREATE INDEX author_name ON author(name); -- 단일 컬럼 인덱스 생성
CREATE INDEX author_index ON author(name, email); -- 다중컬럼 인덱스 생성

show index from author; -- 특정 테이블의 인덱스 조회

select * from author where name = 'qoth'; -- 인덱스 페이지를 활용한 조회(where) - name에 단일 인덱스 걸었을 경우
select * from author where name = 'abc' and email = '@.com'; -- name, email로 다중 인덱스 걸었을 경우


-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE getUser(IN userID INT)
BEGIN
SELECT * FROM author WHERE id = userID;
END //
DELIMITER ;
-- 프로시저 호출
CALL getUser(2); -- id = 2
-- 프로시저 내용 조회
show create procedure getUser;

-- 파라미터 여러개인 프로시저 생성
DELIMITER //
CREATE PROCEDURE postInsert(IN in_title VARCHAR(255), IN in_contents VARCHAR(3000), IN in_author_id INT)
BEGIN
insert into board.post(title, contents, author_id) values(in_title, in_contents, in_author_id);
END //
DELIMITER ;
-- 프로시저 호출
CALL postInsert('안녕','하세요', 3);

-- IF문 사용, 고액 원고료 작가 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE my_procedure(IN in_author_id INT)
BEGIN
DECLARE avg_price INT DEFAULT 0;
SELECT AVG(price) INTO avg_price FROM post WHERE author_id = in_author_id;
IF avg_price > 5000 THEN
	SELECT '고액 원고료 작가입니다.' AS message;
ELSE
	SELECT '고액 원고료 작가가 아닙니다.' AS message;
END IF;
END //
DELIMITER ;

-- WHILE문 사용, 데이터 대량 삽입 프로시저 생성 
DELIMITER //
CREATE PROCEDURE add_data()
BEGIN
DECLARE a INT DEFAULT 0;
WHILE a < 1000 DO
INSERT INTO post(title) VALUES(concat('qoth', a));
SET a = a + 1;
END WHILE;
END //
DELIMITER ;