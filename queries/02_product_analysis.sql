-- Q6 : top 5 products by units sold
SELECT p.product_name , SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status IN ('Shipped', 'Delivered')
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 5;

-- Q7 : top 5 products by revenue generated
SELECT p.product_name , SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status IN ('Shipped', 'Delivered')
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- Q8: Revenue per category (completed sales)
SELECT c.category_name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN categories c ON p.category_id = c.category_id
WHERE o.order_status IN ('Shipped', 'Delivered')
GROUP BY c.category_name
ORDER BY revenue DESC;

-- Q9: Products that have never been ordered
SELECT p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- Q10: Least-selling products (completed sales, sold at least once)
SELECT p.product_name, SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status IN ('Shipped', 'Delivered')
GROUP BY p.product_name
ORDER BY units_sold ASC
LIMIT 5;

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