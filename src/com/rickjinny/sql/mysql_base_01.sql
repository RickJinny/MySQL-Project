

-- 第一部分：数据库的操作

    -- 1、链接数据库
    mysql -uroot -p
    mysql -uroot -p123456

    -- 2、退出数据库
    exit / quit / ctrl + d

    -- 3、sql语句最后需要有分号;结尾

    -- 4、显示数据库版本
    select version();

    -- 5、显示时间
    select now();

    -- 6、查看所有数据库
    show databases;

    -- 7、创建数据库
    -- create database 数据库名 charset=utf8;
    create database test;
    create database test charset=utf8;

    -- 8、查看创建数据库的语句
    -- show crate database ....
    show create database test;

    -- 9、查看当前使用的数据库
    select database();

    -- 10、使用数据库
    -- use 数据库的名字
    use test;

    -- 11、删除数据库
    -- drop database 数据库名;
    drop database test;



-- 第二部分：数据表的操作

    -- 1、查看当前数据库中所有表
    show tables;

    -- 2、创建表
    -- auto_increment 表示自动增长
    -- not null 表示不能为空
    -- primary key 表示主键
    -- default 默认值
    -- create table 数据表名字 (字段 类型 约束[, 字段 类型 约束]);
    create table xxxxx(id int, name varchar(20));
    create table yyyyy(id int primary key not null auto_increment, name varchar(20));
    create table zzzzz(
        id int primary key not null auto_increment,
        name varchar(20)
    );

    -- 3、查看表结构
    -- desc 数据表的名字;
    desc xxxxx;

    -- 创建students表(id、name、age、high、gender、cls_id)
    create table students(
        id int unsigned not null auto_increment primary key,
        name varchar(20),
        age tinyint unsigned default 0,
        high decimal(5,2),
        gender enum("男", "女", "保密") default "保密",
        cls_id int unsigned
    );

    insert into students values(0, "张三", 18, 188.88, "男", 0);
    select * from students;

    -- 创建classes表(id、name)
    create table classes(
        id int unsigned not null auto_increment primary key,
        name varchar(20)
    );

    insert into classes values(0, "Java大神");
    select * from classes;

    -- 4、查看表的创建语句
    -- show create table 表名字;
    show create table students;

    -- 5、修改表-添加字段
    -- alter table 表名 add 列名 类型;
    alter table students add birthday datetime;

    -- 6、修改表-修改字段：不重命名版
    -- alter table 表名 modify 列名 类型及约束;
    alter table students modify birthday date;

    -- 7、修改表-修改字段：重命名版
    -- alter table 表名 change 原名 新名 类型及约束;
    alter table students change birthday birth date default "1990-01-01";

    -- 8、修改表-删除字段
    -- alter table 表名 drop 列名;
    alter table students drop high;

    -- 9、删除表
    -- drop table 表名;
    -- drop database 数据库;
    -- drop table 数据表;
    drop table xxxxx;

    
-- 第三部分：增删改查(curd)

    -- 1、增加
        -- 全列插入
        -- insert [into] 表名 values(...)
        -- 主键字段 可以用 0  null   default 来占位
        -- 向classes表中插入 一个班级
        insert into classes values(0, "A班");

        +--------+-------------------------------------+------+-----+------------+----------------+
        | Field  | Type                                | Null | Key | Default    | Extra          |
        +--------+-------------------------------------+------+-----+------------+----------------+
        | id     | int(10) unsigned                    | NO   | PRI | NULL       | auto_increment |
        | name   | varchar(20)                         | YES  |     | NULL       |                |
        | age    | tinyint(3) unsigned                 | YES  |     | 0          |                |
        | gender | enum('男','女','保密')                | YES  |     | 保密       |                |
        | cls_id | int(10) unsigned                    | YES  |     | NULL       |                |
        | birth  | date                                | YES  |     | 1990-01-01 |                |
        +--------+-------------------------------------+------+-----+------------+----------------+

        -- 向students表插入 一个学生信息
        insert into students values(0, "小王", 28, "男", 1, "1990-01-01");
        insert into students values(null, "小王", 28, "男", 1, "1990-01-01");
        insert into students values(default, "小王", 28, "男", 1, "1990-01-01");

        -- 失败
        -- insert into students values(default, "小王", 28, "第4性别", 1, "1990-08-01");

        -- 枚举中 的 下标从1 开始 1---“男” 2--->"女"....
        insert into students values(default, "小王", 20, 1, 1, "1990-08-01");

        -- 部分插入
        -- insert into 表名(列1,...) values(值1,...)
        insert into students (name, gender) values ("小张", 2);


        -- 多行插入
        insert into students (name, gender) values ("小赵", 2),("小李", 2);
        insert into students values(default, "小红", 23, "女", 1, "1990-01-01"), (default, "小明", 27, "男", 1, "1990-01-01");


    -- 2、修改
    -- update 表名 set 列1=值1,列2=值2... where 条件;
        update students set gender=1; -- 全部都改
        update students set gender=1 where name="小王"; -- 只要name是小王的 全部的修改
        update students set gender=1 where id=3; -- 只要id为3的 进行修改
        update students set age=23, gender=1 where id=3; -- 只要id为3的 进行修改
    
    -- 3、查询基本使用
        -- 查询所有列
        -- select * from 表名;
        select * from students;

        ---定条件查询
        select * from students where name="小王"; -- 查询 name为小王的所有信息
        select * from students where id>3; -- 查询 name为小王的所有信息

        -- 查询指定列
        -- select 列1,列2,... from 表名;
        select name,gender from students;

        -- 可以使用as为列或表指定别名
        -- select 字段[as 别名] , 字段[as 别名] from 数据表 where ....;
        select name as 姓名,gender as 性别 from students;

        -- 字段的顺序
        select id as 序号, gender as 性别, name as 姓名 from students;
    

    -- 4、删除
        -- 物理删除
        -- delete from 表名 where 条件
        delete from students; -- 整个数据表中的所有数据全部删除
        delete from students where name="小王";

        -- 逻辑删除
        -- 用一个字段来表示 这条信息是否已经不能再使用了
        -- 给students表添加一个is_delete字段 bit 类型
        alter table students add is_delete bit default 0;
        update students set is_delete=1 where id=3;




