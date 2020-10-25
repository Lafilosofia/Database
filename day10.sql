/*
数据备份和恢复
为什么进行数据备份
1.数据库故障
2.突然断电
3.病毒入侵
4.错误操作导致数据丢失

使用mysqldump命令备份数据
1.将create和insert into语句保存到文本文件中
2.它属于dos命令

备份数据库中所有数据语法
语法:mysqldump -u root(数据库账号) -p数据库密码 -h ip地址 数据库名>备份位置和备份文件名称
例如:备份数据库store_ykt的所有数据 备份在磁盘D中
mysqldump -u root -pXIR712LHZ -h lacalhost store_ykt>D;\1.sql

备份数据库中部分表数据
语法:mysqldump -u root(数据库账号) -p数据库密码 -h ip地址 数据库名 表1 表2 ......>备份位置和备份文件名称
例如:备份数据库store_ykt的员工部门表 备份在D盘中
mysqldump -u root -pXIR712LHZ -h lacalhost store_ykt emp dept>D;\1.sql

备份数据库中表中的部分数据
首先进入mysql客户端
例如:备份员工表中有奖金的全部员工数据
语法: select * from emp where comm != 0 into outfile "备份位置和备份的文件名"


数据的恢复
使用mysql命令恢复数据
例如把D盘中的1.sql恢复到数据库copydb中
1.创建数据库copydb
create database copydb;
语法mysql -u 数据库账号 -p数据库密码 数据库 <所要恢复的数据




*/