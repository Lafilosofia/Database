#事物(transaction)
#为了完成某个业务而执行的一条或者多条sql语句,sql语句的最小逻辑工作单元,保证数据的完整性
#事物特性
#原子性:事物是一个完整的操作,事物的各项操作都不不能分开的
#持久性:事物完成后,它对数据库的修改将永久保存
#隔离性:并发事务之间彼此隔离,独立,他不应该以任何方式依赖于或影响 
#一致性:事物完成时,数据必须处于一致状态

/*
A数据库服务端(支付一方),B数据库服务端(接受一方)钱没收到,也就是数据没有提交到数据库中,这是必须需要事物来处理该问题
*/

CREATE TABLE bank(id INT PRIMARY KEY AUTO_INCREMENT,NAME VARCHAR(10),money DOUBLE );
INSERT INTO bank VALUES(NULL,"王云龙",1000),(NULL,"李浩哲",500);
#1.查询自动提交的状态1或者ON 则为自动提交 0或OFF则为手动提交
SHOW VARIABLES LIKE "autocommit";
#2.设置提交状态
SET autocommit = 0; #设置提交状态为手动
UPDATE bank SET money = money - 200 WHERE NAME = "王云龙";
UPDATE bank SET money = money + 200 WHERE NAME = "李浩哲";
#以上两条sql语句是在事物中执行的
SET autocommit = 1; #设置提交状态为自动

#回滚 rollback
INSERT INTO bank VALUES(NULL,"高轲",500),(NULL,"丁静君",500),(NULL,"张欣如",500),(NULL,"闫薇",500),(NULL,"坤哥",500);
COMMIT;
INSERT INTO bank VALUES(NULL,"高阶元素",1000);
DELETE 
ROLLBACK;

#约束:约束就是给表字段添加的限制条件
#添加非空约束字段的值不能为null
CREATE TABLE mytable (id INT PRIMARY KEY AUTO_INCREMENT,ename VARCHAR(10) NOT NULL);
INSERT INTO mytable  VALUES (NULL,NULL);
#unique 唯一
CREATE TABLE mytable1 (id INT PRIMARY KEY AUTO_INCREMENT,ename VARCHAR(10) UNIQUE NOT NULL);
INSERT INTO mytable1 VALUES (NULL,"测试1");
#主键约束:primary key添加了主键约束的字段,值不能为null,也不能重复
#一个表只能有一个主键
CREATE TABLE mytable2(id INT PRIMARY KEY);
INSERT INTO mytable2 VALUES(1);
#删除主键索引
SHOW CREATE TABLE mytable2;
ALTER TABLE mytable2 DROP PRIMARY KEY;
#外键约束是保证一个或两个表之间的参照完整性保持数据一致性
#表的外键可以另一张表的主键,这张表也可以是唯一约束
#外键有重复,可以为空
#references

#创建外键约束方式一
#年级表
CREATE TABLE classes(id INT PRIMARY KEY AUTO_INCREMENT,NAME VARCHAR(10));
#学生表
CREATE TABLE student(id INT PRIMARY KEY AUTO_INCREMENT ,NAME VARCHAR(10),class_id INT REFERENCES classes(id));

#创建外键约束方式二
CREATE TABLE student2(id INT PRIMARY KEY AUTO_INCREMENT ,NAME VARCHAR(10),classes_id INT CONSTRAINT pk_stu_id )

#索引:用来加快查询的技术很多,其中最重要的就是索引(index)
#1.通常索引能够快速提高查询速度
#2.如果不使用索引,MySQL必须从第一条记录开始然后读整个表直到找出相关的行,表越大,花费的时间越长
#索引可以用来改善性能,有时索引可能降低性能(如果表的数据很少就不需要添加索引,否则会降低性能)

#1.创建索引语法:create index 索引名字 on 表名(字段名)
#2.删掉索引语法:drop index 索引名 on 表名
#3.查看索引:show index from 表名

#在MySQL中选择数据库并且导入sql文件:例如:e盘下的sql文件item_backup.sql
#source e:/item_backup.sql;//此处不能执行,必须在黑框里面执行
#快速导入文件的方法:use store_ykt; 
#source 盘:/文件名.sql;//文件夹不要出现中文,此处为直接在盘里面存储的

SELECT COUNT(*) FROM item2;
SHOW INDEX feom emp;
SELECT * FROM item2 WHERE title="100";-- 非索引查询速度相比较慢,如果数据库大的话会严重影响速度
SELECT * FROM item2 WHERE id=21456;-- 索引查询速度很快

