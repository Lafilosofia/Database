#1.列值为null和不为null
#2.where条件查询
#查询没有上级领导的员工编号,姓名,工资
SELECT empno,ename,sal FROM emp WHERE mgr IS NULL;
#查询领导编号是7839的员工的信息
SELECT * FROM emp WHERE mgr = 7839;
#查询没有奖金的员工的信息
SELECT * FROM emp WHERE comm IS NULL;
#别名
SELECT empno AS e,ename AS n FROM emp;
SELECT empno AS "员工编号",ename AS "员工姓名" FROM emp;
#去重复 distinct
#查询emp表中的员工职位
SELECT DISTINCT job FROM emp; 
#比较运算符<> = ! (<>)
#查询工资高于两千的所有员工的编号姓名工资职位
SELECT empno,ename FROM emp WHERE sal > 2000;
#查询工资小于1600的所有员工的编号姓名工资职位
SELECT empno,ename,job,sal FROM emp WHERE sal < 1600;
#查询部门编号是20的所有员工的编号姓名工资职位
SELECT empno,ename,job,sal FROM emp WHERE deptno = 20;
#查询职位是manager的所有员工的姓名职位
SELECT ename,job FROM emp WHERE job = "MANAGER";
#查询部门编号不是10的所有员工的姓名工资,部门编号
SELECT ename,sal,deptno FROM emp WHERE deptno != 20;
#查询单价不等于4443的商品信息
SELECT * FROM t_item WHERE price != 4443;
#查询单价等于23的商品信息
SELECT * FROM t_item WHERE price = 23;
#and 和 or and等效&& or等效||
#查询不是十号部门工资小于的员工编号姓名工资部门编号
SELECT empno,ename,deptno,sal FROM emp WHERE deptno != 10 AND sal < 3000;
#查询部门是30或者上级领导为7689的所有员工的姓名部门编号,领导编号
SELECT empno,ename,deptno,mgr FROM emp WHERE deptno = 30 OR mgr = 7689;
#in 如果查询字段的值为多个可以使用多个关键字
#查询emp中部门编号为20,10的员工编号姓名部门编号
SELECT empno,ename,deptno FROM emp WHERE deptno IN(10,20);
#查询员工工资是800,950,1600的员工姓名和工资
SELECT empno,ename,sal FROM emp WHERE sal IN(800,950,1600);
#查询员工工资是800,950,1600的员工姓名和工资
SELECT empno,ename,sal FROM emp WHERE sal NOT IN (800,950,1600);