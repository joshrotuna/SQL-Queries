

# 1. Select all columns from the film table for PG-rated films. (1 point)
SELECT * 
FROM film
WHERE rating = 'PG';

# 2. 
/*
Select the customer_id, first_name, and last_name for the active customers (0 means inactive). 
# Sort the customers by their last name and restrict the results to 10 customers. (1 point)
*/

SELECT customer_id,first_name,last_name
FROM
customer
WHERE active = 1
LIMIT 10;

# 3.  Select customer_id, first_name, and last_name for all customers where the last name is Clark. (1 point)

SELECT customer_id,first_name,last_name
FROM customer
WHERE last_name = 'Clark';

# 4. Select film_id, title, rental_duration, and description for films with a rental duration of 3 days. (1 point)

SELECT film_id, title, rental_duration, description
FROM film
WHERE rental_duration = 3;

#5. Select film_id, title, rental_rate, and rental_duration for films that can be rented for more than 1 day and at a cost of $0.99 or more.
#	Sort the results by rental_rate then rental_duration. (2 points)

SELECT 
	film_id, 
	title, 
	rental_rate, 
	rental_duration
FROM film
WHERE rental_rate >= 0.99 AND rental_duration>1
ORDER BY rental_rate, rental_duration;

#6. Select film_id, title, replacement_cost, and length for films that cost 9.99 or 10.99 
# 	to replace and have a running time of 60 minutes or more. (2 points)

SELECT 
	film_id, 
	title, 
	replacement_cost, length
FROM film
WHERE replacement_cost = 9.99 OR replacement_cost = 10.99
AND length >60;

# 7. Select film_id, title, replacement_cost, and rental_rate 
# for films that cost $20 or more to replace and the cost to rent is less than a dollar. (2 points)

SELECT film_id, title, replacement_cost, rental_rate
FROM film
WHERE replacement_cost >= 20
AND rental_rate < 1;

#8  Select film_id, title, and rating for films that do not have a G, PG, and PG-13 rating.  
# 		Do not use the OR logical operator. (2 points)

SELECT film_id, title, rating
FROM film
WHERE rating NOT LIKE  'G' 
AND rating NOT LIKE 'PG'
AND rating NOT LIKE 'PG-13';

/*
9. How many films can be rented for 5 to 7 days? Your query should only return 1 row. (2 points)
*/
SELECT COUNT(*)
FROM film
WHERE rental_duration BETWEEN 5 and 7;


/*
10. INSERT your favorite movie into the film table. You can arbitrarily set the column values as long as they are related to the column. 
Only assign values to columns that are not automatically handled by MySQL. (2 points)
*/

INSERT INTO film 	
SET
	title = 'Happy Gilmore',
	description = 'Professional Hockey player discovers skills for Golf',
	release_year = '1996',
	language_id = 1,
	rental_duration = 6,
	rental_rate = 2.99,
	replacement_cost = 12.99,
	rating = 'PG-13',
	special_features = 'Trailers,Deleted Scenes';


	
/*
11. INSERT your two favorite actors/actresses into the actor table with a single SQL statement. (2 points)
*/

INSERT INTO actor 
  (first_name , last_name)
VALUES
  ('Adam', 'Sandler'), 
  ('Will', 'Ferrell')
;

/*
12. The address2 column in the address table inconsistently defines what it means to not have an 
address2 associated with an address. UPDATE the address2 column to an empty string where the address2 value is currently null. (2 points)
*/



UPDATE address 
SET address2 = ''
WHERE address2 IS NULL;



/*
13. For rated G films less than an hour long, update the special_features column 
to replace Commentaries with Audio Commentary. Be sure the other special features are not removed. (2 points)
*/

UPDATE film 
SET special_features ='Audio Commentary'
WHERE rating ='G' AND 
film.length < 60 AND
special_features ='Commentaries';


/*
14. Create a new database named LinkedIn. You will still need to use  LMU.build to create the database. (1 point)
*/

SHOW DATABASES;

/*
15. Create a user table to store LinkedIn users. The table must include 5 columns minimum with the appropriate data type and a primary key. One of the columns should be Email and must be a unique value. (3 points)
*/

