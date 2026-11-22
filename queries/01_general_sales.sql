-- Q1: Total revenue from completed sales (Shipped + Delivered)
SELECT SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status IN ('Shipped', 'Delivered');


-- Q2: Total number of orders (all statuses)
SELECT COUNT(*) AS total_orders
FROM orders;


-- Q3: Average order value (completed sales only)
WITH order_totals AS (
    SELECT oi.order_id,                                    
           SUM(oi.quantity * oi.unit_price) AS order_total 
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status IN ('Shipped', 'Delivered')       
    GROUP BY oi.order_id                                   
)
SELECT ROUND(AVG(order_total), 2) AS avg_order_value      
FROM order_totals;



-- Q4: Total revenue per month for completed sales (Shipped + Delivered)
SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS month, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status IN ('Shipped', 'Delivered')
GROUP BY month
ORDER BY month;



-- Q5: Number of orders per status
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;