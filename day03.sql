#between x and y 在某两个数值之间包含and两边的数值
#1.查询员工工资500-1000的所有员工名字和工资
SELECT ename,sal FROM emp WHERE sal >= 500 AND sal <= 1000;
SELECT ename,sal FROM emp WHERE sal BETWEEN 500 AND 1000;
#like 模糊查询 _代表单个位置的字符 %代表多个未知的字符
#2.查询名字以k开头的所有名字开头的员工名字
SELECT ename FROM emp WHERE ename LIKE "k%" ;
#3.查询名字第二个字母是m的所有员工名字
SELECT ename FROM emp WHERE ename LIKE "_m%";
#4.查询名字第三个字母是l的所有员工名字
SELECT ename FROM emp WHERE ename LIKE "__l%";
#5.查询名字倒数第二个字母是e的所有员工名字
SELECT ename FROM emp WHERE ename LIKE "%e_";
#6.查询单价低于100的记事本t_item
SELECT title,price FROM t_item WHERE price < 100 AND title LIKE "%记事本%";
#7.查询商品标题包含笔记本的商品
SELECT title FROM t_item WHERE title LIKE "%记事本%";
#8.查询有图片的得力商品
SELECT title FROM t_item WHERE title LIKE "%得力%" AND image IS NOT NULL;
#9.查询单价介于50-200之间的得力商品
SELECT title,price FROM t_item WHERE title LIKE "%得力%" AND price BETWEEN 50 AND 200;
#10.查询有赠品的得力商品
SELECT title FROM t_item WHERE title LIKE "%得力%" AND sell_point LIKE "%赠%";

#查询结果排序 order by 默认升序  指定升序asc 指定降序 desc
#11.查询员工的名称和工资,按照工资降序排序
SELECT ename,sal FROM emp ORDER BY sal DESC;
#12.查询单价在100以下的商品名称和价格,并按降序排列
SELECT title,price FROM t_item WHERE price < 100 ORDER BY price DESC;
#13.查询单价在100以下的记事本商品的名称和单价并升序排列
SELECT title,price FROM t_item WHERE title LIKE "%记事本%" AND price < 100 ORDER BY price;
#多个字段排序 当第1个字段有相同值时 第二个字段排序开始
#14.查询所有部门编号工资部门编号降序,工资升序
SELECT deptno,sal FROM emp ORDER BY deptno ASC,sal DESC; 
#15查询记事本商品的名字价格,价格在30-100,按照商品的分类降序排列,价格升序排列
SELECT price,title,category_id FROM t_item WHERE title  LIKE "%记事本%" AND price BETWEEN 30 AND 100 ORDER BY category_id DESC,price ASC;
#limit 分页查询
#跳过条数,查询条数 例如:每一页显示a条第y页则是limit a(x-1),y
#查询商品表中商品名称和价格第一页数据,每一页显示五条
SELECT title,price FROM t_item LIMIT 0,5;
#查询商品表中商品名称和价格第三页数据,每一页显示六条
SELECT title,price FROM t_item LIMIT 12,6;
#查询最高工资的员工信息
SELECT * FROM emp ORDER BY sal DESC LIMIT 0,1;
#查询第二个字母时l,工资小于等于两千多前两名员工信息
SELECT * FROM emp WHERE sal < 2000 ORDER BY sal DESC LIMIT 0,2; 
#数值计算 +-*/%(mod)
#查询所有商品的单价,库存,总价
SELECT price,num,price * num "总价" FROM t_item;
# % mod都是取余作用
SELECT (8 % 3);
SELECT (8 MOD 3);

#day03
#日期相关函数
#获取当前时间日期 now()
SELECT NOW();
#获取当前日期 curdate() 
SELECT CURDATE();
#获取当前时间 curtime();
SELECT CURTIME();
#从日期中提取时间
SELECT TIME(NOW());
#从日期中提取日期
SELECT DATE(NOW());
#1.查询商品创建的年月日
SELECT DATE(created_time) FROM t_item;
#2.查询商品的创建时间
SELECT TIME(created_time) FROM t_item;

#extract()函数用于返回日期/时间的单独部分,比如年月日时分秒  extract(unit from date)
#提取年
SELECT EXTRACT(YEAR FROM NOW());
#提取月
SELECT EXTRACT(MONTH FROM NOW());
#提取日
SELECT EXTRACT(DAY FROM NOW());
#提取时
SELECT EXTRACT(HOUR FROM NOW());
#提取分
SELECT EXTRACT(MINUTE FROM NOW());
#提取秒
SELECT EXTRACT(SECOND FROM NOW());
#3.查询入职的年份的员工的名字和年份
SELECT ename,EXTRACT(YEAR FROM hiredada) AS "年份" FROM emp;

#日期格式化 date_format(时间 格式)
# %Y:年份 %m:月份 %d:日 %H:时 %
#4.查询现在的时间
SELECT DATE_FORMAT (NOW(),"%Y-%m-%d  %H:%i:%s")"当前时间"; 
#5.查询商品的创建时间年月日
SELECT DATE_FORMAT(created_time,"%Y-%m-%d  %H:%i:%s") "创建时间" FROM t_item;
#6.把不规则的日期格式转为标准格式
SELECT STR_TO_DATE("23号10月2020年")

#ifnull() 格式age = ifnull(x,y) 判断x是否为null如果是返回null如果不是则返回age = y
#7.查询员工没有奖金的显示为0;
SELECT ename,IFNULL(comm,0) "奖金" FROM emp;
#8.把员工没有奖金的这些员工的奖金修改为0
UPDATE emp SET comm = IFNULL(comm,0);

#聚合函数 : 对多行数据进行合并统计
#sum() 函数返回数值列的总和
#avg() 函数返回数值列的平均值 null值不包含在计算内
#count() count(column name)函数返回指定列的值的数据,null值不计入
#max()函数返回一列中的最大值
#min()函数返回一列中的最小值
#9.查询员工的平均工资
SELECT AVG(sal) FROM emp;
#10.查询10号部门的最高工资
SELECT deptno,MAX(sal) FROM emp WHERE deptno = 10;
#11.查询dell商品的库存总和
SELECT title,SUM(num) FROM t_item WHERE title LIKE "%Dell%" ;
#12.查询得力商品的条数
SELECT COUNT(title) FROM t_item WHERE title LIKE "%得力%";
#13.查询员工姓名包含a的最低工资
SELECT ename,MIN(sal) FROM emp WHERE ename LIKE "%a%"; 