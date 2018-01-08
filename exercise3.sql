1)
CREATE TABLE User
(
  Name VARCHAR(20) PRIMARY KEY NOT NULL
  Type ENUM('admin', 'normal')
)
ENGINE=INNODB;

CREATE TABLE Category
(
  CID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Type VARCHAR(20) NOT NULL
)
ENGINE=INNODB;

CREATE TABLE Article
(
  AID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  AuthorName VARCHAR(20) REFERENCES User(Name),
  Title VARCHAR(50) NOT NULL,
  CategoryId INT NOT NULL REFERENCES Category(CID),
  Content TEXT
)
ENGINE=INNODB;

CREATE TABLE Comment
(
  CID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ArticleID INT NOT NULL REFERENCES Article(AID),
  UserName VARCHAR(20) NOT NULL REFERENCES User(Name),
  Content TINYTEXT
)
ENGINE=INNODB;


/////////////////////////////////////////////////
2)
without variables:-
  SELECT *
  FROM Article
  WHERE AuthorName='user3';

with variable:-
  SELECT @user_name:=AuthorName
  FROM Article
  WHERE AuthorName='user3';

  SELECT *
  FROM Article
  WHERE AuthorName=@user_name

/////////////////////////////////////////////////
3)
without subquery:-
  SELECT ArticleID, CID, Comment.content
  FROM Article JOIN Comment
    on Article.AID=Comment.ArticleID
  WHERE Article.AuthorName='user3';

using subquery:-
  SELECT ArticleID, CID, Comment.content
  FROM Comment
  WHERE ArticleID in
  (
    SELECT AID
    FROM Article
    WHERE AuthorName='user3'
  )

/////////////////////////////////////////////////
4)
without subquery:-
  SELECT Article.AID
  FROM Article LEFT JOIN Comment
    on Article.AID=Comment.authorID
  WHERE Comment.CID=null;

with suquery:-
  SELECT Article.AID
  FROM Article as a
  WHERE not exists
  (
    SELECT *
    FROM Comment as c
    WHERE c.authorID=a.AID;
  );

/////////////////////////////////////////////////
5)
SELECT max(ArticleID)
FROM Comment

/////////////////////////////////////////////////
6)
  SELECT Comment.ArticleID
  FROM User LEFT JOIN Comment
    on User.name=Comment.UserName
  group by User.name, Comment.articleID
  having count(*) <=1;
