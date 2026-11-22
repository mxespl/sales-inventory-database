-- ============================================================
-- NexaStore: Inventory analysis (Q15-Q18)
-- ============================================================

-- Q15: Products below their reorder level (includes out-of-stock)
SELECT product_name, stock_quantity, reorder_level
FROM products
WHERE stock_quantity < reorder_level
ORDER BY stock_quantity ASC;

-- Q16: Products that are out of stock
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity = 0;

-- Q17: Total inventory value (price x stock, summed over all products)
SELECT SUM(price * stock_quantity) AS total_inventory_value
FROM products;

-- Q18: Number of products in each category
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY c.category_name;