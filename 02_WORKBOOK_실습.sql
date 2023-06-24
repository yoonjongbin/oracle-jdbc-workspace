-- 1.
SELECT STUDENT_NAME "학생이름", STUDENT_ADDRESS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;

-- 2.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3. 
SELECT STUDENT_NAME "학생이름", STUDENT_NO "학번", STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원%' 
    OR STUDENT_ADDRESS LIKE '경기%')
    AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_NAME ASC;


-- 4.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR P
    JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '법학과'
ORDER BY PROFESSOR_SSN ASC;

-- 5. 
SELECT S.STUDENT_NO, G.POINT
FROM TB_STUDENT S
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE G.TERM_NO LIKE '200402'
    AND CLASS_NO LIKE 'C3118100'
ORDER BY G.POINT DESC, S.STUDENT_NO ASC;

-- 6.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
ORDER BY S.STUDENT_NAME ASC;

-- 7.
SELECT C.CLASS_NAME, D.DEPARTMENT_NAME
FROM TB_CLASS C
    JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO);
    
-- 8.
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C
    JOIN TB_PROFESSOR P ON(C.DEPARTMENT_NO = P.DEPARTMENT_NO);
    
-- 9.
SELECT S.STUDENT_NO, S.STUDENT_NAME, ROUND(AVG(G.POINT), 1)
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE D.DEPARTMENT_NAME LIKE '음악학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY S.STUDENT_NO;


-- 10.
SELECT D.DEPARTMENT_NAME "학과이름", S.STUDENT_NAME "학생이름", P.PROFESSOR_NAME "지도교수"
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.STUDENT_NO LIKE 'A313047';


-- 11.
SELECT  S.STUDENT_NAME , G.TERM_NO
FROM TB_GRADE G
    JOIN TB_CLASS C ON(G.CLASS_NO = C.CLASS_NO)
    JOIN TB_STUDENT S ON(G.STUDENT_NO = S.STUDENT_NO)
WHERE C.CLASS_NAME LIKE '인간관계론'
    AND G.TERM_NO LIKE '2007%';
    

-- 12.


SELECT C.CLASS_NAME, D.DEPARTMENT_NAME
FROM TB_CLASS C
    JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE C.CLASS_NO IN(SELECT C.CLASS_NO
                    FROM TB_CLASS C
                        JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
                    WHERE D.CATEGORY LIKE '예체능'
                    MINUS
                    SELECT CLASS_NO
                    FROM TB_CLASS_PROFESSOR);
                    
-- 13.

SELECT S.STUDENT_NAME, NVL(P.PROFESSOR_NAME,'지도교수 미지정')
FROM TB_STUDENT S
    LEFT JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
    LEFT JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE D.DEPARTMENT_NAME LIKE '서반아어학과'
ORDER BY S.STUDENT_NO ASC;

-- 14.

SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(G.POINT), 1)
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE S.ABSENCE_YN LIKE 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING ROUND(AVG(G.POINT), 1) >= 4.0
ORDER BY S.STUDENT_NO;


--15.

SELECT C.CLASS_NO, C.CLASS_NAME, ROUND(AVG(G.POINT), 1)
FROM TB_CLASS C
    JOIN TB_GRADE G ON(C.CLASS_NO = G.CLASS_NO)
    JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE C.CLASS_TYPE LIKE '전공%'
    AND D.DEPARTMENT_NAME LIKE '환경조경학과'
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY C.CLASS_NO;


-- 16.

SELECT STUDENT_NAME, NVL(STUDENT_ADDRESS, '주소지 등록 X')
FROM TB_STUDENT
WHERE DEPARTMENT_NO LIKE (SELECT DEPARTMENT_NO
                          FROM TB_STUDENT
                          WHERE STUDENT_NAME LIKE '최경희')
    AND STUDENT_NAME NOT LIKE '최경희';
    
-- 17.

SELECT MAX(AVG(G.POINT))
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE D.DEPARTMENT_NAME LIKE '국어국문학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME;  -- 3.833333 (평균 평점이 가장 높은 사람)

SELECT S.STUDENT_NO, S.STUDENT_NAME
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE D.DEPARTMENT_NAME LIKE '국어국문학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
HAVING AVG(G.POINT) = (SELECT MAX(AVG(G.POINT))
                        FROM TB_STUDENT S
                            JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                            JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
                        WHERE D.DEPARTMENT_NAME LIKE '국어국문학과'
                        GROUP BY S.STUDENT_NO, S.STUDENT_NAME); -- 평균 평점이 가장 높은사람 학번과 이름 출력


--SELECT S.STUDENT_NO, S.STUDENT_NAME
--FROM TB_STUDENT S
--    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
--    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
--    WHERE D.DEPARTMENT_NAME LIKE '국어국문학과'
--GROUP BY S.STUDENT_NO, S.STUDENT_NAME
--HAVING ROUND(AVG(G.POINT),1) > 3
--ORDER BY ROUND(AVG(G.POINT),1) DESC

--18.
SELECT D.DEPARTMENT_NAME,  ROUND(AVG(G.POINT), 1)
FROM TB_STUDENT S
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_CLASS C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO)
WHERE D.CATEGORY LIKE (SELECT CATEGORY
                        FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NAME LIKE '환경조경학과')
        AND C.CLASS_TYPE LIKE '전공%'
GROUP BY D.DEPARTMENT_NAME
ORDER BY 1;