CREATE TABLE users (
	user_id INT(11) NOT NULL AUTO_INCREMENT,
	first_name VARCHAR (255),
	last_name VARCHAR(255),
	email VARCHAR (255),
	profile_link VARCHAR (255),
	current_job VARCHAR (255),
	PRIMARY KEY (user_id)
);

SHOW TABLES;

DESCRIBE users

/*
16. Create a table to store a user's work experience. 
The table must include a primary key, a foreign key column to the user table, and have at least 5 columns with the appropriate data type. (3 points)
*/

CREATE TABLE work_experience (
	user_id INT,
	first_name VARCHAR (255),
	last_name VARCHAR(255),
	email VARCHAR (255),
	current_job VARCHAR (255),
	past_experience_1 VARCHAR (255),
	past_experience2 VARCHAR (255),
	past_experience3 VARCHAR (255),
	PRIMARY KEY (email),
	FOREIGN KEY (user_id) REFERENCES users(user_id)	
);

DESCRIBE work_experience;

/*
17. INSERT 1 user into the user table. (2 points)
*/
INSERT INTO users
SET
	first_name = 'Tom',
	last_name = 'Brady',
	email = 'tombrady@yahoo.com',
	profile_link = 'www.linkedIn.com/tombrady',
	current_job = 'NFL QB';


/*
18. INSERT 1 work experience entry for the user just inserted. (2 points)
*/

INSERT INTO work_experience (user_id, first_name, last_name, email, current_job)
	SELECT 
		user_id, 
		first_name, 
		last_name, 
		email, 
		current_job
	FROM users
	WHERE user_id = 1;

INSERT INTO work_experience 
SET
	past_experience_1 = 'Buccaneers QB'
	WHERE user_id = 1;



-- SpecialtyFood Database

/*
19. The warehouse manager wants to know all of the products the company carries. Generate a list of all the products with all of the columns. (1 point)
*/
	
SELECT 
	*
FROM Products
GROUP BY ProductName;

/*
20. The marketing department wants to run a direct mail marketing campaign to its American, Canadian, and Mexican customers. 
Write a query to gather the data needed for a mailing label. (2 points)
*/

SELECT ContactName, Address, City, PostalCode, Region, Country 
FROM Customers c 
WHERE Country = 'USA' 
OR Country = 'Mexico' 
OR Country = 'Canada';


/*
21. HR wants to celebrate hire date anniversaries for the sales representatives in the USA office. 
Develop a query that would give HR the information they need to coordinate hire date anniversary gifts. 
Sort the data as you see best fit. (2 points)
*/

SELECT 
	LastName,
	FirstName,
	DATE_FORMAT(DATE_ADD(HireDate, INTERVAL 1 YEAR), '%Y-%m-%d') AS anniversary_date
FROM Employees
WHERE Country = 'USA'
	AND title = 'Sales Representative';


/*
22. What is the SQL command to show the structure for the Shippers table? (1 point)
*/

DESCRIBE Shippers;

/*
23. Customer service noticed an increase in shipping errors for orders handled by the employee, Janet Leverling. 
Return the OrderIDs handled by Janet so that the orders can be inspected for other errors. (2 points)
*/
SELECT 
	LastName, 
	OrderID
FROM Orders 
JOIN Employees
	ON Orders.EmployeeID =Employees.EmployeeID 
WHERE FirstName ='Janet' AND
	LastName = 'Leverling';


/*
24. The sales team wants to develop stronger supply chain relationships with its suppliers 
	by reaching out to the managers who have the decision making power to create a just-in-time inventory arrangement.
	Display the supplier's company name, contact name, title, and phone number for suppliers 
	who have manager or mgr in their title. (2 points)
*/
SELECT 
	CompanyName,
	ContactName, 
	ContactTitle,Phone 
FROM Suppliers
WHERE ContactTitle LIKE '%mgr%' OR 
ContactTitle LIKE '%manager%';

	
/*
25. The warehouse packers want to label breakable products with a fragile sticker. 
	Identify the products with glasses, jars, or bottles and are not discontinued 
	(0 = not discontinued). (2 points)
*/
SELECT ProductName, Description, Discontinued 
FROM Categories c 
JOIN Products p 
	ON p.CategoryID = c.CategoryID 
