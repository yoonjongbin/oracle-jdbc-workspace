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
SELECT S.STUDENT_NO, S.STUDENT_NAME, G.POINT
FROM TB_STUDENT S
    JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE D.DEPARTMENT_NAME LIKE '음악학과'


--HAVING ROUND(AVG(G.POINT)) = (SELECT ROUND(AVG(G.POINT)) FROM TB_GRADE WHERE D.DEPARTMENT_NAME LIKE '음악학과');
;

