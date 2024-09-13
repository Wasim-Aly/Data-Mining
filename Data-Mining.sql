-- 	create schema retail_data;
    use retail_data;
    select * from online_retail;

create table onlie_retail(
      invoiceNO varchar(20),
      stockcode varchar(20),
      description varchar(300),
      quantity int,
      invoicedate datetime,
      unitprice decimal (10, 2),
      customerid int,
      country varchar(100)
);


SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalOrderValue
FROM online_retail
GROUP BY CustomerID;


SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProducts
FROM online_retail
GROUP BY CustomerID;

SELECT CustomerID
FROM online_retail
GROUP BY CustomerID
HAVING COUNT(InvoiceNo) = 1;

SELECT a.StockCode AS Product1, b.StockCode AS Product2, COUNT(*) AS PurchaseCount
FROM online_retail a
JOIN online_retail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode <> b.StockCode
GROUP BY Product1, Product2
ORDER BY PurchaseCount DESC;

SELECT CustomerID, COUNT(InvoiceNo) AS PurchaseCount,
CASE 
    WHEN COUNT(InvoiceNo) > 10 THEN 'High Frequency'
    WHEN COUNT(InvoiceNo) BETWEEN 5 AND 10 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
END AS FrequencySegment
FROM online_retail
GROUP BY CustomerID;

SELECT Country, AVG(Quantity * UnitPrice) AS AverageOrderValue
FROM online_retail
GROUP BY Country;

SELECT DISTINCT CustomerID
FROM online_retail
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM online_retail
    WHERE InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 day)
);

SELECT StockCode, COUNT(DISTINCT InvoiceNo) AS PurchaseCount
FROM online_retail
GROUP BY StockCode;

SELECT 
    DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'), '%Y-%m') AS Month, 
    SUM(Quantity * UnitPrice) AS MonthlySales
FROM 
    online_retail
WHERE 
    InvoiceDate IS NOT NULL
    AND Quantity > 0  -- Exclude negative quantities
GROUP BY 
    DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'), '%Y-%m')
ORDER BY 
    Month ASC;
