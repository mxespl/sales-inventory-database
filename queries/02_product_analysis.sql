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