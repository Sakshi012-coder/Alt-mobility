--step1
--Load the data in sql
--(1) Create database
CREATE DATABASE altmobility;
use altmobility;

--(2) Create tables (customer_orders and payments)
CREATE TABLE customer_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(50),
    order_amount DECIMAL(10, 2),
    shipping_address VARCHAR(100)
);

CREATE TABLE payments (
    payment_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(50),
    payment_date DATE,
    payment_status VARCHAR(50),
    payment_amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES customer_orders(order_id)
);

--(3) load data from customer_orders csv and payments.csv files by importing table data
Select* from customer_orders;
Select* from payment;


--Tasks
--(1)order and sales analysis
--total order by status
Select order_status, Count(*) As total_orders 
From customer_orders 
Group By order_status 
order by total_orders desc;

--total revenue 
Select Sum(order_amount) As total_revenue 
from customer_orders 
Where order_status='delivered';

--monthly order and revenue trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM customer_orders
GROUP BY month
ORDER BY month;




-- (2)Customer Analysis
-- Repeat customers
SELECT customer_id, COUNT(*) AS order_count
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Monthly active customers
SELECT DATE_Format(order_date, '%Y-%m') AS month, COUNT(DISTINCT customer_id) AS active_customers
FROM customer_orders
GROUP BY month
ORDER BY month;

-- First-time vs repeat orders (Segmentation)
SELECT
  CASE
    WHEN order_rank = 1 THEN 'First-Time'
    ELSE 'Repeat'
  END AS customer_type,
  COUNT(*) AS total_orders
FROM (
  SELECT customer_id, order_id,
         RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_rank
  FROM customer_orders
) ranked_orders
GROUP BY customer_type;

--3  Payment Status Analysis
-- Payment Status Distribution
SELECT payment_status, COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status;

--Monthly Failed Payments
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    COUNT(*) AS failed_payments
FROM payments
WHERE payment_status = 'failed'
GROUP BY month
ORDER BY month;

--payment status distribution by payment method
SELECT
    payment_method,payment_status,
    COUNT(*) AS total
    FROM
     payments
    GROUP BY
         payment_method, payment_status
    ORDER BY
        payment_method, payment_status;

--4. Order Details Report
--Combined Order and Payment Report
SELECT 
  o.order_id, o.customer_id, o.order_date, o.order_status, o.order_amount, o.shipping_address,
  p.payment_id, p.payment_date, p.payment_status, p.payment_amount, p.payment_method
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
ORDER BY o.order_date;

--Now exporting necessary columns from the data for visualization
SELECT 
    customer_id,
    MIN(DATE_FORMAT(order_date, '%Y-%m')) OVER (PARTITION BY customer_id) AS cohort_month,
    DATE_FORMAT(order_date, '%Y-%m') AS order_month
FROM customer_orders; 





















