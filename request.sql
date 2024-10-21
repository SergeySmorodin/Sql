-- Название и продолжительность самого длительного трека.
SELECT name, duration
FROM track
ORDER BY duration DESC
LIMIT 1;

-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT name
FROM track
WHERE duration >= 210;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name
FROM compilation
WHERE releaseyear between 2018 and 2020

-- Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM artist 
WHERE name not like '% %';

-- Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM track
WHERE name LIKE '%мой%' OR name LIKE '%my%';

-- Количество исполнителей в каждом жанре.
SELECT g.Name AS GenreName, COUNT(DISTINCT ag.ArtistID) AS ArtistCount
FROM Genre g
LEFT JOIN ArtistGenre ag ON g.ID = ag.GenreID
GROUP BY g.ID, g.Name
ORDER BY g.Name;

-- Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(t.ID) AS TrackCount
FROM Track t
JOIN Album a ON t.AlbumID = a.ID
WHERE a.ReleaseYear BETWEEN 2019 AND 2020;

-- Средняя продолжительность треков по каждому альбому.
SELECT a.Name AS AlbumName, AVG(t.Duration) AS AverageDuration
FROM Album a 
LEFT JOIN Track t ON a.ID = t.AlbumID
GROUP BY a.ID, a.Name
ORDER BY a.Name;

-- Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT a.Name
FROM Artist a
LEFT JOIN ArtistAlbum aa ON a.ID = aa.ArtistID
LEFT JOIN Album al ON aa.AlbumID = al.ID AND al.ReleaseYear = 2020
WHERE al.ID IS NULL;

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.Name AS CompilationName
FROM Compilation c
JOIN CompilationTrack ct ON c.ID = ct.CompilationID
JOIN Track t ON ct.TrackID = t.ID
JOIN ArtistAlbum aa ON t.AlbumID = aa.AlbumID
JOIN Artist a ON aa.ArtistID = a.ID
WHERE a.Name = 'Nirvana';

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT a.Title AS AlbumTitle
FROM Album a
JOIN Track t ON a.AlbumId = t.AlbumId
JOIN Artist ar ON t.ArtistId = ar.ArtistId
JOIN Genre g ON ar.GenreId = g.GenreId
GROUP BY a.AlbumId, a.Title
HAVING COUNT(DISTINCT g.GenreId) > 1;



