-- 데이터베이스 생성
CREATE DATABASE board;
-- 데이터베이스 생성 후 확인
SHOW DATABASES;
-- 데이터베이스 삭제
DROP DATABASE board;
-- 데이터베이스 선택
USE board;

-- author 테이블 신규 생성
CREATE TABLE author(
    id INT, name VARCHAR(100) not null, 
    email VARCHAR(255), 
    password VARCHAR(255), 
    role VARCHAR(50), 
    address VARCHAR(255), 
    PRIMARY KEY(id));
-- 테이블 목록 조회
SHOW TABLES;
-- 테이블 컬럼조회
DESCRIBE author;
-- post 테이블 신규 생성
CREATE TABLE post(id INT PRIMARY KEY, title VARCHAR(255), contents VARCHAR(3000), author_id INT, FOREIGN KEY(author_id) REFERENCES author(id));

--  테이블 컬럼 상세 조회
SHOW FULL COLUMNS FROM author;

-- 테이블 생성문 조회 ( 중간에 ALTER하다보면 변경이 많이 돼서 마지막에 라이브서버에 올릴 때의 편리함을 위해 사용)
SHOW CREATE TABLE posts;
-- CREATE TABLE `posts` (
--    `id` int(11) NOT NULL,
--    `title` varchar(255) DEFAULT NULL,
--    `content` varchar(255) DEFAULT NULL,
--    `author_id` int(11) DEFAULT NULL,
--    PRIMARY KEY (`id`),
--    KEY `author_id` (`author_id`),
--    CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
--  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

-- 참조관계 및 제약조건 정보조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'post';

-- 인덱스 조회
SHOW INDEX FROM post;
-- BTREE구조의 ~~한 점 때문에 인덱스를 사용하면 빠르게 조회가 가능하다정도까지 정리할 능력 필요

-- ALTER문
-- 테이블 이름 변경
ALTER TABLE posts RENAME post;

-- 테이블 컬럼 추가
ALTER TABLE author ADD COLUMN role VARCHAR(50);
ALTER TABLE author ADD COLUMN age tinyint unsigned; -- author 테이블에 age 데이터 tinyint unsigned로 추가
ALTER TABLE post add COLUMN price decimal(10,3); -- post에 price라는 원고료 컬럼을 추가, 원고료 컬럼은 총자릿수 10자리 및  소수점단위는 3자리까지 가능
ALTER TABLE post add COLUMN created_time datetime(6) default current_timestamp(6); -- post 테이블에 DATETIME으로 created_time 컬럼 추가 및 default로 현재시간 들어가도록 설정

-- 테이블 컬럼 타입 변경(덮어쓰기)
ALTER TABLE author MODIFY COLUMN name VARCHAR(100) NOT NULL;
ALTER TABLE author MODIFY COLUMN role enum('user', 'admin') NOT NULL default 'user'; -- role 타입을 enum타입으로 변경하고, ‘user’, ‘admin’으로 enum타입 지정, not null로 설정, 입력이 없을 시에는 ‘user’로 세팅되도록 default 설정
ALTER TABLE post MODIFY COLUMN id INT AUTO_INCREMENT; -- 새로운 레코드가 추가될 때마다 1씩 증가된 값을 저장
ALTER TABLE author MODIFY COLUMN email varchar(255) UNIQUE; -- UNIQUE 제약조건 추가(컬럼 제약조건)

-- 컬럼 이름 변경
ALTER TABLE posts CHANGE COLUMN content contents VARCHAR(255);

-- 컬럼 삭제
ALTER TABLE author DROP DOLUMN test1;

-- 제약조건 추가
ALTER TABLE author ADD CONSTRAINT email_unique UNIQUE(email); -- UNIQUE 제약조건 추가(테이블 제약조건 - 별도의 제약조건명 설정)
ALTER TABLE post ADD CONSTRAINT post_author_fk FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE CASCADE; -- 외래키 제약조건 추가(CASCADE 적용)
ALTER TABLE post ADD CONSTRAINT post_author_fk2 FOREIGN KEY (author_id) REFERENCES author(id) ON UPDATE SET NULL ON DELETE SET NULL; -- 외래키 제약조건 추가(SET NULL 적용)

-- 제약조건 제거
ALTER TABLE author DROP CONSTRAINT email;

-- 인덱스 제거
ALTER TABLE post DROP INDEX author_id; -- 외래키 제약조건 삭제 시 인덱스는 남기 때문에 따로 삭제를 해줘야 함


-- 데이터베이스 삭제
DROP DATABASE board;
-- 테이블 삭제
DROP TABLE post;
-- 테이블의 데이터를 지우고 싶을 때
DELETE FROM post;
TRUNCATE TABLE post;

