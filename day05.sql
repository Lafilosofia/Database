#分组查询 group by:分组查询,通常和聚合函数结合使用(为聚合函数服务),查询条件中每个xx就以xx作为分组的条件
#1.查询每个部门的最高工资的员工
SELECT deptno,ename,MAX(sal) "该部门最高工资" FROM emp GROUP BY deptno;
#2.查询每个分类下商品的库存总量
SELECT category_id,SUM(num) FROM t_item GROUP BY category_id;
#3.查询每个部门有多少人
SELECT deptno,COUNT(empno) "部门人数" FROM emp GROUP BY deptno;
#4.查询每个部门工资大于2000的有多少人
SELECT deptno,COUNT(empno) FROM emp WHERE sal > 2000 GROUP BY deptno;
#5.查询每个分类下低于100元的商品数量
SELECT category_id,COUNT(id) "商品数量" FROM t_item WHERE price < 100 GROUP BY category_id;
#6.查询emp表中每个部门的编号,人数,工资总和,最后根据人数进行升序排列,工资总和的降序排列
SELECT deptno,COUNT(empno) c,SUM(sal) s FROM emp GROUP BY deptno ORDER BY c ASC, s DESC;
#7.查询工资在1000-3000的每个部门的编号,平均工资,最低工资,最高工资,根据平均工资进行升序排列
SELECT deptno,AVG(sal) a,MIN(sal),MAX(sal) FROM emp WHERE sal BETWEEN 1000 AND 3000 GROUP BY deptno ORDER BY a;
#8.查询含有上级领导的员工,每个职业的人数,工资的总和,平均工资,最低工资,根据人数进行降序,平均工资升序排列
SELECT job,COUNT(empno) c,SUM(sal),AVG(sal) a,MIN(sal) FROM emp WHERE mgr IS NOT NULL GROUP BY job ORDER BY c DESC, a;
#9.查询每个部门,每个主管的手下人数
SELECT EXTRACT(YEAR FROM hiredada) e, deptno,mgr,COUNT(empno) "人数" FROM emp WHERE mgr IS NOT NULL GROUP BY deptno,mgr;
#10.查询每年的入职人数

#having有条件的分组统计 
#where后面只能对普通字段进行筛选
#having写在group by后面,通常是和group by结合使用
#普通字段的条件写在where后面,聚合函数条件写在having后面,having写在group by后面
#where条件用于过滤行,having子句用于过滤分组数据
#1.查询每个部门的平均工资要求平均工资大于2000
SELECT AVG(sal) a,deptno FROM emp GROUP BY deptno HAVING a > 2000; 
#2.查询所有分类对应的库存总和,要求库存总量高于100000
SELECT SUM(num) s,category_id FROM t_item GROUP BY category_id HAVING s > 100000;
#3.查询所有分类对应的平均单价低于100的分类
SELECT category_id,AVG(price) a FROM t_item GROUP BY category_id HAVING a < 100; 
#4.查询每个部门中名字包含"A"的员工的平均工资只显示平均工资高于2000的
SELECT AVG(sal) a,deptno FROM emp WHERE ename LIKE "%A%" GROUP BY deptno HAVING a > 2000;

#案例
#1.查询emp中每个部门平均工资高于2000的部门编号,部门人数,平均工资,根据平均工资升序排列
SELECT deptno,COUNT(*) c,AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal) > 2000 ORDER BY AVG(sal); 
#2.查询emp表中,名字不是以K开头的信息,每个部门的最低工资低于1000的部门编号,工资总和,平均工资和最低工资,根据平均工资升序排列
SELECT deptno,SUM(sal),AVG(sal),MIN(sal) FROM emp WHERE ename NOT LIKE "K%" GROUP BY deptno HAVING MIN(sal) < 1000 ORDER BY AVG(sal);
#3.查询emo表中部门编号是10,30的部门的员工,每个职业中的最高工资低于5000的职业名称,人数,平均工资,最高工资,根据人数升序,工资降序
SELECT job,COUNT(*),MAX(sal),AVG(sal) FROM emp WHERE deptno = 10 OR deptno = 30 GROUP BY job HAVING MAX(sal) < 5000 ORDER BY COUNT(*) ASC,sal DESC; 
#4.查询emp表中工资在1000-3000每个部门的编号,工资总和,平均工资,过滤掉平均工资低于2000的部门,平均工资升序,工资总和降序
SELECT deptno,SUM(sal),AVG(sal) FROM emp WHERE sal BETWEEN 1000 AND 3000 GROUP BY deptno HAVING AVG(sal) >= 2000 ORDER BY AVG(sal) ASC,SUM(sal) DESC;

#子查询
#1.查询最高工资的员工姓名,工资和部门
  #(1)员工工资最高多少
  SELECT MAX(sal) FROM emp;
  #(2)查询最高工资的员工姓名工资和部门
  SELECT ename,sal,deptno FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);
#2.查询工资高于平均工资的员工姓名,工资,部门上级领导
SELECT ename,sal,deptno,mgr FROM emp WHERE sal > (SELECT AVG(sal) FROM emp) AND mgr IS NOT NULL;
#3.查询最后入职年份的员工信息
SELECT * FROM emp WHERE EXTRACT(YEAR FROM hiredada) = (SELECT MAX(EXTRACT(YEAR FROM hiredada)) FROM emp);
#4.查询出有商品的分类信息(有商品指在商品表中出现过的类)
SELECT DISTINCT category_id FROM t_item WHERE category_id IS NOT NULL;
#5.查询id为238,241,236,163,917的分类信息
SELECT * FROM t_item WHERE category_id IN (SELECT DISTINCT category_id FROM t_item WHERE category_id IS NOT NULL);
#6.查询出有员工编号的员工信息
SELECT * FROM emp WHERE empno IN (SELECT DISTINCT empno FROM emp WHERE empno IS NOT NULL);
#7.查询工资高于20号部门里面最高工资的所有员工信息
SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno IN (SELECT deptno FROM emp WHERE deptno = 20 )) ;
SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 20);
#8.查询名字和"JONES"一样职位的员工信息
SELECT * FROM emp WHERE job IN (SELECT job FROM emp WHERE ename = "JONES" ) AND ename != "JONES";
#9.查询部门的平均工资最高的部门信息
SELECT * FROM dept WHERE deptno = (SELECT detpno FROM emp ORDER BY deptno)

#总结:
#1.什么是子查询? 嵌套在sql语句里面的查询sql语句称为子查询
#2.子查询可以有多层嵌套
#3.写在where/having后面做查询条件的值
SELECT 员工表的员工姓名,部门表的部门名称,部门表的部门地址 FROM emp,dept WHERE emp.deptno = dept.deptno;

#关联查询:同时查询多张表的数据
#等值连接:查询每一个员工姓名和所对应的部门名称和部门地址
#给表起别名,利用别名去访问对应表中的字段

#例:查看编号是7369的员工部门的部门信息和员工姓名,编号,工资,上级领导
SELECT dept.*,emp.ename,emp.sal,emp.mgr,emp.empno FROM emp,dept WHERE emp.deptno = dept.deptno AND emp.empno = 7369;
SELECT d.*,e.ename,e.sal,e.mgr,e.empno FROM emp e,dept d WHERE d.deptno = e.deptno AND e.empno = 7369;