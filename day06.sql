#关联查询:同时查询多张表的数据
#等值连接:查询每一个员工姓名和所对应的部门名称和部门地址
#给表起别名,利用别名去访问对应表中的字段

#例:查看编号是7369的员工部门的部门信息和员工姓名,编号,工资,上级领导
SELECT dept.*,emp.ename,emp.sal,emp.mgr,emp.empno FROM emp,dept WHERE emp.deptno = dept.deptno AND emp.empno = 7369;
SELECT d.*,e.ename,e.sal,e.mgr,e.empno FROM emp e,dept d WHERE d.deptno = e.deptno AND e.empno = 7369;

#join on
#语法: select 字段1,字段2 from 表1 join 表2 on 两表共有字段
#等值连接格式:select * from a表,b表 where 表字段1 = 表字段2;
#内连接:select * from a表 inner join b表 on 表字段1 = 表字段2;
#1.查询每一个员工的姓名和所对应的部门名称和地址
SELECT e.ename,d.dname,d.loc FROM emp e JOIN dept d ON d.deptno = e.deptno;
#2.查询每个商品的标题,单价,分类名称
SELECT t_item_category.name,t_item.price FROM t_item JOIN t_item_category ON  t_item.category_id = t_item_category.id;
#3.查询在new york工作的所有员工信息
SELECT e.*,d.loc FROM dept d JOIN emp e ON d.deptno = e.deptno  AND dept.loc LIKE "%new york%";
#4.查询emp表中开头以s有上级领导的员工信息和所对应的部门名字和地址
SELECT e.*,d.loc,d.dname FROM dept d JOIN emp e ON d.deptno = e.deptno WHERE e.ename LIKE "s%" AND e.mgr IS NOT NULL;
#5.查询每个部门的平均工资,最高工资,以及他们的部门信息的最高平均工资的前两个部门
SELECT AVG(sal),MAX(sal),d.* FROM emp e JOIN dept d ON d.deptno = e.deptno GROUP BY e.deptno ORDER BY e DESC LIMIT 0,2; 

#外连接:关联查询时只查询两张表有关系的数据,不能满足需求,如果需要查询一张表的所有数据(包含没有关系的),则使用外连接关联查询
#左外连接:以join左边表为主要查询所有的数据,右边表只查询有关系的数据
#右外连接:以join右边表为主要查询所有的数据,左边表只查询有关系的数据
SELECT e.*,d.* FROM emp e RIGHT JOIN dept d ON d.deptno = e.deptno;

#1.查询所有员工的名字和对应所有部门名称
SELECT e.ename,d.dname FROM emp e LEFT JOIN dept d ON d.deptno = e.deptno;
#2.查询所有部门对应的员工名
SELECT e.ename,d.dname  FROM emp e  RIGHT JOIN dept d ON d.deptno = e.deptno;

