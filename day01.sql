/*
1.查看数据库: cmd 输入 mysql -uroot -p

 			  退出: exit;

2.查看所有数据库: show databases;

3.切换数据库: use 数据库名;

4.查看该数据库中的所有表: show tables;

5.查看表结构: show create table 表名;

6.创建数据库: create database 库名;

7.删除数据库: drop database 库名;

8.创建数据库并指定字符集: create database 库名 character set utf8/gbk;

9.创建表: create table 表名(id int,name varchar(10),age int);

10.插入数据: insert into 表名 (id,name,age)  values (1,"张三",20);

​			或者: insert into 表名 values (1,"张三",20);

11.设置字符集: set names utf8/gbk;

12.插入部分数据: insert into 表名 (字段) values (对应字段的数据);

13.批量插入: insert into 表名 (id,name,age) values (1,"张三",21),(2,"李四",22),()......;插入数据用逗号隔开,最后以分号结束.

14.查询表中所有数据: select 字段 from 表名;

15.查询表中的name字段: select name from 表名;

16.删除表中的数据: delete from 表名 where 字段 = 具体数据;

删除表: drop table 表名;

MySQL使用教程: https://www.runoob.com/mysql/mysql-tutorial.html


##### 1.创建表emp

​	create table emp(empnp int,ename varchar(10));

##### 2.修改表名  

​	rename table  旧表名 to 新表名; 

​	例如将emp表名修改为t_emp: rename table emp to t_emp;

##### 3.在员工名的前面添加年龄字段(age),此处column可以省略不写

​	alter table t_emp add column age int;

##### 4.在t_emp表中员工名字后面添加字段(dept);

​	例如:alter table t_emp add dept int(11) after ename;

##### 5.在员工编码后面添加sal字段

​	例如:;alter table t_emp add sal int(11) after empno;

##### 6.将t_emp的sal字段删除

​	例如:alter table t_emp drop column sal;

###### change的使用(原来的字段 更换为 新的字段 新的类型)

##### 7.把t_emp表中的dept字段更换为dept2 并且类型为字符串char

​	例如:alter table t_emp change dept dept2 varchar(12);

##### 8.把t_emp表中的dept2字段更换为dept 并且类型为整型int

​	例如:alter table t_emp modify dept2 int(10);

##### 9.修改位置dept2字段在empno后面

​	例如:alter table t_emp modify dept2 int(10) after empno;



#### PRIMARY KEY AUTO_INCREMENT 主键自增

##### 1.创建表 t_emp2 id name id要求自增长

​	例如 create table t_emp2(id int primary key auto_increment,name varchar(10));

##### 2.在t_emp2表中添加字段age

​	alter table t_emp age int;

##### 3.在t_emp2表中插入三条数据


##### 1.创建表emp

​	create table emp(empnp int,ename varchar(10));

##### 2.修改表名  

​	rename table  旧表名 to 新表名; 

​	例如将emp表名修改为t_emp: rename table emp to t_emp;

##### 3.在员工名的前面添加年龄字段(age),此处column可以省略不写

​	alter table t_emp add column age int;

##### 4.在t_emp表中员工名字后面添加字段(dept);

​	例如:alter table t_emp add dept int(11) after ename;

##### 5.在员工编码后面添加sal字段

​	例如:;alter table t_emp add sal int(11) after empno;

##### 6.将t_emp的sal字段删除

​	例如:alter table t_emp drop column sal;

###### change的使用(原来的字段 更换为 新的字段 新的类型)

##### 7.把t_emp表中的dept字段更换为dept2 并且类型为字符串char

​	例如:alter table t_emp change dept dept2 varchar(12);

##### 8.把t_emp表中的dept2字段更换为dept 并且类型为整型int

​	例如:alter table t_emp modify dept2 int(10);

##### 9.修改位置dept2字段在empno后面

​	例如:alter table t_emp modify dept2 int(10) after empno;



#### PRIMARY KEY AUTO_INCREMENT 主键自增

##### 1.创建表 t_emp2 id name id要求自增长

​	例如 create table t_emp2(id int primary key auto_increment,name varchar(10));

##### 2.在t_emp2表中添加字段age

​	alter table t_emp age int;

##### 3.在t_emp2表中插入三条数据

​	insert into t_emp2 values(1,"测试",20);

##### 4.修改t_emp2表中年龄是20的名字为"李浩哲"

​	update t_emp set name = "李浩哲" where age = 20;

##### 5.删除

​    deleto table t_temp2;





*/