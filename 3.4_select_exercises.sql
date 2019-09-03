use albums_db;
describe albums;
SELECT name FROM albums WHERE artist = 'Pink Floyd';
SELECT release_date FROM albums WHERE name LIKE 'Sgt.%';
SELECT genre FROM albums WHERE name LIKE 'Never%';
SELECT name, release_date FROM albums WHERE release_date between 1989 and 1999;
SELECT name, sales FROM albums WHERE sales < 20;
SELECT name, genre FROM albums WHERE genre = 'Rock';
SELECT name, genre FROM albums WHERE genre LIKE '%Rock%'