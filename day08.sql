#3.创建带out模式的存储模式
#创建存储过程实现查询员工编号对应的名字 
CREATE PROCEDURE my5(IN empno INT,OUT ename VARCHAR(10))
BEGIN
SELECT emp.ename INTO ename FROM emp WHERE emp.empno = empno; 
END $
#调用
CALL my5(7521,@NAME) $
SELECT @NAME $
#查询@n的返回数据
SELECT @n $

#创建存储过程或函数实现传入一个日期,格式化为xx年xx月xx日并返回
CREATE PROCEDURE my6(IN mydate DATETIME,OUT str_date VARCHAR(15))
BEGIN 
SELECT DATE_FORMAT(mydate,"%Y年%m月%d日") INTO str_date;
END $ 

CALL my6("2020-10-01",@DATE)

#4.创建带有inout的存储过程
#创建存储过程实现根据员工名字查询员工的名字
CREATE PROCEDURE my7(INOUT ename VARCHAR(10))
BEGIN
SELECT emp.ename INTO ename FROM emp WHERE emp.ename = ename;
END $

#5.删除存储过程
#drop procedure 存储过程名 
DROP PROCEDURE my7;

#查看所有数据库中的存储过程
SHOW PROCEDURE STATUS;

#查询表中指定的存储过程信息
SHOW CREATE PROCEDURE 存储过程名
SHOW CREATE PROCEDURE my6;

#视图:数据库存在多种对象,表和视图都是数据库中的对象,创建视图时名称不能和表名重名,
#     视图实际上是代表了一段sql查询语句,可以理解成视图是一张虚拟的表,表中的数据会随着原表的改变而改变
#为什么要使用视图
#有些数据的查询需要书写大量的sql语句,每次书写比较麻烦,使用视图可以起到sql重用的作用,可以隐藏敏感信息