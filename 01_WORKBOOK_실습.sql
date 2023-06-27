-- SELECT(BASIC)

-- 1.

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT;

-- 2.

SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || ' 명입니다.' "학과별 정원"
FROM TB_DEPARTMENT;

-- 3. 

SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME LIKE '국어국문학과';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO LIKE (SELECT DEPARTMENT_NO
                          FROM TB_DEPARTMENT
                          WHERE DEPARTMENT_NAME LIKE '국어국문학과')
    AND STUDENT_SSN LIKE '%-2%' 
    AND ABSENCE_YN LIKE 'Y';
    
-- 4.

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO LIKE 'A513079'
    OR STUDENT_NO LIKE 'A51309%'
    OR STUDENT_NO LIKE 'A5131%'
ORDER BY STUDENT_NAME DESC;

-- 5.

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20
    AND CAPACITY <= 30;
    
-- 6.

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7.

SELECT STUDENT_NAME, DEPARTMENT_NO
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8.

SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9.

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 10.

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE STUDENT_NO LIKE 'A2%'
    AND STUDENT_ADDRESS LIKE '%전주%'
ORDER BY STUDENT_NAME;


--------------------------------------

--  SELECT_FUNCTION

-- 1.

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE;

-- 2. 

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3
ORDER BY PROFESSOR_SSN DESC;

-- 3.
ALTER SESSION SET NLS_DATE_FORMAT = 'RRRRMMDD';

SELECT SYSDATE FROM DUAL;

SELECT PROFESSOR_NAME, '19000000' + SUBSTR(PROFESSOR_SSN, 1, 6) 나이
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN NOT LIKE '00%';

SELECT PROFESSOR_NAME 교수이름, CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE('19000000' + SUBSTR(PROFESSOR_SSN, 1, 6)))/12) 나이
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN NOT LIKE '00%'
ORDER BY 나이;


-- 4.

SELECT SUBSTR(PROFESSOR_NAME, 2) 이름
FROM TB_PROFESSOR
ORDER BY PROFESSOR_NAME DESC;

-- 5.

SELECT STUDENT_NO, STUDENT_NAME, CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE('19000000' + SUBSTR(STUDENT_SSN, 1, 6)))/12) - CEIL(MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE)/12) 입학나이
FROM TB_STUDENT
WHERE CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE('19000000' + SUBSTR(STUDENT_SSN, 1, 6)))/12) - CEIL(MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE)/12) > 19;

-- 6.

SELECT TO_CHAR(TO_DATE('20201225'), 'DAY') 요일
FROM DUAL;

-- 7.

SELECT TO_DATE('99/10/11', 'YY/MM/DD') 값1, TO_DATE('49/10/11', 'YY/MM/DD') 값2, TO_DATE('99/10/11', 'RR/MM/DD') 값3, TO_DATE('49/10/11', 'RR/MM/DD') 값4
FROM DUAL; -- YY은 2000년도 이후, RR은 1900도 부터

-- 8.

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%';

-- 9.

SELECT ROUND(AVG(TB_GRADE.POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO LIKE 'A517178';

-- 10.

SELECT DEPARTMENT_NO 학과번호, COUNT(DEPARTMENT_NO) 학생수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11.

SELECT COUNT(STUDENT_NO) "COUNT(*)"
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12.  ?? - GROUP BY SUBSTR(TERM_NO, 1, 4)!!

SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(TB_GRADE.POINT), 1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO LIKE 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY SUBSTR(TERM_NO, 1, 4);




-- 13.  ?? join 이나 서브 쿼리 없이는 힘들지 않나요??


/*
SELECT DEPARTMENT_NO, COUNT(ABSENCE_YN)
FROM TB_STUDENT
WHERE ABSENCE_YN LIKE 'Y'
GROUP BY DEPARTMENT_NO
UNION
SELECT DEPARTMENT_NO, 0
FROM TB_DEPARTMENT
ORDER BY DEPARTMENT_NO;


SELECT 
CASE

    WHEN NVL(COUNT(STUDENT_NO), 0) = 0 THEN 
    (SELECT DEPARTMENT_NO 학과코드명, COUNT(STUDENT_NO)
    FROM S
    WHERE ABSENCE_YN LIKE 'Y'
    GROUP BY DEPARTMENT_NO
    ORDER BY DEPARTMENT_NO)
    
    ELSE
    (SELECT DEPARTMENT_NO 학과코드명, COUNT(STUDENT_NO)
    FROM S
    WHERE ABSENCE_YN LIKE 'Y'
    GROUP BY DEPARTMENT_NO
    ORDER BY DEPARTMENT_NO)
    END AS "휴학생 수"
FROM TB_STUDENT S;

*/

SELECT DEPARTMENT_NO, SUM(ABSENCE_COUNT)
FROM(
SELECT DEPARTMENT_NO, COUNT(ABSENCE_YN) AS ABSENCE_COUNT
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
UNION
SELECT DEPARTMENT_NO, 0
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO)
GROUP BY DEPARTMENT_NO
ORDER BY 1;

SELECT DEPARTMENT_NO, ABSENCE_YN
FROM TB_STUDENT
MINUS
SELECT DEPARTMENT_NO, ABSENCE_YN
FROM TB_STUDENT
WHERE ABSENCE_YN LIKE 'N';


SELECT DEPARTMENT_NO, COUNT(NVL(DEPARTMENT_NO, 0))
FROM TB_STUDENT
WHERE ABSENCE_YN LIKE 'Y'
GROUP BY DEPARTMENT_NO
HAVING DEPARTMENT_NO != (SELECT DISTINCT DEPARTMENT_NO FROM TB_STUDENT)
ORDER BY DEPARTMENT_NO;

SELECT DISTINCT DEPARTMENT_NO 
FROM TB_STUDENT;



-- 14.

SELECT STUDENT_NAME 동일이름, COUNT(STUDENT_NO) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NO) > 1
ORDER BY STUDENT_NAME;

-- 15.  ?? - ROLLUP!!!

SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 6) 학기, ROUND(AVG(TB_GRADE.POINT), 1) "평균"
FROM TB_GRADE
WHERE STUDENT_NO LIKE 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 6))
ORDER BY SUBSTR(TERM_NO, 1, 4);