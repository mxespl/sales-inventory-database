
-- ============================================================
-- NexaStore: Views (saved queries you can use like tables)
-- ============================================================

CREATE VIEW sales_summary AS
SELECT o.order_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       o.order_date,
       o.order_status,
       SUM(oi.unit_price * oi.quantity) AS order_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name, o.order_date, o.order_status;


-- Products whose stock is below their reorder level (includes out-of-stock)
CREATE OR REPLACE VIEW low_stock_products AS
SELECT product_name, stock_quantity, reorder_level
FROM products
WHERE stock_quantity < reorder_level;

-- One row per order: who ordered, when, status, and the order total
CREATE OR REPLACE VIEW sales_summary AS
SELECT o.order_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       o.order_date,
       o.order_status,
       SUM(oi.unit_price * oi.quantity) AS order_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name, o.order_date, o.order_status;