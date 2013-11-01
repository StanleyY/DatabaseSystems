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
pid INT REFERENCES people,
birthday DATE,
hairColor VARCHAR(20),
eyeColor VARCHAR(20),
height INT,
weight INT,
guildAnniversary DATE,
PRIMARY KEY (pid)
);

CREATE TABLE directors (
pid INT REFERENCES people,
school VARCHAR(20),
guildAnniversary DATE,
PRIMARY KEY (pid)
);

CREATE TABLE movies (
mid SERIAL,
title VARCHAR(20),
year INT,
domesticSales INT,
foreignSales INT,
videoSales INT,
PRIMARY KEY (mid)
);

CREATE TABLE movieActors(
mid INT REFERENCES movies,
actor INT REFERENCES actors(pid),
PRIMARY KEY (mid, actor)
);

CREATE TABLE movieDirectors(
mid INT REFERENCES movies,
director INT REFERENCES directors(pid),
PRIMARY KEY (mid, director)
);

INSERT INTO people (fname, lname, address)
VALUES
('Sean', 'Connery', '007 Bond St')