WHERE Description LIKE '%beers%'
HAVING discontinued =0;



/*
26. How many customers are from Brazil and have a role in sales? 
Your query should only return 1 row. (2 points)
*/

SELECT COUNT(*)
FROM
	(
	SELECT *
	FROM Customers 
	WHERE ContactTitle LIKE '%Sales%'
	HAVING Country ='Brazil'
	) AS Brazil_cust;

/*
27. Who is the oldest employee in terms of age? Your query should only return 1 row. (2 points)
*/

SELECT * FROM Employees
ORDER BY BirthDate 
Limit 1;

/*
28. Calculate the total order price per order and product before and after the discount. 
The products listed should only be for those where a discount was applied. 
Alias the before discount and after discount expressions. (3 points)
*/

SELECT
	*
FROM
	(
	SELECT
		ProductName,
		OrderID,
		(Quantity)*(UnitPrice) AS Full_Price,
		(Quantity)*(UnitPrice) - (Quantity)*(UnitPrice)*(Discount) AS Discount_Price
	FROM
		(
		SELECT
			ProductName,
			Orders.OrderID,
			Quantity,
			Products.UnitPrice,
			Discount
		FROM
			Orders
		JOIN OrderDetails ON
			Orders.OrderID = OrderDetails.OrderID
		JOIN Products ON
			OrderDetails.ProductID = Products.ProductID ) AS full_discount_price_table ) AS Ungrouped_Order_Prices
WHERE
	Discount_Price < Full_Price
GROUP BY
	OrderID,
	ProductName;



/*
29. To assist in determining the company's assets, 
find the total dollar value for all products in stock. Your query should only return 1 row.  (2 points)
*/
SELECT SUM(UnitPrice * UnitsInStock) AS Total_Dollar_Value
FROM Products p ;


/*
30. Supplier deliveries are confirmed via email and fax. 
Create a list of suppliers with a missing fax number 
to help the warehouse receiving team identify who to contact to fill in the missing information. (2 points)
*/
SELECT *
FROM Suppliers s 
WHERE Fax IS NULL;


/*
31. The PR team wants to promote the company's global presence on the website. 
	Identify a unique and sorted list of countries where the company has customers. (2 points)
*/

SELECT Country, COUNT(*) 
FROM Customers c 
GROUP BY Country
ORDER BY Count(*) DESC;


/*
32. List the products that need to be reordered from the supplier. 
Know that you can use column names on the right-hand side of a comparison operator. 
Disregard the UnitsOnOrder column. (2 points)
*/


SELECT 
	ProductID, 
	ProductName, 
	(ReorderLevel-UnitsOnOrder) AS number_still_to_order
FROM Products
WHERE (ReorderLevel-UnitsOnOrder) >0;


/*
33. You're the newest hire. INSERT yourself as an employee with the INSERT … SET method. 
	You can arbitrarily set the column values as long as they are related to the column. 
	Only assign values to columns that are not automatically handled by MySQL. (2 points)
*/
INSERT INTO Employees 
SET
	LastName ='Rotuna',
	FirstName = 'Joshua',
	Title = 'Student Intern',
	TitleOfCourtesy ='Mr.',
	BirthDate = '1997-02-27 00:00:00',
	HireDate = '2021-02-12 00:00:00',
	Address = '1 Loyola Marymount University Dr',
	City = 'Los Angeles',
	Region = 'CA',
	PostalCode = '90045',
	Country ='USA';
	
	


SELECT * FROM Employees 


/*
34. The supplier, Bigfoot Breweries, recently launched their website. 
UPDATE their website to bigfootbreweries.com. (2 points)
*/

UPDATE Suppliers 
SET HomePage = 'bigfootbreweries.com'
WHERE CompanyName = 'Bigfoot Breweries';



/*
35. The images on the employee profiles are broken. 
	The link to the employee headshot is missing the .com domain extension. 
	Fix the PhotoPath link so that the domain properly resolves. 
	Broken link example: http://accweb/emmployees/buchanan.bmp (2 points)
*/

