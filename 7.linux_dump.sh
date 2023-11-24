
sudo apt-get update
sudo apt-get upgrade

# mariadb 설치
sudo apt install mariadb-server

# 접속
sudo mariadb -u root -p

# 데이터베이스 생성
create database board;

# 깃 클론(dump파일 다운로드)
git clone https://github.com/qoth-0/mariadb_syntax.git

# dump
cd mariadb_syntex
sudo mysql -u root -p board < 6.dumpfile.sql

sudo mariadb -u root -p

# 테이블 확인
use board;
select * from author;
