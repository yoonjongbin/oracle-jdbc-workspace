DROP TABLE VIDEO_LIKE;
DROP TABLE COMMENT_LIKE;
DROP TABLE VIDEO_COMMENT;
DROP TABLE SUBSCRIBE;
DROP TABLE VIDEO;
DROP TABLE CHANNEL;
DROP TABLE CATEGORY;
DROP TABLE MEMBER;

DROP SEQUENCE SEQ_CATEGORY;
DROP SEQUENCE SEQ_CHANNEL;
DROP SEQUENCE SEQ_COMMENT_LIKE;
DROP SEQUENCE SEQ_SUBSCRIBE;
DROP SEQUENCE SEQ_VIDEO;
DROP SEQUENCE SEQ_VIDEO_LIKE;
DROP SEQUENCE SEQ_VIDEO_COMMENT;



CREATE TABLE VIDEO(
    VIDEO_CODE NUMBER ,
    VIDEO_TITLE VARCHAR2(100) NOT NULL,
    VIDEO_DESC VARCHAR2(200) NOT NULL,
    VIDEO_DATE DATE DEFAULT SYSDATE,
    VIDEO_VIEWS NUMBER DEFAULT 0,
    VIDEO_URL VARCHAR2(300),
    VIDEO_PHOTO VARCHAR2(300),
    CATEGORY_CODE NUMBER,
    CHANNEL_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);



CREATE TABLE CHANNEL(
    CHANNEL_CODE NUMBER,
    CHANNEL_NAME VARCHAR2(100) NOT NULL,
    CHANNEL_DESC VARCHAR2(200),
    CHANNEL_DATE DATE DEFAULT SYSDATE,
    MEMBER_ID VARCHAR2(200)
);


CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(200),
    MEMBER_PWD VARCHAR2(200) NOT NULL,
    MEMBER_NICKNAME VARCHAR2(200) NOT NULL,
    MEMBER_EMAIL VARCHAR2(200),
    MEMBER_PHONE VARCHAR2(200),
    MEMBER_GENDER CHAR,
    MEMBER_AUTHORITY VARCHAR2(200) DEFAULT 'ROLE_USER'
);


CREATE TABLE VIDEO_LIKE(
    V_LIKE_CODE NUMBER,
    V_LIKE_DATE DATE DEFAULT SYSDATE,
    VIDEO_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);

CREATE TABLE VIDEO_COMMENT(
    COMMENT_CODE NUMBER,
    COMMENT_DESC VARCHAR2(200) NOT NULL,
    COMMENT_DATE DATE DEFAULT SYSDATE,
    COMMENT_PARENT NUMBER,
    VIDEO_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);


CREATE TABLE SUBSCRIBE(
    SUBS_CODE NUMBER,
    SUBS_DATE DATE DEFAULT SYSDATE,
    MEMBER_ID VARCHAR2(200),
    CHANNEL_CODE NUMBER
);


CREATE TABLE COMMENT_LIKE(
    COMM_LIKE_CODE NUMBER,
    COMM_LIKE_DATE DATE DEFAULT SYSDATE,
    COMMENT_CODE NUMBER,
    MEMBER_ID VARCHAR2(200)
);



CREATE TABLE CATEGORY(
    CATEGORY_CODE NUMBER,
    CATEGORY_NAME VARCHAR2(50)
);


-- PRIMARY KEY 설정

ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_CODE_PK PRIMARY KEY(CATEGORY_CODE);
ALTER TABLE CHANNEL ADD CONSTRAINT CHANNEL_CODE_PK PRIMARY KEY(CHANNEL_CODE);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_CODE_PK PRIMARY KEY(MEMBER_ID);
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_CODE_PK PRIMARY KEY(COMM_LIKE_CODE);
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBS_CODE_PK PRIMARY KEY(SUBS_CODE);
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CODE_PK PRIMARY KEY(VIDEO_CODE);
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT V_LIKE_CODE_PK PRIMARY KEY(V_LIKE_CODE);
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_CODE_PK PRIMARY KEY(COMMENT_CODE);


-- FOREIGN KEY 설정

ALTER TABLE CHANNEL ADD CONSTRAINT CHANNEL_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_COMMENT_CODE_FK FOREIGN KEY(COMMENT_CODE) REFERENCES VIDEO_COMMENT;
ALTER TABLE COMMENT_LIKE ADD CONSTRAINT COMMENT_LIKE_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBSCRIBE_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE SUBSCRIBE ADD CONSTRAINT SUBSCRIBE_CHANNEL_CODE_FK FOREIGN KEY(CHANNEL_CODE) REFERENCES CHANNEL;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CATEGORY_CODE_FK FOREIGN KEY(CATEGORY_CODE) REFERENCES CATEGORY;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CHANNEL_CODE_FK FOREIGN KEY (CHANNEL_CODE) REFERENCES CHANNEL;
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_VIDEO_CODE_FK FOREIGN KEY(VIDEO_CODE) REFERENCES VIDEO;
ALTER TABLE VIDEO_COMMENT ADD CONSTRAINT VIDEO_COMMENT_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT VIDEO_LIKE_CODE_FK FOREIGN KEY(VIDEO_CODE) REFERENCES VIDEO;
ALTER TABLE VIDEO_LIKE ADD CONSTRAINT VIDEO_LIKE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;



-- SEQUENCE 생성

CREATE SEQUENCE SEQ_CATEGORY;
CREATE SEQUENCE SEQ_CHANNEL;
CREATE SEQUENCE SEQ_COMMENT_LIKE;
CREATE SEQUENCE SEQ_SUBSCRIBE;
CREATE SEQUENCE SEQ_VIDEO;
CREATE SEQUENCE SEQ_VIDEO_LIKE;
CREATE SEQUENCE SEQ_VIDEO_COMMENT;


-- 값을 미리 넣어준다.
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '쇼핑');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '음악');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '영화');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '게임');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '스포츠');
INSERT INTO CATEGORY(CATEGORY_CODE, CATEGORY_NAME) VALUES(SEQ_CATEGORY.NEXTVAL, '학습');

COMMIT;

SELECT * FROM CATEGORY;



-- 테스트와 관련된 쿼리문들
-- 회원가입(register)
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NICKNAME) VALUES('user1', '1234', 'user1');
COMMIT;
SELECT * FROM MEMBER;