#练习
#1.每个部门的人数,根据人数排名
SELECT COUNT(*),deptno FROM emp GROUP BY deptno ORDER BY COUNT(*); 
#2.每个部门中,每个主管手下的人数
SELECT COUNT(*),mgr,deptno FROM emp GROUP BY deptno,mgr;
#3.每种工作的平均工资按照平均工资降序排列前两名
SELECT AVG(sal),job FROM emp GROUP BY job ORDER BY AVG(sal) DESC LIMIT 0,2;
#4.每年入职的人数以降序排列
SELECT COUNT(*),hiredada FROM emp GROUP BY hiredada ORDER BY COUNT(*) DESC;
#5.少于等于3个人的部门
SELECT COUNT(*),deptno FROM emp GROUP BY deptno HAVING COUNT(*) <= 3;
#6.少于等于3个人的部门信息
SELECT COUNT(*),d.* FROM emp e,dept d WHERE e.deptno = d.deptno GROUP BY deptno HAVING COUNT(*) <= 3;
SELECT * FROM dept WHERE deptno IN (SELECT deptno FROM emp GROUP BY deptno HAVING COUNT(*) <= 3);
#7.拿最低工资的员工信息和所对应的部门号,部门名称
SELECT d.dname,e.* FROM emp e LEFT JOIN dept d ON d.deptno = e.deptno ORDER BY e.sal ASC LIMIT 0,1 ;
#8.只有一个下属的主管信息
/*子查询*/SELECT * FROM emp WHERE empno IN (SELECT mgr FROM emp WHERE mgr IS NOT NULL GROUP BY mgr HAVING COUNT(*) = 1);
/*自查表*/SELECT p.* FROM emp e JOIN emp p ON e.mgr = p.empno WHERE e.mgr IS NOT NULL GROUP BY e.mgr HAVING COUNT(*) = 1;
#9.平均工资最高的部门编号以及部门名称,按照平均工资升序排列
SELECT d.* FROM emp e JOIN dept d ON e.deptno = d.deptno GROUP BY e.deptno ORDER BY AVG(sal) DESC LIMIT 0,1;
#10.下属人数最多的领导的个人信息
SELECT * FROM emp WHERE empno = (SELECT mgr FROM emp WHERE mgr IS NOT NULL ORDER BY COUNT(*) DESC LIMIT 0,1);
SELECT p.* FROM emp e JOIN emp p ON e.deptno = p.deptno GROUP BY e.mgr ORDER BY COUNT(*) DESC LIMIT 0,1;
#11.拿最低工资的个人信息和部门名称
SELECT e.*,d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno GROUP BY sal  LIMIT 0,1;
#12.最后入职不是以s开头的员工编号,员工工资和部门信息
SELECT e.empno,e.sal,d.* 
#13.工资高于平均工资的员工信息及部门信息
SELECT e.*,d.* FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno WHERE sal > (SELECT AVG(sal) FROM emp);
#14.查询有领导的员工信息和部门名称
SELECT e.*,d.dname FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno WHERE e.mgr IS NOT NULL;
#15.查询员工不是以j开头的员工信息,部门名称,所在城市
SELECT e.*,d.dname,d.loc FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno WHERE ename NOT LIKE "J%";
#16.DALLAS市所有员工信息
SELECT e.*,d.loc FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno WHERE d.loc = "DALLAS";
#17.计算每个城市的员工数量
SELECT d.loc,COUNT(empno) FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno GROUP BY d.loc;
#18.查询员工信息和他的主管姓名
SELECT e.* FROM emp e JOIN emp p ON e.ename = p.mgr WHERE e.mgr IS NOT NULL;
#19.查询最低工资的员工信息,员工领导名字和部门名称
SELECT e.*,p.empno,p.ename,p.deptno,d.* FROM emp p LEFT JOIN dept d ON e.mgr = p.empno LEFT JOIN dept d ON p.deptno = d.deptno WHERE e.sal = (SELECT MIN(sal) FROM emp);
#20.平均工资最高的部门信息
SELECT d.* FROM emp e JOIN dept d ON e.deptno = d.deptno GROUP BY e.deptno HAVING AVG(sal) = (SELECT AVG(sal) a FROM emp e JOIN dept d ON e.deptno = d.deptno GROUP BY e.deptno ORDER BY a DESC LIMIT 0,1);
#21.查询员工表中所有员工的编号,姓名,职位,工资 根据工资进行升序排序的第三条到第六条员工信息
SELECT empno,ename,job,sal FROM emp ORDER BY sal LIMIT 2,4;
#22.查群员工表中所有员工的编号,姓名职位,工资以及该员工上级领导的编号姓名职位工资
SELECT e.empno,e.ename,e.job,e.sal,p.empno,p.ename,p.job,p.sal FROM emp e JOIN emp p ON e.mgr = p.empno;
#23.查询员工表中名字没有字母k的所有员工的编号姓名职位以及所在部门的编号,名称,地址
SELECT e.ename,e.empno,e.job,d.deptno,d.dname,d.loc FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE e.ename  NOT LIKE "%K%";
#24.查询部门表中所有的部门信息以及与之有关的员工表中员工的编号,姓名职位工资
SELECT d.*,e.ename,e.empno,e.job,e.sal FROM emp e JOIN dept d ON e.deptno = d.deptno;

#笛卡儿积
#关联查询 如果不写关联关系 则查询结果为两张表的乘积 这个乘积称之为笛卡儿积
#笛卡儿积是一种错误的查询结果 工作中不允许出现此现象