-- Speeds up finding all orders of one customer (customer order history, Q11-Q14)
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- Speeds up filtering and grouping orders by date (monthly revenue, Q4)
CREATE INDEX idx_orders_order_date ON orders(order_date);

-- Speeds up joining orders to their items
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Speeds up finding all sales of one product (product analysis, Q6-Q10)
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Note: customers.email is already indexed by its UNIQUE constraint,
-- so no extra index is needed for searching customers by email.