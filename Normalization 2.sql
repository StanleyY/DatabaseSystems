DROP TABLE IF EXISTS movieActors;
DROP TABLE IF EXISTS movieDirectors;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS movies;

CREATE TABLE people (
pid SERIAL,
fname VARCHAR(20),
lname VARCHAR(20),
address VARCHAR(40),
PRIMARY KEY (pid)
);

CREATE TABLE actors (
aid INT REFERENCES people(pid),
birthday DATE,
hairColor VARCHAR(20),
eyeColor VARCHAR(20),
height INT,
weight INT,
guildAnniversary DATE,
PRIMARY KEY (aid)
);

CREATE TABLE directors (
did INT REFERENCES people(pid),
school VARCHAR(40),
guildAnniversary DATE,
PRIMARY KEY (did)
);

CREATE TABLE movies (
mid SERIAL,
title VARCHAR(40),
year INT,
domesticSales FLOAT4,
foreignSales FLOAT4,
videoSales FLOAT4,
PRIMARY KEY (mid)
);

CREATE TABLE movieActors(
mid INT REFERENCES movies,
aid INT REFERENCES actors(aid),
PRIMARY KEY (mid, aid)
);

CREATE TABLE movieDirectors(
mid INT REFERENCES movies,
did INT REFERENCES directors(did),
PRIMARY KEY (mid, did)
);

INSERT INTO people (fname, lname, address)
VALUES
('Sean', 'Connery', '007 Bond Drive'),
('George', 'Lazenby', '008 James Rad'),
('Roger', 'Moore', '009 Seven Street'),
('Terence', 'Young', 'Thunder Ave'),
('Guy', 'Hamilton', 'Live Path'),
('Lewis', 'Gilbert', 'Twice Street'),
('Peter', 'Hunt', 'Secret Street');

INSERT INTO actors(aid, birthday, hairColor, eyeColor, height, weight, guildAnniversary)
VALUES
(1, '1930-08-25', 'Black', 'Brown', '74', '200', '1954-04-18'),
(2, '1939-09-05', 'Black', 'Brown', '74', '180', '1965-09-17'),
(3, '1930-10-14', 'Black', 'Brown', '73', '195', '1945-04-18');

INSERT INTO directors(did, school, guildAnniversary)
VALUES
(4, 'University of Cambridge', '1940-04-10'),
(5, 'None', '1952-06-30'),
(6, 'None', '1966-07-04'),
(7, 'University of Rome', '1940-07-18');

INSERT INTO movies (title, year, domesticSales, foreignSales, videoSales)
VALUES
('Dr. No', 1962, 16.1, 43.5, 30.2),
('From Russia with Love', 1963, 24.8, 54.1, 41.5),
('Goldfinger', 1964, 51.1, 73.8, 79.1),
('Thunderball', 1965, 63.6, 77.6, 92.1),
('You Only Live Twice', 1967, 43.1, 68.5, 69.5),
('On Her Majesty''Secret Service', 1969, 22.8, 59.2, 32.4),
('Live and Let Die', 1973, 35.4, 91.0, 56.9);

INSERT INTO movieActors (mid, aid)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 2),
(7, 3);

INSERT INTO movieDirectors (mid, did)
VALUES
(1, 4),
(2, 4),
(3, 5),
(4, 4),
(5, 6),
(6, 7),
(7, 5);

SELECT * FROM people;
SELECT * FROM actors;
SELECT * FROM directors;
SELECT * FROM movies;

SELECT DISTINCT p.fname, p.lname
FROM
people p,
movies m,
directors d,
movieDirectors md
WHERE md.did = d.did AND m.mid = md.mid AND d.did = p.pid AND md.mid IN (SELECT m.mid
									 FROM
									 people p,
									 actors a,
									 movies m,
									 movieActors ma
									 WHERE p.pid = a.aid AND m.mid = ma.mid AND a.aid = ma.aid AND p.fname = 'Sean' AND p.lname = 'Connery'
									 );