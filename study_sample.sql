SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS, DEPARTMENT_NAME, CATEGORY 
FROM TB_STUDENT
INNER JOIN TB_DEPARTMENT 
ON(TB_STUDENT.DEPARTMENT_NO = TB_STUDENT.DEPARTMENT_NO);


SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS, DEPARTMENT_NAME, CATEGORY 
 	 	FROM TB_STUDENT
 	 	INNER JOIN TB_DEPARTMENT
 	 	ON(TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO);