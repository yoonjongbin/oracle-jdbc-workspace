DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    ID VARCHAR2(100),
    PASSWORD VARCHAR2(100),
    NAME VARCHAR2(100)
);

SELECT * FROM MEMBER;

ALTER TABLE MEMBER
ADD CONSTRAINT PK_ID PRIMARY KEY (ID);

ALTER TABLE MEMBER
DROP CONSTRAINT PK_ID;