-- 사용자 계정 생성하는 구문 : 관리자 계정만이 할 수 있는 역할
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER kh IDENTIFIED BY kh;


-- 위에서 만들어진 사용자 계정에게 최소한의 권한(데이터관리, 접속) 부여
-- [표현법] GRANT 권한 1, 권한 2, ... TO 계정명;
-- RESOURCE는 객체(생성, 수정, 삭제), 데이터(입력, 수정, 조회, 삭제) 권한 
-- CONNECT 권한이 없으면 해당 유저로 접속이 되지 않음
GRANT RESOURCE, CONNECT TO kh;

-- TABLESPACE에 대한 권한 부여
GRANT UNLIMITED TABLESPACE TO kh;




CREATE USER study IDENTIFIED BY study;
GRANT RESOURCE, CONNECT TO study;
GRANT UNLIMITED TABLESPACE TO study;

-- DDL 관련 계정생성
CREATE USER ddl IDENTIFIED BY ddl;
GRANT RESOURCE, CONNECT TO ddl;
GRANT UNLIMITED TABLESPACE TO ddl;



-- JDBC 관련 계정
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT RESOURCE, CONNECT TO jdbc;
GRANT UNLIMITED TABLESPACE TO jdbc;



-- YOUTUBE 계정

CREATE USER youtube IDENTIFIED BY youtube;
GRANT RESOURCE, CONNECT TO youtube;
GRANT UNLIMITED TABLESPACE TO youtube;


-- 햄디 계정
CREATE USER HamsterD IDENTIFIED BY HamsterD;
GRANT RESOURCE, CONNECT TO HamsterD;
GRANT UNLIMITED TABLESPACE TO HamsterD;

