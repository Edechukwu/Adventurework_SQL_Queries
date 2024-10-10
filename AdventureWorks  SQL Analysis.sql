--- ADVENTURE_WORKS_DATABASE

---Question 1
---Retrieve information about the products with colour values except null, red, silver/black, white and list price between
---£75 and £750. Rename the column StandardCost to Price. Also, sort the results in descending order by list price

select * from production.Product

SELECT ProductID,Name,Color,Standardcost AS Price,Listprice
FROM Production.Product
WHERE Color IS NOT NULL
AND Color NOT IN ('Red', 'Silver/Black','White') AND ListPrice BETWEEN 75 AND 750
ORDER BY Listprice desc;


---Question 2
---Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 and female employees
---born between 1972 and 1975 and hire date between 2001 and 2002.

SELECT *
FROM HumanResources.Employee

SELECT BusinessEntityID,Gender,BirthDate,HireDate
FROM HumanResources.Employee
WHERE (Gender = 'M'AND Birthdate BETWEEN '1962-01-01' AND '1970-12-31' AND Hiredate > '2001-12-31')
OR (Gender = 'F' AND Birthdate BETWEEN '1972-01-01' AND '1975-12-31' AND HireDate >'2001-12-31');



---Question 3
---Create a list of 10 most expensive products that have a product number beginning with ‘BK’.
---Include only the product ID, Name and colour
SELECT *
FROM Production.Product

SELECT  TOP 10 ProductID, Name, Productnumber, Color , ListPrice
FROM Production.Product
WHERE ProductNumber LIKE 'BK%'
ORDER BY ListPrice DESC;




---Question 4
---Create a list of all contact persons, where the first 4 characters of the last name are the same as the first four characters of the email address.
---Also, for all contacts whose first name and the last name begin with the same characters, 
---create a new column called full name combining first name and the last name only.
---Also provide the length ofthe new column full name.



SELECT PP.BusinessEntityID, FirstName,LastName,emailaddress,PE.BusinessentityID,
       CASE WHEN LEFT(LastName,1)= LEFT(Firstname,1) THEN Firstname + ' '+ LastName ELSE NULL END AS Fullname,
       CASE WHEN LEFT(LastName,1)= LEFT(Firstname,1) THEN LEN(Firstname + ' '+ LastName ) ELSE Null END AS Fullnamelength
FROM Person.Person AS PP
INNER JOIN Person.EmailAddress AS PE
ON PP.BusinessEntityID = PE.BusinessEntityID
WHERE SUBSTRING(LastName,1,4)= SUBSTRING(emailaddress,1,4);



---Question 5
---Return all product subcategories that take an average of 3 days or longer to manufacture



SELECT PPS.ProductSubcategoryID, PPS.Name, PP.DaysToManufacture
FROM Production.ProductSubcategory AS PPS
LEFT JOIN Production.Product AS PP
ON PPS.ProductSubcategoryID = PP.ProductSubcategoryID
WHERE DaysToManufacture >= 3;



---Create a list of product segmentation by defining criteria that places each item in a predefined segment as follows. 
---If price gets less than £200 then low value. If price is between £201 and £750 then mid value. 
--If between £750 and £1250 then mid to high value else higher value. Filter the results only for black, silver and red color products.SELECT ProductID, Name, Color, Listprice,CASE WHEN (Listprice < 200) THEN 'Low Value'     WHEN (Listprice between 201 and 750) THEN 'Mid Value'	 WHEN (Listprice between 750 and 1250 ) THEN 'Mid to High Value'	 ELSE 'Higher Value'	 END AS 'PriceSegment'FROM Production.ProductWHERE Color IN  ('black', 'silver', 'red');---Question 7
---How many Distinct Job title is present in the Employee table

SELECT COUNT(DISTINCT Jobtitle) AS Total_JobtitlesFROM HumanResources.Employee;


---Question 8
---Use employee table and calculate the ages of each employee at the time of hiring.



SELECT BusinessEntityID, BirthDate, HireDate,
       DATEDIFF(YEAR ,Birthdate,Hiredate) AS Age_at_Hiring
FROM HumanResources.Employee;



---Question 9
---How many employees will be due a long service award in the next 5 years, if long service is 20 years?


SELECT COUNT(*) AS Employees_Due_For_Awards
FROM HumanResources.Employee
WHERE DATEADD(YEAR, 20, HireDate) BETWEEN GETDATE() AND DATEADD(YEAR, 5, GETDATE());


---Question 10
---How many more years does each employee have to work before reaching sentiment, if sentiment age is 65


SELECT BusinessentityID ,BirthDate, jobtitle,
      DATEDIFF( Year, Birthdate, GETDATE())AS Current_Age,
	  65-DATEDIFF( Year, Birthdate, GETDATE()) AS Year_until_Retirement
FROM HumanResources.Employee
WHERE DATEDIFF( Year, Birthdate, GETDATE()) < 65;



