1)
CREATE TABLE User
(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  type ENUM('admin', 'normal')
)
ENGINE=INNODB;

mysql> INSERT INTO User(name, type)
    -> VALUES ('user1', 'admin'),
    -> ('user2', 'normal'),
    -> ('user3', 'normal'),
    -> ('user4', 'admin');
Query OK, 4 rows affected (0.11 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM User;
+----+-------+--------+
| id | name  | type   |
+----+-------+--------+
|  1 | user1 | admin  |
|  2 | user2 | normal |
|  3 | user3 | normal |
|  4 | user4 | admin  |
+----+-------+--------+
4 rows in set (0.00 sec)

//UPDATE
mysql> UPDATE User
    -> set type='admin'
    -> WHERE id=4;
Query OK, 1 row affected (0.47 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM User;
+----+-------+--------+
| id | name  | type   |
+----+-------+--------+
|  1 | user1 | admin  |
|  2 | user2 | normal |
|  3 | user3 | normal |
|  4 | user4 | admin  |
+----+-------+--------+
4 rows in set (0.00 sec)

//DELETE
mysql> DELETE
    -> FROM User
    -> WHERE id=4;
Query OK, 1 row affected (0.36 sec)

mysql> SELECT * FROM User;
+----+-------+--------+
| id | name  | type   |
+----+-------+--------+
|  1 | user1 | admin  |
|  2 | user2 | normal |
|  3 | user3 | normal |
+----+-------+--------+
3 rows in set (0.00 sec)


/////////////////////////////////////////////////////////////////////////////
CREATE TABLE Category
(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  type ENUM('a', 'b', 'c', 'd') NOT NULL
)
ENGINE=INNODB;

mysql> INSERT INTO Category
    -> VALUES (NULL, 'a'),
    -> (NULL, 'b'),
    -> (NULL, 'c'),
    -> (NULL, 'd');
Query OK, 4 rows affected (0.40 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Category;
+----+------+
| id | type |
+----+------+
|  1 | a    |
|  2 | b    |
|  3 | c    |
|  4 | d    |
+----+------+
4 rows in set (0.00 sec)


//UPDATE
mysql> UPDATE Category
    -> SET type='c'
    -> WHERE id=4;
Query OK, 1 row affected (0.07 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Category;
+----+------+
| id | type |
+----+------+
|  1 | a    |
|  2 | b    |
|  3 | c    |
|  4 | c    |
+----+------+
4 rows in set (0.00 sec)

//DELETE
mysql> DELETE
    -> FROM Category
    -> WHERE id=4;
Query OK, 1 row affected (0.11 sec)

mysql> SELECT * FROM Category;
+----+------+
| id | type |
+----+------+
|  1 | a    |
|  2 | b    |
|  3 | c    |
+----+------+
3 rows in set (0.00 sec)

/////////////////////////////////////////////////////////////////////////////
CREATE TABLE Article
(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  author_id INT NOT NULL,
  title VARCHAR(50) NOT NULL,
  category_id INT NOT NULL,
  content TEXT,
  FOREIGN KEY (author_id) REFERENCES User (id),
  FOREIGN KEY (category_id) REFERENCES Category(id)
)
ENGINE=INNODB;

//INSERT
mysql> INSERT INTO Article(author_id, title, category_id, content)
    -> VALUES (2, 'title1', 3, 'content1'),
    -> (3, 'title2', 1, 'content2'),
    -> (3, 'title3', 3, 'content3'),
    -> (2, 'title4', 2, 'content4'),
    -> (1, 'title5', 2, 'content5');
Query OK, 5 rows affected (0.38 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Article;
+----+-----------+--------+-------------+----------+
| id | author_id | title  | category_id | content  |
+----+-----------+--------+-------------+----------+
|  1 |         2 | title1 |           3 | content1 |
|  2 |         3 | title2 |           1 | content2 |
|  3 |         3 | title3 |           3 | content3 |
|  4 |         2 | title4 |           2 | content4 |
|  5 |         1 | title5 |           2 | content5 |
+----+-----------+--------+-------------+----------+
5 rows in set (0.00 sec)

//UPDATE
mysql> UPDATE Article
    -> set title='titleNew'
    -> WHERE title='title5';
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Article;
+----+-----------+----------+-------------+----------+
| id | author_id | title    | category_id | content  |
+----+-----------+----------+-------------+----------+
|  1 |         2 | title1   |           3 | content1 |
|  2 |         3 | title2   |           1 | content2 |
|  3 |         3 | title3   |           3 | content3 |
|  4 |         2 | title4   |           2 | content4 |
|  5 |         1 | titleNew |           2 | content5 |
+----+-----------+----------+-------------+----------+
5 rows in set (0.00 sec)


//DELETE
mysql> delete
    -> FROM Article
    -> WHERE id=5;
Query OK, 1 row affected (0.09 sec)

mysql> SELECT * FROM Article;
+----+-----------+--------+-------------+----------+
| id | author_id | title  | category_id | content  |
+----+-----------+--------+-------------+----------+
|  1 |         2 | title1 |           3 | content1 |
|  2 |         3 | title2 |           1 | content2 |
|  3 |         3 | title3 |           3 | content3 |
|  4 |         2 | title4 |           2 | content4 |
+----+-----------+--------+-------------+----------+
4 rows in set (0.00 sec)



/////////////////////////////////////////////////////////////////////////////
CREATE TABLE Comment
(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  article_id INT NOT NULL,
  commenter_id INT NOT NULL,
  content TINYTEXT,
  FOREIGN KEY (article_id) REFERENCES Article(id),
  FOREIGN KEY (commenter_id) REFERENCES User(id)
)
ENGINE=INNODB;

mysql> INSERT INTO Comment(article_id, commenter_id, content)
    -> VALUES (2, 1, 'comment1'),
    -> (3, 1, 'comment2'),
    -> (3, 1, 'comment3'),
    -> (3, 3, 'comment4'),
    -> (1, 3, 'comment5'),
    -> (2, 3, 'comment6'),
    -> (2, 3, 'comment7'),
    -> (3, 1, 'comment8');
Query OK, 8 rows affected (0.37 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Comment;
+----+------------+--------------+----------+
| id | article_id | commenter_id | content  |
+----+------------+--------------+----------+
|  1 |          2 |            1 | comment1 |
|  2 |          3 |            1 | comment2 |
|  3 |          3 |            1 | comment3 |
|  4 |          3 |            3 | comment4 |
|  5 |          1 |            3 | comment5 |
|  6 |          2 |            3 | comment6 |
|  7 |          2 |            3 | comment7 |
|  8 |          3 |            1 | comment8 |
+----+------------+--------------+----------+
8 rows in set (0.00 sec)

//UPDATE
mysql> UPDATE Comment
    -> SET content='commentNew'
    -> WHERE id=8;
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Comment;
+----+------------+--------------+------------+
| id | article_id | commenter_id | content    |
+----+------------+--------------+------------+
|  1 |          2 |            1 | comment1   |
|  2 |          3 |            1 | comment2   |
|  3 |          3 |            1 | comment3   |
|  4 |          3 |            3 | comment4   |
|  5 |          1 |            3 | comment5   |
|  6 |          2 |            3 | comment6   |
|  7 |          2 |            3 | comment7   |
|  8 |          3 |            1 | commentNew |
+----+------------+--------------+------------+
8 rows in set (0.01 sec)

//DELETE
mysql> DELETE
    -> FROM Comment
    -> WHERE id=8;
Query OK, 1 row affected (0.11 sec)

mysql> SELECT * FROM Comment;
+----+------------+--------------+----------+
| id | article_id | commenter_id | content  |
+----+------------+--------------+----------+
|  1 |          2 |            1 | comment1 |
|  2 |          3 |            1 | comment2 |
|  3 |          3 |            1 | comment3 |
|  4 |          3 |            3 | comment4 |
|  5 |          1 |            3 | comment5 |
|  6 |          2 |            3 | comment6 |
|  7 |          2 |            3 | comment7 |
+----+------------+--------------+----------+
7 rows in set (0.00 sec)


/////////////////////////////////////////////////
2)

without_variables:-

mysql> SELECT Article.id, Article.title, Article.category_id, Article.content
    -> FROM Article JOIN User
    -> on Article.author_id=User.id
    -> WHERE User.name='user3';
+----+--------+-------------+----------+
| id | title  | category_id | content  |
+----+--------+-------------+----------+
|  2 | title2 |           1 | content2 |
|  3 | title3 |           3 | content3 |
+----+--------+-------------+----------+
2 rows in set (0.00 sec)


with variable:-

mysql> SELECT @user_id:=id
    -> FROM User
    -> WHERE name='user3';
+--------------+
| @user_id:=id |
+--------------+
|            3 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT id, title, category_id, content
    -> FROM Article
    -> WHERE author_id=@user_id;
+----+--------+-------------+----------+
| id | title  | category_id | content  |
+----+--------+-------------+----------+
|  2 | title2 |           1 | content2 |
|  3 | title3 |           3 | content3 |
+----+--------+-------------+----------+
2 rows in set (0.00 sec)


/////////////////////////////////////////////////
3)

without subquery:-
mysql> SELECT Article.id AS article_id , Article.content AS article_content, Comment.id AS comment_id,  Comment.content AS comment_content
    -> FROM Article JOIN User
    -> ON Article.author_id=User.id
    -> JOIN Comment
    -> ON Comment.article_id=Article.id
    -> WHERE User.name='user3';
+------------+-----------------+------------+-----------------+
| article_id | article_content | comment_id | comment_content |
+------------+-----------------+------------+-----------------+
|          2 | content2        |          1 | comment1        |
|          2 | content2        |          6 | comment6        |
|          2 | content2        |          7 | comment7        |
|          3 | content3        |          2 | comment2        |
|          3 | content3        |          3 | comment3        |
|          3 | content3        |          4 | comment4        |
+------------+-----------------+------------+-----------------+
6 rows in set (0.00 sec)

using subquery:-
mysql> SELECT Article.id AS article_id , Article.content AS article_content, Comment.id AS comment_id,  Comment.content AS comment_content
    -> FROM Article JOIN Comment
    -> ON Comment.article_id=Article.id
    -> WHERE author_id =
    -> (
    -> SELECT id
    -> FROM User
    -> WHERE name='user3'
    -> );
+------------+-----------------+------------+-----------------+
| article_id | article_content | comment_id | comment_content |
+------------+-----------------+------------+-----------------+
|          2 | content2        |          1 | comment1        |
|          2 | content2        |          6 | comment6        |
|          2 | content2        |          7 | comment7        |
|          3 | content3        |          2 | comment2        |
|          3 | content3        |          3 | comment3        |
|          3 | content3        |          4 | comment4        |
+------------+-----------------+------------+-----------------+
6 rows in set (0.00 sec)


/////////////////////////////////////////////////
4)

without subquery:-
mysql> SELECT Article.id, Article.title, Article.content
    -> FROM Article LEFT JOIN Comment
    -> on Article.id=Comment.article_id
    -> WHERE commenter_id IS NULL;
+----+--------+----------+
| id | title  | content  |
+----+--------+----------+
|  4 | title4 | content4 |
+----+--------+----------+
1 row in set (0.01 sec)

using subquery:-
mysql> SELECT Article.id, Article.title, Article.content
    -> FROM Article
    -> WHERE NOT EXISTS
    -> (
    ->   SELECT *
    ->   FROM Comment
    ->   WHERE Article.id = Comment.article_id
    -> );
+----+--------+----------+
| id | title  | content  |
+----+--------+----------+
|  4 | title4 | content4 |
+----+--------+----------+
1 row in set (0.00 sec)

/////////////////////////////////////////////////
5)

mysql> SELECT *
    -> FROM Article
    -> WHERE id = (
    -> SELECT article_id
    -> FROM Comment
    -> GROUP BY article_id
    -> ORDER BY count(*) DESC
    -> LIMIT 1
    -> );
+----+-----------+--------+-------------+----------+
| id | author_id | title  | category_id | content  |
+----+-----------+--------+-------------+----------+
|  2 |         3 | title2 |           1 | content2 |
+----+-----------+--------+-------------+----------+
1 row in set (0.00 sec)



/////////////////////////////////////////////////
6)

mysql> SELECT temp.id, Article.title, Article.content
    -> FROM (
    -> SELECT Article.id, COUNT(*)  AS count
    -> FROM Article LEFT JOIN Comment
    -> ON Article.id=Comment.article_id
    -> GROUP BY Article.id
    -> )AS temp JOIN Article
    -> USING (id)
    -> GROUP BY temp.id
    -> HAVING MAX(count) <= 1;
+----+--------+----------+
| id | title  | content  |
+----+--------+----------+
|  1 | title1 | content1 |
|  4 | title4 | content4 |
+----+--------+----------+
2 rows in set (0.00 sec)
