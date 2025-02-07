CREATE TABLE BRANCH (
		BRANCHNO	INT CONSTRAINT PK_BRANCH_BRANCHNO PRIMARY KEY,
		BRANCHNAME  VARCHAR2(20) NOT NULL,
		LOCATION    VARCHAR2(20) NOT NULL 
	);
    
CREATE TABLE DEPT    (
		DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
		DNAME VARCHAR2(14), 
		BRANCHNO	INT CONSTRAINT FK_DEPT_BRANCHNO REFERENCES BRANCH
	) ;
    
ALTER TABLE DEPT
    MODIFY DNAME VARCHAR2(14) NOT NULL UNIQUE;
    

CREATE TABLE EMP(
		EMPNO 		NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
		ENAME 		VARCHAR2(10),
		JOB 		VARCHAR2(9),
		MGR 		NUMBER(4),
		HIREDATE 	DATE,
		SAL 		NUMBER(7,2),
		COMM 		NUMBER(7,2),
		DEPTNO 		NUMBER(2) CONSTRAINT FK_EMP_DEPTNO REFERENCES DEPT,
		BRANCHNO 	INT CONSTRAINT FK_EMP_BRANCHNO REFERENCES BRANCH
	);   
    	
    INSERT INTO BRANCH VALUES 	(101,'Geneva','NEW YORK');
	INSERT INTO BRANCH VALUES 	(102,'Geneva','NEW YORK');
	INSERT INTO BRANCH VALUES 	(103,'CHICAGO','CHICAGO');
	INSERT INTO BRANCH VALUES 	(104,'CHICAGO','CHICAGO');
	INSERT INTO BRANCH VALUES 	(105,'Kingston','NEW YORK');
	INSERT INTO BRANCH VALUES 	(106,'Kingston','NEW YORK');
    
    INSERT INTO DEPT VALUES	(10,'ACCOUNTING',101);
	INSERT INTO DEPT VALUES        (20,'RESEARCH',103);
	INSERT INTO DEPT VALUES	(30,'SALES',105);
	INSERT INTO DEPT VALUES	(40,'OPERATIONS',106);
    
INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20,102);
INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30,102);
INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30,103);
INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20,104);
INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30,105);
INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30,105);
INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10,102);
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20,103);
INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,NULL,101);
INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30,104);
INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20,105);
INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30,103);
INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20,105);
INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10,104);
INSERT INTO EMP VALUES(7901,'JOHN_SMITH','CLERK',7698,to_date('23-1-1982','dd-mm-yyyy'),3000,NULL,30,104);

COMMIT;


--1. Display all the information of the EMP table?
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO,BRANCHNO FROM EMP;


--2. Display unique Jobs from EMP table?
SELECT DISTINCT JOB FROM EMP;


--3. List the emps in the asc order of their Salaries?
SELECT ENAME,SAL from EMP ORDER BY SAL;



--4.List the details of the emps in asc order of the Dptnos and desc of Jobs?
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO,BRANCHNO FROM EMP ORDER BY DEPTNO, JOB DESC;


--5.Display all the unique job groups in the descending order?
SELECT DISTINCT JOB from EMP ORDER BY JOB DESC;


--6.Display all the details of all �Mgrs�
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO,BRANCHNO FROM EMP WHERE JOB='MANAGER';



--7. List the emps who joined before 1981
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO,BRANCHNO FROM EMP WHERE HIREDATE<'01-01-81';



--8. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
select EMPNO,ENAME,SAL,SAL/30,SAL*12 ANNSAL from EMP ORDER BY ANNSAL asc;



--9.Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
SELECT EMPNO,ENAME,JOB,HIREDATE,(SYSDATE-HIREDATE)/365 FROM EMP WHERE JOB='MANAGER';



--10. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,(SYSDATE-HIREDATE)/365 FROM EMP WHERE MGR=7369;



--11.Display all the details of the emps whose Comm  Is more than their Sal
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE COMM>SAL;



--12. List the emps along with their Exp and Daily Sal is more than Rs 100
SELECT EMPNO,(SYSDATE-HIREDATE)/365,SAL/30 FROM EMP WHERE SAL/30>100;



--13.List the emps who are either �CLERK� or �ANALYST� in the Desc order
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE JOB IN('CLERK','ANALYST');


--14.List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE HIREDATE IN( '01-05-80','3-12-81','17-12-81','19-01-80') ORDER BY HIREDATE ASC;



--15. List the emp who are working for the Deptno 10 or20
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE DEPTNO IN(10,20);



--16. List the emps who are joined in the year 81
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE TO_CHAR(HIREDATE,'YY')='81';



--17.List the emps Who Annual sal ranging from 22000 and 45000
SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE SAL*12 BETWEEN 22000 AND 45000;



--18. List the Enames those are having five characters in their Names
SELECT EMPNO, ENAME FROM EMP WHERE LENGTH(ENAME)=5 ORDER BY ENAME;



--19.List the Enames those are starting with �S� and with five characters
SELECT EMPNO, ENAME FROM EMP WHERE ENAME  LIKE 'S%' AND LENGTH(ENAME)=5 ORDER BY EMPNO;



--20.List the emps those are having four chars and third character must be �r�
SELECT EMPNO,EMPNO FROM EMP WHERE LENGTH(ENAME)=4 AND ENAME LIKE'%_RR%';



--21. List the Five character names starting with �S� and ending with �H�
SELECT EMPNO,ENAME FROM EMP WHERE LENGTH(ENAME)=4 AND ENAME LIKE'S%H';



--22. List the emps who joined in January
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='01';



--23.List the emps whose names having a character set �ll� together
SELECT EMPNO,ENAME from EMP WHERE ENAME LIKE'%LL%'; 



--24.List the emps who does not belong to Deptno 20
SELECT EMPNO,ENAME ,DEPTNO FROM EMP WHERE DEPTNO!=20;



--25.List all the emps except �PRESIDENT� & �MGR� in asc order of Salaries
SELECT EMPNO,ENAME,JOB,MGR FROM EMP WHERE JOB!='PRESIDENT' ORDER BY MGR;



--26. List the emps whose Empno not starting with digit78
SELECT EMPNO,ENAME FROM EMP WHERE EMPNO NOT LIKE '78%';



--27. List the emps who are working under �MGR
SELECT EMPNO,ENAME,MGR,JOB FROM EMP WHERE MGR=(SELECT DISTINCT(MGR) FROM EMP WHERE JOB='MANAGER');



--28.List the emps who joined in any year but not belongs to the month of March
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')!='03';



--29. List all the Clerks of Deptno 20
SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WHERE JOB='CLERK' AND DEPTNO='20';



--30.List the emps of Deptno 30 or 10 joined in the year 1981
SELECT
    empno,ename,hiredate,deptno FROM EMP WHERE (deptno=30 OR deptno=10) AND TO_CHAR(hiredate,'YYYY')=1981    
ORDER BY
    empno;
    
    

--31. Display the details of SMITH
 SELECT EMPNO,ENAME,JOB,HIREDATE,MGR,COMM,SAL,DEPTNO,BRANCHNO FROM EMP WHERE ENAME='SMITH';


--32. Display the location of SMITH
SELECT LOCATION FROM EMP e ,BRANCH b WHERE e.ENAME='SMITH' AND e.BRANCHNO=b.BRANCHNO;


 





    