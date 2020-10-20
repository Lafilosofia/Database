#1.创建表person
CREATE TABLE person (id INT PRIMARY KEY AUTO_INCREMENT ,pname VARCHAR(10),gender CHAR(2),rel VARCHAR(5));
#2.给person表插入数据
INSERT INTO person VALUES (NULL,"周润发","男","三姑父"),(NULL,"蔡依林","女","二姨"),(NULL,"成龙","男","大舅"),(NULL,"特朗普","男","侄子"),(NULL,"默克尔","女","外甥女");
SELECT * FROM person;
#3.创建表trade
CREATE TABLE trade (d INT PRIMARY KEY AUTO_INCREMENT,t_time DATE,t_money DOUBLE,t_type VARCHAR(5),pid INT);
#4.给trade表插入数据
INSERT INTO trade VALUES(NULL,"2018-02-14",1000,"微信",1),(NULL,"2018-02-15",300,"现金",2),(NULL,"2018-02-15",1500,"支付宝",3),(NULL,"2018-02-15",-20,"支付宝",4),(NULL,"2018-02-16",-600,"现金",5);
SELECT * FROM trade;
#新增数据
INSERT INTO person VALUES(NULL,"刘德华","男","四姨父"),(NULL,"普金","男","老丈人");
新增数据
INSERT INTO trade VALUES(NULL,"2018-02-19",150,"微信",6),(NULL,"2018-02-20",80,"现金",7);
#5.统计从2018年春节到现在的收益多少红包
SELECT SUM(t_money) FROM trade WHERE t_time >= "2018-02-15"; 
#6.查询从2018年春节到现在收红包大于100元的所有女性亲戚的名字和对应的红包金额
SELECT p.pname,t.t_money FROM trade t JOIN person p ON t.pid = p.id WHERE p.gender = "女" AND t.t_money > 100 AND t.t_time >= 2018-02-15;
#7.查询统计现金,支付宝,微信三个平台分别收到的红包金额
SELECT t_type,SUM(t_money) FROM trade WHERE t_ money > 0 GROUP BY t;

#权限管理
#三张主表 用户表 角色表 权限表
#两个关系 用户角色关系表 角色权限关系表

#创建用户表
CREATE TABLE USER(id INT PRIMARY KEY AUTO_INCREMENT,ename VARCHAR(10),age INT);
#插入用户数据
INSERT INTO USER VALUES(NULL,"测试1",20),(NULL,"测试2",21),(NULL,"测试3",22),(NULL,"测试3",23);

#创建角色表
CREATE TABLE role(id INT PRIMARY KEY AUTO_INCREMENT,rname VARCHAR(10),create_time TIMESTAMP);
#插入角色数据
INSERT INTO role VALUES(NULL,"管理员",NOW()),(NULL,"店小二",NOW()),(NULL,"用户",NOW());

#创建用户角色
CREATE TABLE user_role(id INT PRIMARY KEY AUTO_INCREMENT,user_id INT,role_id INT);
#插入用户角色数据
INSERT INTO user_role VALUES(NULL,1,3),(NULL,2,1),(NULL,3,3),(NULL,4,2);

SELECT u.*,r.*,e.* FROM USER u JOIN user_role r ON u.id = r.user_id JOIN role e ON e.id = role.id;
#查询出用户以及它所对应的角色
SELECT 