--- Question 11
---Implement new price policy on the product table base on the colour of the item If white increase price by 8%, 
---If yellow reduce price by 7.5%, If black increase price by 17.2%. If multi, silver,silver/black or blue take the square root of the price and double the value.
---Column should be called Newprice. For each item, also calculate commission as 37.5% of newly computed list price




SELECT ProductID, Name, Color, ListPrice,
     CASE  WHEN Color = 'White' THEN ListPrice * 1.08
           WHEN Color = 'Yellow' THEN ListPrice * 0.925
           WHEN Color = 'Black' THEN ListPrice * 1.172
           WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN SQRT (ListPrice) * 2
           ELSE ListPrice 
     END AS NewPrice,
     CASE 
           WHEN Color = 'White' THEN ListPrice * 1.08 * 0.375
           WHEN Color = 'Yellow' THEN ListPrice * 0.925 * 0.375
           WHEN Color = 'Black' THEN ListPrice * 1.172 * 0.375
           WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN SQRT(ListPrice) * 2 * 0.375
           ELSE 0 
       END AS Commission
FROM Production.Product;




---Question 12
---Print the information about all the Sales.Person and their sales quota. For every Sales person you should provide their
---FirstName, LastName, HireDate, SickLeaveHours and Region where they work.



SELECT SS.BusinessEntityID, SS.FirstName, SS.LastName, HireDate,SickLeaveHours, CountryRegionName, SPQ.SalesQuota
FROM Sales.vSalesPerson AS SS
INNER JOIN HumanResources.Employee AS HRE
ON SS.BusinessEntityID =HRE.BusinessEntityID
INNER JOIN Sales.SalesPersonQuotaHistory  AS SPQ
ON SS.BusinessEntityID = SPQ.BusinessEntityID 



--- Question 13
---Using adventure works, write a query to extract the following information.
--• Product name • Product category name • Product subcategory name • Sales person • Revenue • Month of transaction • Quarter of transaction • Region




SELECT PP.Name AS ProductName, PC.Name AS ProductCategoryName, PSC.Name AS ProductSubcategory,
    CONCAT(PE.FirstName, ' ', PE.LastName) AS SalesPerson, SOH.TotalDue AS Revenue,
    MONTH(SOH.OrderDate) AS MonthOfTransaction, DATENAME(QUARTER, SOH.OrderDate) AS QuarterOfTransaction, ST.Name AS Region
FROM Sales.SalesOrderHeader  AS SOH
JOIN 
    Sales.SalesOrderDetail AS SOD 
	ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN 
    Production.Product AS PP 
	ON SOD.ProductID = PP.ProductID
JOIN
    Production.ProductSubcategory AS PSC 
	ON PP.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN 
    Production.ProductCategory AS PC 
	ON PSC.ProductCategoryID = PC.ProductCategoryID
JOIN 
    Sales.SalesPerson AS  SP 
	ON SOH.SalesPersonID = SP.BusinessEntityID
JOIN 
    Person.Person AS PE
	ON SP.BusinessEntityID = PE.BusinessEntityID
JOIN 
    Sales.SalesTerritory AS ST
	ON SOH.TerritoryID = ST.TerritoryID;



---Question 15
----For all the products calculate
--- Commission as 14.790% of standard cost,
--- Margin, if standard cost is increased or decreased as follows:
--Black: +22%,
--Red: -12%
--Silver: +15%
--Multi: +5%
--White: Two times original cost divided by the square root of cost
--For other colours, standard cost remains the same



SELECT 
    PP.ProductID, PP.Name AS ProductName, PP.StandardCost ,(PP.StandardCost * 0.14790) AS Commission,
    CASE 
        WHEN PP.Color = 'Black' THEN PP.StandardCost * 1.22  -- Increase by 22%
        WHEN PP.Color = 'Red' THEN PP.StandardCost * 0.88   -- Decrease by 12%
        WHEN PP.Color = 'Silver' THEN PP.StandardCost * 1.15 -- Increase by 15%
        WHEN PP.Color = 'Multi' THEN PP.StandardCost * 1.05  -- Increase by 5%
        WHEN PP.Color = 'White' THEN (2 * PP.StandardCost) / SQRT(PP.StandardCost) 
        ELSE PP.StandardCost  
    END AS Margin
FROM 
    Production.Product AS PP;




---Question 16
---Create a view to find out the top 5 most expensive products for each colour





CREATE VIEW Top5MostExpensiveProductsByColor AS
WITH RankedProducts AS (SELECT 
                            PP.ProductID,
                            PP.Name AS ProductName,
                            PP.StandardCost, PP.Color,
      ROW_NUMBER() OVER (PARTITION BY PP.Color ORDER BY PP.StandardCost DESC) AS ProductRank
      FROM  Production.Product AS PP)
SELECT 
    ProductID,
    ProductName,
    StandardCost,
    Color
FROM 
    RankedProducts
WHERE 
    ProductRank <= 5;

SELECT*
FROM Top5MostExpensiveProductsByColor