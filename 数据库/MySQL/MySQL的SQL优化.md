## MySQL的SQL优化

### InnoDB的表

在InnoDB存储引擎中，表都是根据主键顺序组织存放的。在InnoDB存储引擎表中，每张表都有个主键，如果在创建表的时没有显式地定义主键，InnoDB存储引擎会按照下面选择或者创建主键：

- 首先判断表中是否有非空的唯一索引，如果有，则该列即为主键（如果有多个的时候，选择第一个定义的唯一索引）；
- 如果不符合上述条件，InnoDB存储引擎自动创建一个6字节大小的指针。



**注意：**在建表的时候，最好还是指定主键，而且最好使用自增，而不是UUID这种作为主键，因为UUID一般都是无序的，在插入新的记录的时候，可能增加额外的开销。B+树为了维护索引的有序性，在插入新值得实惠需要做必要的维护。比如在某页数据中间插入某条数据，这时候就需要移动后面的数据，空出位置。如果碰到这一页数据满了，还需要申请新的数据页，挪动部分数据过去，这种过程称为页的分裂，这种情况就很影响性能。

### 硬件

#### 内存的重要性

InnoDB 存储引擎即缓存数据，又缓存索引，并且将它们缓存于一个很大的缓冲池中，即 InnoDB Buffer Pool。因此，内存的大小直接影响了数据的性能。

<<<<<<< HEAD
![](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/20190705232033.png)

从上面可以发现，随着缓冲池的增大，测试结果TPS会线性增长。

### 索引

对于索引的一些基本认识：
- 索引加快数据库查询速度；
- 表经常进行INSERT/UPDATE/DELETE操作就不要建立索引了，换言之：索引会降低插入、删除、修改等维护任务的速度；
- 索引的最左匹配原则
- 索引的分类：聚集索引和非聚集索引

#### 聚集索引

聚簇索引值主索引文件和数据文件为同一份文件，聚簇索引主要用在Innodb存储引擎中。在该索引实现方式中，B+tree的叶子节点上的data就是数据本身，key为主键，如果是一般索引的话，data便会指向对应的主索引。

#### 非聚集索引

非聚簇索引指的是B+Tree的叶节点上的data，并不是数据本身，而是数据存放的地址。主索引和辅助索引没啥区别，只是主索引的key一定是唯一的。主要用于MyIsAM存储引擎中。

#### 常见索引

- 单列索引：主键索引，唯一索引，普通索引
- 组合索引：联合索引



## =、in自动优化顺序

对于注意点最后一点，在MySQL中，对于索引会自动优化条件的顺序，方便匹配尽可能对的索引列。可以看下面一个实例：

```sql
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `password` varchar(64) NOT NULL COMMENT '密码',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(3) DEFAULT '1' COMMENT '状态, 1:启用,0:删除',
  `card` varchar(64) DEFAULT NULL COMMENT '身份证',
  `phone` varchar(64) DEFAULT NULL COMMENT '手机',
  PRIMARY KEY (`id`),
  KEY `index_user` (`name`,`password`,`card`,`phone`,`age`),
  FULLTEXT KEY `ft_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='用户表';
```



如上面创建一张表，并创建索引 `index_user`。
1、从上面的一个例子，我们可以看出，虽然我们查询条件并没有按照索引里面的顺序，但是查询还是走的是索引。

[![img](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/5588441b2b01cbb195c0ced1e2befe41.jpg)](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/5588441b2b01cbb195c0ced1e2befe41.jpg)

[![img](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/caa7c87b03ad3ed466176f31d0ec26c0.jpg)](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/caa7c87b03ad3ed466176f31d0ec26c0.jpg)

2、这个例子看出，下面这个查询没有走索引。可以注意点最后一点对照着看。

[![img](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/ab33d1e09a4c0bfe6b94ce2b023d5711.jpg)](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/ab33d1e09a4c0bfe6b94ce2b023d5711.jpg)

[![img](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/1b529270d16fe8934d39267f534aca06.jpg)](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/Qiniu/1b529270d16fe8934d39267f534aca06.jpg)

### 关于 EXPLAIN

在我们写SQL语句的时候，可以使用 EXPLAIN + SQL 来查看所写SQL的一些情况。

   **示查询中每个select子句的类型**

- SIMPLE(简单SELECT,不使用UNION或子查询等)

- PRIMARY(查询中若包含任何复杂的子部分,最外层的select被标记为PRIMARY)

- UNION(UNION中的第二个或后面的SELECT语句)

- DEPENDENT UNION(UNION中的第二个或后面的SELECT语句，取决于外面的查询)

- UNION RESULT(UNION的结果)

- SUBQUERY(子查询中的第一个SELECT)

- DEPENDENT SUBQUERY(子查询中的第一个SELECT，取决于外面的查询)

- DERIVED(派生表的SELECT, FROM子句的子查询)

- UNCACHEABLE SUBQUERY(一个子查询的结果不能被缓存，必须重新评估外链接的第一行)

type：表示mysql在表中找到所需行的方式，常用的类型有： **ALL< index <  range < ref < eq_ref < const < system < NULL（从左到右，性能从差到好）**

### 关于模糊查询

```sql
//创建一个索引
ALTER TABLE `user` ADD INDEX idx_name(name);
EXPLAIN SELECT * FROM user WHERE name LIKE '%est%';
```

![](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/20190630131920.png)

从上面的分析结果中，我们可以看出，对于这个SQL语句，我们是没有走索引的。对于模糊查询，应该知道，`est%`是会走索引的，但是在平时的使用中，我们基本都是全模糊的查询，而不是半个，这时候，我们就要使用到全文检索了。

**全文检索：**在之前的InnoDB中，是不支持全文索引的，只有MyIsAM存储引擎是支持的。但是在InnoDB 1.2x版本开始，也开始支持全文索引的了。

全文检索的语法是：MATCH(col1,col2,…) AGAINST(expr[search_modifier])

- MATCH：指定需要被查询的列
- AGAINST：指定了使用哪种方法区进行查询

下面是各种查询模式的介绍：

- Natural Language：全文检索通过MATCH函数进行查询，默认采用`Natural Language`模式，其表示查询带有指定word的文档。

- Boolean：MySQL 数据库允许使用 `IN BOOLEAN MODE` 修饰符来进行全文检索。当使用该修饰符时，查询字符串的前后字符会有特殊含义。

  > - `+ `：表示Word必须存在
  > - `-`  ：表示word必须排除
  > - `>`：表示出现单词是增加相关性
  > - `<`：表示出现该单词时降低相关性
  > - `~`：表示允许出现该单词，但是出现时相关性为负
  > - `*`表示以该单词开头的单词，入lik*，表示可以是 lik、like

```sql
ALTER TABLE `user` ADD FULLTEXT INDEX ft_name  (`name`);
//全文索引的查询语句
EXPLAIN SELECT * FROM user WHERE  MATCH(NAME) against('*est*' IN NATURAL LANGUAGE MODE);
```

![](https://hexo-1252893039.cos.ap-shanghai.myqcloud.com/20190630133235.png)

