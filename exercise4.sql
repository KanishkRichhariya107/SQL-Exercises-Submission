CREATE TYPE user_role AS ENUM('admin', 'normal');

CREATE TABLE users(
	user_id INTEGER NOT NULL,	
	username VARCHAR(20),
	user_role user_role,
	PRIMARY KEY(user_id)
);

CREATE TABLE categories (
    category_id INTEGER NOT NULL,
    category_name VARCHAR(20),
    PRIMARY KEY (category_id)
);

CREATE TABLE articles(
	article_id INTEGER NOT NULL PRIMARY KEY,
	article_name VARCHAR(20),
	content TEXT,
	category_id INTEGER REFERENCES categories(category_id),
	user_id INTEGER REFERENCES users(user_id)
);

CREATE TABLE comments(
	comment_id INTEGER NOT NULL PRIMARY KEY,
	content TEXT NOT NULL,
	user_id INTEGER REFERENCES users(user_id),
	article_id INTEGER REFERENCES articles(article_id)
);
INSERT INTO users 
VALUES 
  (1, 'user1', 'normal'),
  (2, 'user2', 'admin'),
  (3, 'user3', 'normal'),
  (4, 'user4', 'admin'),
  (5, 'user5', 'admin');

INSERT INTO categories
VALUES
    (1, 'Educational'),
    (2, 'Technology'),
    (3, 'Fictional'),
    (4, 'Business');

INSERT INTO articles
VALUES
    (1, 'article1', 'content1', 1, 1),
    (2, 'article2', 'content2', 2, 1),
    (3, 'article3', 'content3', 3, 2),
    (4, 'article4', 'content4', 2, 2),
    (5, 'article5', 'content5', 4, 3),
    (6, 'article6', 'content6', 1, 3);

INSERT INTO comments
VALUES
    (1, 'comment1', 2, 1),
    (2, 'comment2', 3, 1),
    (4, 'comment4', 1, 2),
    (5, 'comment5', 1, 2),
    (6, 'comment6', 2, 2),
    (7, 'comment7', 3, 2);

UPDATE users
SET username = 'new_user1'
WHERE user_id = 1;

DELETE FROM comments
WHERE comment_id = 1;


-- QUERY 2
SELECT * 
FROM articles AS a
JOIN users AS u
On u.user_id = a.user_id
WHERE u.username = 'user3';

-- QUERY 3

-- WITHOUT USING SUBQUERRY

SELECT a.article_id, a.article_name, a.content, c.comment_id, c.content
FROM articles AS a
LEFT JOIN comments AS c
ON a.article_id = c.article_id
JOIN users AS u
On u.user_id = a.user_id
WHERE u.username = 'user3';


-- USING nested SUBQUERRY
SELECT * 
FROM articles AS a
LEFT JOIN comments AS c
ON a.article_id = c.article_id
Where a.article_id IN 
(  SELECT article_id
   FROM articles AS a2
   JOIN users AS u
   On u.user_id = a2.user_id
   WHERE u.username = 'user3'
);

-- QUERRY 4

--WITHOUT USING SUBQUERRY
SELECT *
FROM articles AS a
LEFT JOIN comments AS c
    ON a.article_id = c.article_id
WHERE c.comment_id IS NULL;

--USING SUBQUERRY

SELECT *
FROM articles AS a
WHERE a.article_id NOT IN 
(
   SELECT c.article_id
   FROM comments AS c
);

--QUERRY 5

SELECT a.article_id, a.article_name, COUNT(*) AS total_comments
FROM articles AS a
LEFT JOIN comments AS c
    ON a.article_id = c.article_id
GROUP BY a.article_id
ORDER BY COUNT(*) DESC
LIMIT 1;


-- QUERRY 6
SELECT a.article_id, a.article_name
FROM articles AS a
LEFT JOIN comments AS c
    ON a.article_id = c.article_id
WHERE c.comment_id IS NOT NULL
GROUP BY a.article_id
HAVING COUNT(c.comment_id) = COUNT(DISTINCT c.user_id);