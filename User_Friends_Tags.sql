CREATE DATABASE friends;

\c friends

CREATE TABLE users(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE friends(
    user_id INTEGER NOT NULL REFERENCES users(id),
    friend_id INTEGER NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE images(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    image_user INTEGER NOT NULL REFERENCES users(id),
    filename VARCHAR(100)
);

CREATE TABLE tags(
   image_id INTEGER NOT NULL REFERENCES images(id),
   tagged_user INTEGER NOT NULL REFERENCES users(id),
   PRIMARY KEY(image_id, tagged_user)
);

INSERT INTO users (name)
VALUES
('Dev'),
('Kanishk'),
('Deepanshu'),
('Rudransh'),
('Kartik');

INSERT INTO friends (user_id, friend_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 3),
(3, 1),
(3, 5),
(4, 1),
(4, 5)

INSERT INTO images (image_user, filename)
VALUES
(1, 'image1.jpg'),
(1, 'image2.jpg'),
(2, 'image3.jpg'),
(3, 'image4.jpg'),
(4, 'image5.jpg');

INSERT INTO tags (image_id, tagged_user)
VALUES
(1, 2),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 5),
(4, 1),
(4, 2),
(4, 5),
(5, 1),
(5, 5);


-- QUERRY 1

SELECT image_id, COUNT(*) as tagged_count
FROM tags 
GROUP BY image_id
ORDER BY tagged_count DESC
LIMIT 1;

--QUERRY 2

SELECT *
FROM friends as f
LEFT JOIN images as i
ON f.friend_id = i.image_user
WHERE f.user_id = 1;

--QUERRY 3

SELECT u.id, u.name
from users AS u
LEFT Join friends AS f
ON f.friend_id = u.id
LEFT JOIN images as i
on i.image_user = f.friend_id
LEFT JOIN tags as t
ON i.id = t.image_id
AND t.tagged_user = 1
WHERE f.user_id = 1
GROUP BY u.id, u.name
HAVING COUNT(DISTINCT i.id) = COUNT(distinct t.image_id);

--QUERRY 4

WITH taggs_count AS (SELECT u.id,u.name, count(DISTINCT (t.image_id)) as tagged_count
FROM users AS u
LEFT JOIN friends as f
ON f.friend_id = u.id
LEFT JOIN images as i
ON i.image_user = u.id
LEFT JOIN tags as t
ON t.image_id = i.id AND t.tagged_user = 1
WHERE f.user_id = 1
GROUP BY u.id,u.name)

SELECT * 
FROM taggs_count
WHERE tagged_count IN (
  SELECT MAX(tagged_count)
  FROM taggs_count
);