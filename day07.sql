#流程控制函数
#if函数:在java中if else的效果类似于三目运算
#三目运算:10>5"大":"小"
SELECT IF(10 > 5,"大","小");
#案例
#1.查询员工奖金,奖金是0显示"没有奖金",否则显示"有奖金"
SELECT empno,IF(comm = 0,"没有奖金","有奖金") "有无奖金" FROM emp;

#case函数的使用,类似于java中的swith case的效果
#java中的
/*
swith(变量)
	case 变量:语句
	break;
	case 变量:语句
	break;
	default;
*/
#在mysql中,case要判断的字段或表达式
/*
when常量1 then显示的值或语句
when常量2 then显示的值或语句
...
else要显示的值或语句
end
*/

#2.查询员工表中员工编号和工资,部门是10号的员工工资提高十倍,20号部门的员工的工资提高0.1倍
SELECT empno,sal "原始工资",deptno,CASE deptno WHEN 10 THEN sal * 10 WHEN 20 THEN sal * 0.1 ELSE sal END "提高后的工资" FROM emp;
/*
case
when 条件1 then 要显示的值或语句
when 条件2 then 要显示的值或语句
...
else 要显示的值或语句
end
*/

#3.查询员工的工资情况,如果工资大于3000显示"A"级别,如果工资大于2000显示"B"级别,如果工资大于1000显示"C"级别,否则显示"D"级别
SELECT sal,CASE WHEN sal > 3000 THEN "A" WHEN sal > "2000" THEN "B" WHEN sal > 1000 THEN "C" ELSE "D" END  "工资类别" FROM emp; 

#存储过程和函数
#存储过程和函数类似于java中的方法
#好处:1.提高代码的重用性
#     2.简化操作
#     3.减少编译次数并减少了和数据库服务器的连接次数,提高了效率
#注意:一般的存储过程处理sal的增删改
#含义:一组预先编译好的sql语句集合,理解成批处理语句

/*1.创建语法 
create procedure 存储过程名(参数列表)
begin
存储过程体(一组合法的sql语句)
end

注意:
参数列表包含三部分:参数模式,参数名,参数类型
例如in username varchar(10)

参数模式:
in该参数可以作为输入,也就是该参数需要调用方传入值
out该参数可以作为输出,也就是该参数可以作为返回值
inout该参数可以作为输入又可以作为输出,也就是该参数既需要传入值有需要返回值
存储过程中的每条sql语句的结果要求必须加分号,存储过程的结果可以使用delimiter重新设置 delimiter重新标记
例如 delimiter$ (sqlyog不支持)
*/

#调用方法
#call 存储过程名(参数列表)
#1.空参列表
#创建admin表
CREATE TABLE admin(user_name VARCHAR(10),user_password VARCHAR(10));
#创建存储过程
CREATE PROCEDURE my1()
BEGIN
 INSERT INTO admin VALUES("Lafi","123456"),("La","654321");
END $

CALL my1() $

#2.创建in模式参数的存储过程(in 可以省略 但是不建议省略)
#创建存储过程实现查询对应的员工信息
CREATE PROCEDURE my2(IN deptno INT)
BEGIN
SELECT * FROM emp WHERE emp.deptno = deptno;
END $

#传参数
CALL my2(30) $

#创建存储过程实现数据传入的条目数和起始索引,查询emp表中的记录
CREATE PROCEDURE my3(IN size INT,IN startIndex INT)
BEGIN
SELECT * FROM emp LIMIT startIndex,size;
END $

#创建存储过程实现用户是否登录成功
CREATE PROCEDURE my4(IN ename VARCHAR(10),IN pwd VARCHAR(10))
BEGIN 
SELECT IF ((SELECT count(*) FROM admin WHERE admin.user_name = ename AND admin.user_password = pwd) > 0,"成功","失败");
END $

CALL my4("La","654321")$