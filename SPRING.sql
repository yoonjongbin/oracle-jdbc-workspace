-- 프로젝트 : 04_MVC

DROP TABLE TB_MEMBER;

CREATE TABLE TB_MEMBER(
    MEMBER_ID VARCHAR(20) PRIMARY KEY,
    MEMBER_PWD VARCHAR(20) NOT NULL,
    MEMBER_NAME VARCHAR(20) NOT NULL,
    MEMBER_ADDR VARCHAR(20) NOT NULL
);

SELECT * FROM TB_MEMBER;




-- 단위 테스트를 위한 DB (프로젝트 : 05_MVC_Board)

DROP SEQUENCE SEQ_BOARD;
DROP TABLE BOARD;

CREATE SEQUENCE SEQ_BOARD;
CREATE TABLE BOARD(
    NO NUMBER,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    WRITER VARCHAR2(50) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE
);

ALTER TABLE BOARD ADD FILE_URL VARCHAR(200);


SELECT * FROM BOARD;


-- 실행이 중첩 될때마다 값이 두배씩 들어감
INSERT INTO BOARD(NO, TITLE, CONTENT, WRITER)
(SELECT SEQ_BOARD.NEXTVAL, TITLE, CONTENT, WRITER FROM BOARD);

COMMIT;

ALTER TABLE BOARD ADD CONSTRAINT PK_BOARD PRIMARY KEY(NO);


SELECT *
FROM BOARD
ORDER BY NO ASC;

-- 힌트...!(/* */)
-- BOARD의 PK 컬럼이 NO을 사용하여 INDEX를 사용하면 더욱 빠르게 데이터를 검색가능 

-- SELECT /*+ INDEX_ASC(BOARD PK_BOARD) */ *
-- FROM BOARD;


-- 첫페이지(1~10)

SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
    ROWNUM NUM, NO, TITLE, CONTENT
FROM BOARD
WHERE ROWNUM <= 10;

--SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
--    NUM, NO, TITLE, CONTENT
--FROM (SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
--        ROWNUM NUM, NO, TITLE, CONTENT
--        FROM BOARD
--        WHERE ROWNUM <= 10)
--WHERE NUM >= 0;


-- 두번째 페이지(11~20)

SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
    NUM, NO, TITLE, CONTENT
FROM (SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
        ROWNUM NUM, NO, TITLE, CONTENT
        FROM BOARD
        WHERE ROWNUM <= 20)
WHERE NUM >= 11;


-- 세번째 페이지(21~30)

SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
    NUM, NO, TITLE, CONTENT
FROM (SELECT /*+ INDEX_DESC(BOARD PK_BOARD) */ 
        ROWNUM NUM, NO, TITLE, CONTENT
        FROM BOARD
        WHERE ROWNUM <= 30)
WHERE NUM >= 21;

SELECT ROWNUM NUM, NO, TITLE, CONTENT
FROM BOARD;


-- 06_SpringSecurity

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    id varchar2(50) primary key,
    password varchar2(100) not null,
    name varchar2(50) not null,
    address varchar2(200),
    auth varchar2(50) default 'ROLE_MEMBER' not null,
    enabled number(1) default 1 not null
);

INSERT INTO MEMBER(id, password, name, address)
VALUES('USER1', '1234', '윤종빈', '경기도 광주');

SELECT *
FROM MEMBER;


-- 07_RestfulAPI

create table company (
	vcode varchar2(10) primary key,
	vendor  varchar2(20) not null
);

insert  into company values('10', '삼성');
insert  into company values('20', '애플');

create table Phone(
	num varchar2(10) primary key,
	model varchar2(20) not null,
	price number not null,
	vcode varchar2(10),
   constraint fk_vcode foreign key(vcode) references company(vcode)
);

insert into Phone values('ZF01','Galaxy Z Flip5', 1369000,'10');
insert into Phone values('S918N','Galaxy S23 Ultra', 1479000,'10');
insert into Phone values('IPO02','iPhone 14',1250000,'20');

create table userinfo (
	id varchar(20) primary key,
	pw varchar(20) not null
);

insert into userinfo values('member','member');
insert into userinfo values('admin','admin');
commit;
