SELECT*FROM coffe_shop.sales.transactions
LIMIT 10;

SELECT MIN(transaction_time) AS opening_time
FROM coffe_shop.sales.transactions;

SELECT MAX(transaction_time) AS closing_time
From coffe_shop.sales.transactions;


---DATES----------------------------------

SELECT

TO_DATE(transaction_date) AS transaction_date,
DAYOFMONTH(TO_DATE(transaction_date)) AS day_of_month,
DAYNAME(TO_DATE(transaction_date)) AS day_name,
MONTHNAME(TO_DATE(transaction_date)) AS month_name,
TO_CHAR(TO_DATE(transaction_date), 'YYYY-MM') AS month_id,

---TIMES------------------------------------

  CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
     WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time BETWEEN '17:00:00' AND '20:59:59' THEN 'Evening'
     ELSE 'Night'
     END AS time_bucket,

---DAY---------------------------------------

  
  CASE
     WHEN DAYNAME(TO_DATE(transaction_date)) NOT IN ('Sat', 'Sun') THEN 'Weekday'
     ELSE 'Weekend'
     END AS day_bucket,


---REVENUE---------------------------------------------------

SUM(transaction_qty*unit_price) AS revene,

---COUNTS-----------------------------------------------------

COUNT(DISTINCT transaction_id) AS number_of_sales,
COUNT(DISTINCT product_id) AS number_of_unique_products,
COUNT(DISTINCT store_id)AS number_of_stores,

---CATEGORIES--------------------------------------------------

store_location,
product_category,
product_detail,
product_type,

FROM coffe_shop.sales.transactions
GROUP BY ALL;
