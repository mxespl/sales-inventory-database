-- Q11: Top 5 customers by total spending (completed sales)
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status IN ('Shipped', 'Delivered')
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- Q12: Number of orders per customer (all statuses, including customers with 0 orders)
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY order_count DESC, c.customer_id;

-- Q13: Customers who placed more than 3 orders
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 3
ORDER BY order_count DESC;

-- Q14: Each customer's most recent order date
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       MAX(o.order_date) AS last_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY last_order_date DESC;