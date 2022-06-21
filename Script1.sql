 
SELECT * FROM Artist a 
LIMIT 5;
SELECT * FROM Album a
LIMIT 5;

--����� �������� ������� � �������� ������ �� ������ Album, Artist
SELECT Title, Name   FROM Album a
INNER JOIN  Artist a2  ON a.ArtistId = a2.ArtistId 

-- ���������� �������� � ������� ��� ��������, ��� ������� ���������� ������ >=2
SELECT Title from Album a inner join Track t ON t.AlbumId =a.AlbumId 
GROUP BY a.AlbumId 
HAVING count (DISTINCT GenreId)>=2

-- ������� �����������, ������� �������� ������ � ������ ������� (� �������, ��� �������������� ���������� ������)
SELECT * FROM Customer c 
LIMIT 10;
SELECT * FROM Invoice i 
LIMIT 10;

--� ����. Customer ����� CustomerId, FirstName, LastName, � Invoice - InvoiceId, CustomerId, InvoiceDate (�� ���� �� ������� �� ������� - �������� � �������� ����� �������)
SELECT LastName, i.*, strftime('%m', InvoiceDate) as MonthDate FROM Customer c INNER JOIN Invoice i ON i.CustomerId = c.CustomerId 

--��������� �������� (� ��������� �����)
WITH monthTable as (
SELECT LastName, i.*, strftime('%m', InvoiceDate) as MonthDate 
FROM Customer c 
INNER JOIN Invoice i 
      ON i.CustomerId = c.CustomerId
 )
 
-- ��������� ������ rowTable ����� ���������� ����� ������ �� ������������ �� ������ ������� � �� �������� �� ������� 
 SELECT * FROM ( 
SELECT  LastName, InvoiceDate, 
ROW_NUMBER () over (PARTITION BY monthDate ORDER BY InvoiceDate, LastName) AS rn
FROM monthTable
) as rowTable
WHERE rn = 1


--������� ���� ��������, ������� ������, � �������,  1 ������ (������� RANK), �.�. ����� ���� �����������, ������� �������� � ���� � �� �� �����
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
