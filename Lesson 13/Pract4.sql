 --1.
 INSERT INTO manufacturer (name, country_id)
 VALUES ('HP','4')

 --2.
 UPDATE user 
 SET age = age/3
 WHERE name = 'Андрей'

 --3. 
 --3.1
 SELECT name, price 
 FROM product
 WHERE price=(SELECT MAX(price) FROM product)
  --3.2
SELECT DISTINCT *
FROM 
(SELECT name, price , MAX([price]) OVER (PARTITION BY [name]) AS max_price  
FROM product) T
WHERE price =max_price 
  --3.3

  SELECT  name, price 
FROM 
	(SELECT name, price, RANK() OVER (PARTITION BY [name] ORDER BY [price] DESC ) as rnk
FROM product) T
WHERE rnk BETWEEN 1 AND 5

  --3.4
  WITH price_CTE (name, price, maxprice) AS ( SELECT name, price, MAX(price) maxprice FROM product)
  SELECT name, price
	WHERE price=maxprice


 --4.
 SELECT u.name, p.name 
 FROM user u JOIN phone p ON user.id=phone.user_id
 WHERE p.nmae LIKE '+3%4' OR age>35

 --5.
 SELECT TOP 5* name, quantity
 FROM 
	(SELECT name, COUNT(product_id) OVER (PARTITION BY name) AS "quantity"  
	FROM user JOIN order ON user.id=order.user_id
	ORDER BY quantity)
