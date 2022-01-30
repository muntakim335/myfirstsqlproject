create database myproject 

/*create table called "sales"*/
use myproject
go
create table sales ("Account Manager ID" INT, "Sales ID" INT, Category VARCHAR(255), SKU VARCHAR(255), "Sales Price" MONEY);
/*create table called "staff"*/
use myproject

go 

create table satff ("Account manager id"int,"First name"varchar(255),"last name"varchar(255));

/*insert into sales table*/
use myproject
go

insert into sales values (1,1,'TVs', 'F600 Smart LED TV', 1209)
/*delete a row from table*/
use myproject
go 
delete from sales where Category='TVs';

/* insertion munltiple rows at same time */
use myproject
go
insert into Sales ([Account Manager ID], [Sales ID], [Category], [SKU], [Sales Price])
Values  (1, 1, 'TVs', 'F600 Smart LED TV', 1209),(1, 2, 'TVs', 'F7001 Plasma TV', 999), (1, 3, 'TVs', 'F2300 LCD TV', 1800), (1, 4, 'TVs', 'F2300 LCD TV', 1800), (1, 5, 'TVs', 'F2300 LCD TV', 1800), (2, 6, 'Computer', 'X21 -Bus', 2399), (2, 7, 'GPS Navigation', 'Nav smart 2300', 435), (2, 8, 'GPS Navigation', 'Nav smart 2300', 435), (2, 9, 'Phones', 'G32 Phone', 499), (3, 10, 'Cameras', 'KL Mini Camera', 199), (3, 11, 'Cameras', 'KL Mini Camera', 199), (3, 12, 'Computer', 'X21 -Bus', 2399), (3, 13, 'GPS Navigation', 'Nav smart 2300', 435), (3, 14, 'TVs', '780 XC LCD TV', 699), (4, 15, 'Phones', 'G32 Phone', 499), (4, 16, 'Phones', 'G32 Phone', 499), (4, 17, 'Printers', 'MF 2400 Printer', 399), (4, 18, 'Printers', 'MF 2400 Printer', 399), (4, 19, 'Tablets', '10 Inch Maxi 2014', 799), (4, 20, 'TVs', 'F7001 Plasma TV', 999), (5, 20, 'TVs', 'F7001 Plasma TV', NULL), (6, 20, 'TVs', 'F7001 Plasma TV', 599)

/*insert into staff table*/
use  myproject
go
insert into satff([Account manager id],[First name],[last name])
values (1, 'Billy', 'Murphy'), (2, 'Jeffrey', 'Wood'), (3, 'Judy', 'Allen'), (4, 'Evelyn', 'Mitchell'), (5, 'Bob', 'Smith'), (7, 'Mike', 'Williams')
GO


/* select all query*/

select * from sales;
select * from satff;

/*  SELECT  only data from the Category and Sales Price columns from the "Sales" table*/
use myproject
go

select  Category, [Sales Price]
from  Sales


/*  Sort in Descending order */
use myproject
go

select *
from Sales
order by [Sales Price] desc


/* Select Unique Values  */
use myproject
go

select DISTINCT Category
from Sales


/*Selecting records greater than a value */
use myproject
go

SELECT *
FROM Sales
WHERE [Sales Price] > 500


/*Select the Top X Records in a Table  */
use myproject
go

select TOP (6) *
from Sales
ORDER BY [Sales Price] DESC


/* Wildcard searching for characters */
/* a "%" symbol  is a  substitute for zero or more characters. For example 'Cam%' will return cameras*/
/* the _ which is a  substitute for a single character. For example  '_ablets' */
/* the [] that provides a range of characters to match. For example '[C-G]%' */ 
/* The caret symbol inside square brackets provides  a set of characters not to match to. For example  '[^CP]%' */ 

use myproject
go

SELECT *
FROM Sales
WHERE Category LIKE 'Cam%'


/*N clause -specify multiple values in a WHERE clause */
use myproject
go

SELECT *
FROM Sales
WHERE Category IN ('Computer', 'Printers', 'Tablets')


/* BETWEEN clause */
use myproject 
go

SELECT *
FROM Sales
WHERE [Sales Price] BETWEEN 500
		AND 1000


/*Selecting NULL values */
use myproject
go

SELECT *
FROM [Sales]
WHERE [Sales Price] IS NULL


/*Selecting NON NULL values */
use myproject
go

SELECT *
FROM [Sales]
WHERE [Sales Price] IS NOT NULL
		
		
/*Combining filters  */
use myproject
go

SELECT *
FROM Sales
WHERE [Sales Price] > 500
	OR [Category] LIKE 'C%'	

	
/* Average by a GROUP & create column alias */
use myproject 
go

SELECT Category, AVG([Sales Price]) AS AvSalesPrice
FROM Sales
GROUP BY Category


/* Filtering groups based on aggregated values */
use myproject
go
SELECT Category, COUNT([Sales ID]) AS "Count IDs", SUM([Sales Price]) AS " Group Sales"
FROM [Sales]
GROUP BY Category
HAVING SUM([Sales Price]) > 500

	
/*  Join two columns from the "Staff" table into a new columnn (Concatenation) */
use myproject
go

SELECT [First Name] + ' ' + [Last Name] AS [Full Name]
FROM [satff]


/*Joining two tables with an "INNER JOIN" */
use myproject
go

SELECT satff.[First Name], satff.[Last Name], Sales.Category, Sales.[Sales Price], satff.[Account Manager ID], Sales.[Account Manager ID]
FROM Sales
INNER JOIN satff
	ON Sales.[Account Manager ID] = satff.[Account Manager ID]

	
/*  Joining two tables with an "LEFT JOIN" */
SELECT satff.[First Name], satff.[Last Name], Sales.Category, Sales.[Sales Price], satff.[Account Manager ID], Sales.[Account Manager ID]
FROM Sales
LEFT  JOIN satff
	ON Sales.[Account Manager ID] = satff.[Account Manager ID]

	
/*Joining two tables with an "RIGHT JOIN" */
SELECT satff.[First Name], satff.[Last Name], Sales.Category, Sales.[Sales Price], satff.[Account Manager ID], Sales.[Account Manager ID]
FROM Sales
RIGHT JOIN satff
	ON Sales.[Account Manager ID] = satff.[Account Manager ID]

	
/*  Creating a View */
/* note: view needs to be run as new query seprately*/
use myproject
go
CREATE VIEW FirstView
AS
SELECT Category, [Sales Price]
FROM [dbo].[Sales]


/* Create a Simple Stored Procedure called SimpleSP with a default parameter of 'Tablets'for the Category column  */
use myproject
go

CREATE PROCEDURE SimpleSP @input_Parameter varchar(255) = 'Tablets'
AS
SELECT *
FROM Sales
WHERE Category = @input_Parameter


/*To Execute Procedure with parameters */

EXEC SimpleSP 'Computer'



/* Update Records */
use myproject
go

UPDATE Sales
SET [Category] = 'Computers'
WHERE [Category] = 'Computer'


/* Backing-up a Table */
USE  myproject
GO

SELECT *
INTO Sales_Backup
FROM Sales


/*  Deleting Specific values */
use myproject
go
DELETE
FROM Sales_Backup
WHERE [Sales Price] > 500


/*  Removing just the data from a table */
use myproject
go

TRUNCATE TABLE Sales


/*  DELETING a table */
use myproject
go


DROP TABLE Sales


/* DELETING a database */
/* Note don't include "USE" and "GO" syntax as you can't be connected to a database when you delete it */
USE Master
GO

DROP DATABASE myproject