UPDATE Employees 
SET PhotoPath = CONCAT(PhotoPath, '.com');

SELECT * FROM Employees



-- Custom Data Requests


/*
Data Request 1
Question

Find the Total Sales by product category. List the descritpion of each category as well. 
Sort by the value of the total sales in descending order

Business Justification
This will allow managers to easily view which categories they have the highest and lowest sale in
*/

	SELECT CategoryName as Product_Category, 
		Description, 
		(Quantity*Products.UnitPrice) AS Total_Sales
	FROM Orders
	JOIN OrderDetails
		ON Orders.OrderID =OrderDetails.OrderID 
	JOIN Products 
		ON OrderDetails.ProductID =Products.ProductID 
	JOIN Categories 
		ON Products.CategoryID = Categories.CategoryID 
	GROUP BY CategoryName 
	ORDER BY Total_Sales DESC;


/*
Data Request 2

Question
Find Total Sales by customer. Sort in Descending order and display the top 100 customers and their contact information


Business Justification
This will enable mamagers to observe the most profitable customers they have. 
Managers could use this information to begin identifying trends associated with higher profitability.

*/
SELECT 
	ContactName,
	(UnitPrice*Quantity) AS Total_Sales,
	Address,
	City,
	Country,
	Phone,
	Fax,
	PostalCode
FROM Customers
JOIN Orders 
	ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails 
	ON Orders.OrderID =OrderDetails.OrderID
ORDER BY Total_Sales DESC
LIMIT 100




/*
Data Request 3
Question
WHich country averaged the highest freight costs.
Display the countries that averaged higher freight costs than the total average.

Business Justification
This will enable managers to evaluate shipping methods in certain countries where 
they experience very high freigh costs on average
*/

SELECT 
	ShipCountry,
    AVG(Freight) AS Average_freight
FROM Orders
GROUP BY ShipCountry
HAVING Average_freight >
	(
	SELECT 
		AVG(Freight)
	FROM Orders od
	) ;




/*
Data Request 4
Question
Find average sale amount per order in each country 

Business Justification
This will allow managers to observe the average sale amount in each country more easily.
Managers could also structure deals with certain companies that consistently spend more in one order.
**/


SELECT 
	City,
	AVG(UnitPrice*Quantity) AS avg_order_amount
FROM 
Customers
JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID 
JOIN OrderDetails
	ON Orders.OrderID = OrderDetails.OrderID 
GROUP BY Orders.OrderID 
ORDER BY avg_order_amount DESC;


/*
Data Request 5
Question
	-Specialty Food Database-
Return the top 10 total sales by CompanyName and display the its country location as well


Business Justification
This will managers to observe their highest sales by each company. 
They could create deals or give out more discounts to certain companies that spend enough on their company.
*/

SELECT 
	CompanyName,
	(UnitPrice*Quantity) AS Total_Sales,
	Country
FROM Customers
JOIN Orders 
	ON Customers.CustomerID = Orders.CustomerID 
JOIN OrderDetails 
	ON Orders.OrderID = OrderDetails.OrderID
GROUP BY CompanyName
ORDER BY Total_Sales DESC
LIMIT 10;


	

/*
Data Request 6
Question

Find the most popular products within each Company.
Lost top 25 products

Business Justification
This will enable managers to view which products are purchased the most by certain companies.
Managers can work with this date to detemrine 
suitable discounts and/or to incentivize some other companies to purchase alternative products.
*/

SELECT 
	CompanyName,
	ProductName,
	COUNT(*) as total_purchases
FROM
(
	SELECT
		ProductName,
		CompanyName 
	FROM Customers 
	JOIN Orders 
		ON Customers.CustomerID = Orders.CustomerID 
	JOIN OrderDetails 
		ON Orders.OrderID = OrderDetails.OrderID
	JOIN Products 
		ON OrderDetails.ProductID =Products.ProductID 
	GROUP BY ProductName, CompanyName 
) AS company_product_table
GROUP BY ProductName
ORDER BY total_purchases DESC
LIMIT 25;



	