# 创建索引
CREATE INDEX index_num ON item2(num);
SELECT * FROM item2 WHERE num=857;

CREATE UNIQUE INDEX index_my2 ON mytable2(ename)
CREATE TABLE mytable2(id INT PRIMARY KEY AUTO_INCREMENT ,ename VARCHAR(10));
INSERT INTO mytable2 VALUES(NULL,"");

#按照下面标准选择建立索引列
#1.频繁搜索的列
#2.经常用作查询选择的列
#3.经常排序,分组的列
#4.经常用作连接的列(主键/外键)

#请不要使用下面的列创建索引
#1.仅包含几个不同值的列
#2.表中仅包含几行数据



/*主键,外键,索引的区别


	主键					外键						索引

	唯一标识一条记录,不能有   	  表的外键是另一张表的主键,			该字段没有重复值,但可以有一个空值
定义:	重复的,不允许为空         	  外键可以有重复的,可以有空值			(也可有重复值)


作用:	主键是用来保证数据完整性   	 是用来和其他建立联系用的			是提高查询,排序的速度	

个数:    主键只能有一个			一个表可以有多个外键				一个表可以有多个索引

*/

#系统变量
#说明:变量由系统提供,不是用户定义,属于服务器层面
#使用语法
#1查看所有系统变量
SHOW GLOBAL/SESSION  VARIABLES LIKE "%%";


#2查看全局变量
SHOW GLOBAL VARIABLES;
#查看会话变量session 可以省略
SHOW SESSION VARIABLES;
#查看全部分局变量带有"char"
SHOW GLOBAL VARIABLES LIKE "%char%";
#查看会话带有"char"
SHOW VARIABLES LIKE "%char%";

#3.查看指定的某个系统的变量
SELECT @@GLOBAL
#查看系统变量autocommit的值
SELECT @@global.autocommit;
#查看全局变量autocommit的值

#4.为某个系统变量赋值
#set @@global/session 系统变量的名 = 值;
#给全局变量autocommit赋值
SET @@global.autocommit = 0;
#给会话变量antocommit赋值
SET @@autocommit = 0;

/*自定义变量
@说明 变量是用户自定义的并不是由系统提供的
使用步骤
声明
赋值
使用(查看,比较,运算)

1.用户变量:
作用域:针对当前会话有效,等同于会话变量的作用域一样,只对当前有效
2.局部变量:
作用域:仅仅在定义它的begin in end中有效,必须应用在begin end 中的第一句话
*/

#声明并初始化用户变量
方式1 SET @用户变量名 = 值
      SET @aname = "坤哥";
#查看用户变量名
SELECT @ename;
方式2 SET @用户变量名 := 值;
      SET @pname := "呵呵";
      SELECT @pname;
      
#赋值:通过set或者select
#方式1: set @用户变量名 = 值
#方式2: set @用户变量名 =: 值
#方式3: select @用户变量名 =: 值
#方式4: 通过select into 
SELECT COUNT(*) INTO @c FROM emp;
SELECT @c;

/*
局部变量:
1.声明
declare 变量名 类型 default 值
2.赋值
set 局部变量 = 值;
3.查看
select 局部变量;
*/ 
DECLARE yname VARCHAR(10) DEFAULT 9;

DELIMITER $;
CREATE PROCEDURE my9();
BEGIN
#设置全局变量
DECLARE result VARCHAR(10) DEFAULT "";
SET result = "测试";
SELECT result;
END $

#案例
CREATE PROCEDURE my10(IN ename VARCHAR(10),IN pwd VARCHAR(10))
BEGIN
#声明局部变量
DECLARE result VARCHAR(10) DEFAULT "";
SELECT COUNT(*) INTO result FROM admin WHERE user_name = ename AND user_password = pwd;
SELECT IF(result > 0,"成功","失败");
END $

CALL my10("高阶","123456") $

#创建带inout模式参数的存储过程
#传入创建存储过程实现传入a和b两个值最终a和b都翻倍并返回

CREATE PROCEDURE my11(INOUT a INT,INOUT b INT)
BEGIN
SET a = a * 2;
SET b = b * 2;
END $ 

#设置变量
SET @x1 = 10;
SET @x2 = 20;

CALL my11(@x1,@x2) $
SELECT @x1,@x2 $

#创建存储过程实现根据员工编号查询员工的领导编号
CREATE PROCEDURE my12(INOUT n INT)
BEGIN
SELECT mgr INTO n FROM emp WHERE empno = n;
END $

SET @mgr = 7369 $