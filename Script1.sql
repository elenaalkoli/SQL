 
SELECT * FROM Artist a 
LIMIT 5;
SELECT * FROM Album a
LIMIT 5;

--Вывод Названия альбома и название группы из таблиц Album, Artist
SELECT Title, Name   FROM Album a
INNER JOIN  Artist a2  ON a.ArtistId = a2.ArtistId 

-- Количество альбомов с выводом его названия, для которых количество жанров >=2
SELECT Title from Album a inner join Track t ON t.AlbumId =a.AlbumId 
GROUP BY a.AlbumId 
HAVING count (DISTINCT GenreId)>=2

-- Вывести покупателей, которые оформили заказы в месяце первыми (к примеру, для предоставления дальнейшей скидки)
SELECT * FROM Customer c 
LIMIT 10;
SELECT * FROM Invoice i 
LIMIT 10;

--В табл. Customer берем CustomerId, FirstName, LastName, в Invoice - InvoiceId, CustomerId, InvoiceDate (но даты не разбиты по месяцам - разобьем и создадим новый столбец)
SELECT LastName, i.*, strftime('%m', InvoiceDate) as MonthDate FROM Customer c INNER JOIN Invoice i ON i.CustomerId = c.CustomerId 

--Ранжируем клиентов (в табличной форме)
WITH monthTable as (
SELECT LastName, i.*, strftime('%m', InvoiceDate) as MonthDate 
FROM Customer c 
INNER JOIN Invoice i 
      ON i.CustomerId = c.CustomerId
 )
 
-- Вложенный запрос rowTable чтобы определить самых первых по ранжированию по первой покупке и по алфавиту по фамилии 
 SELECT * FROM ( 
SELECT  LastName, InvoiceDate, 
ROW_NUMBER () over (PARTITION BY monthDate ORDER BY InvoiceDate, LastName) AS rn
FROM monthTable
) as rowTable
WHERE rn = 1


--Вывести всеъ клиентов, которые купили, к примеру,  1 января (функция RANK), т.е. вывод всех покупателей, которые попадают в одно и то же время
WITH monthTable as (
SELECT LastName, i.*, strftime('%m', InvoiceDate) as MonthDate 
FROM Customer c 
INNER JOIN Invoice i 
      ON i.CustomerId = c.CustomerId
 )
 
 SELECT * FROM ( 
SELECT  LastName, InvoiceDate, 
RANK () over (PARTITION BY monthDate ORDER BY InvoiceDate) AS rn
FROM monthTable
) as rowTable
WHERE rn = 1
