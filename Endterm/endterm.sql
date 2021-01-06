create table Highschooler
(
    ID    int,
    name  text,
    grade int
);
create table Friend
(
    ID1 int,
    ID2 int
);
create table Likes
(
    ID1 int,
    ID2 int
);

/* Populate the tables with our data */
insert into Highschooler
values (1510, 'Jordan', 9);
insert into Highschooler
values (1689, 'Gabriel', 9);
insert into Highschooler
values (1381, 'Tiffany', 9);
insert into Highschooler
values (1709, 'Cassandra', 9);
insert into Highschooler
values (1101, 'Haley', 10);
insert into Highschooler
values (1782, 'Andrew', 10);
insert into Highschooler
values (1468, 'Kris', 10);
insert into Highschooler
values (1641, 'Brittany', 10);
insert into Highschooler
values (1247, 'Alexis', 11);
insert into Highschooler
values (1316, 'Austin', 11);
insert into Highschooler
values (1911, 'Gabriel', 11);
insert into Highschooler
values (1501, 'Jessica', 11);
insert into Highschooler
values (1304, 'Jordan', 12);
insert into Highschooler
values (1025, 'John', 12);
insert into Highschooler
values (1934, 'Kyle', 12);
insert into Highschooler
values (1661, 'Logan', 12);

insert into Friend
values (1510, 1381);
insert into Friend
values (1510, 1689);
insert into Friend
values (1689, 1709);
insert into Friend
values (1381, 1247);
insert into Friend
values (1709, 1247);
insert into Friend
values (1689, 1782);
insert into Friend
values (1782, 1468);
insert into Friend
values (1782, 1316);
insert into Friend
values (1782, 1304);
insert into Friend
values (1468, 1101);
insert into Friend
values (1468, 1641);
insert into Friend
values (1101, 1641);
insert into Friend
values (1247, 1911);
insert into Friend
values (1247, 1501);
insert into Friend
values (1911, 1501);
insert into Friend
values (1501, 1934);
insert into Friend
values (1316, 1934);
insert into Friend
values (1934, 1304);
insert into Friend
values (1304, 1661);
insert into Friend
values (1661, 1025);
insert into Friend
select ID2, ID1
from Friend;

insert into Likes
values (1689, 1709);
insert into Likes
values (1709, 1689);
insert into Likes
values (1782, 1709);
insert into Likes
values (1911, 1247);
insert into Likes
values (1247, 1468);
insert into Likes
values (1641, 1468);
insert into Likes
values (1316, 1304);
insert into Likes
values (1501, 1934);
insert into Likes
values (1934, 1501);
insert into Likes
values (1025, 1101);

-- 1
SELECT Highschooler.name
FROM Highschooler
         INNER JOIN Friend ON Highschooler.ID = Friend.ID1
         INNER JOIN Highschooler Highschooler2 ON Highschooler2.ID = Friend.ID2
WHERE Highschooler2.name = 'Gabriel';


-- 2
SELECT Highschooler.name, Highschooler.grade, Highschooler2.name, Highschooler2.grade
FROM Highschooler
         INNER JOIN Likes ON Highschooler.ID = Likes.ID1
         INNER JOIN Highschooler Highschooler2 ON Highschooler2.ID = Likes.ID2
WHERE (Highschooler.grade - Highschooler2.grade) >= 2;

-- 3
SELECT Highschooler.name, Highschooler.grade
FROM Highschooler,
     (SELECT ID2 ID, count(ID1) ID_2
      FROM Likes
      GROUP BY ID2) L
WHERE Highschooler.ID = L.ID
  AND L.ID_2 > 1;

-- 4
SELECT Highschooler.name, Highschooler.grade
FROM Highschooler
WHERE ID NOT IN (
    SELECT ID1
    FROM Friend,
         Highschooler Highschooler2
    WHERE Highschooler.ID = Friend.ID1
      AND Highschooler2.ID = Friend.ID2
      AND Highschooler.grade <> Highschooler2.grade
)
ORDER BY grade, name;

-- 5
SELECT Highschooler.name, Highschooler.grade, Highschooler.name, Highschooler.grade
FROM Highschooler,
     Highschooler Highschooler2,
     Likes L1,
     Likes L2
WHERE (Highschooler.ID = L1.ID1 AND Highschooler2.ID = L1.ID2)
  AND (Highschooler2.ID = L2.ID1 AND Highschooler.ID = L2.ID2)
  AND (Highschooler.name < Highschooler2.name)
ORDER BY Highschooler.name, Highschooler2.name;
