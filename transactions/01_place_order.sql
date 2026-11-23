-- ============================================================
-- Demo 1: Successful order (Lisa buys 2 Swift Gaming Mice + 1 XL Mousepad)
-- ============================================================
BEGIN;

-- Step 1: create the order
INSERT INTO orders (customer_id, order_status)
VALUES (28, 'Pending');

-- Step 2: item 1 = 2x Swift Gaming Mouse (product 6)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (currval(pg_get_serial_sequence('orders', 'order_id')),  -- the order we just created
        6,                                                       -- product
        2,                                                       -- quantity
        (SELECT price FROM products WHERE product_id = 6));      -- today's price

UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 6;

-- Step 3: item 2 = 1x XL Mousepad (product 21)

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (currval(pg_get_serial_sequence('orders', 'order_id')),
        21,
        1,
        (SELECT price FROM products WHERE product_id = 21));

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 21;

COMMIT;


-- ============================================================
-- Demo 2: Failed order (not enough stock)
-- Lisa orders 1 XL Mousepad (in stock) + 2 Wireless Earbuds (stock = 0).
-- The earbuds UPDATE would make stock -2, so the CHECK constraint
-- (stock_quantity >= 0) rejects it and the whole order is rolled back.
-- ============================================================
BEGIN;

INSERT INTO orders (customer_id, order_status)
VALUES (28, 'Pending');

-- Item 1: 1x XL Mousepad (product 21), succeeds
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (currval(pg_get_serial_sequence('orders', 'order_id')),
        21, 1, (SELECT price FROM products WHERE product_id = 21));

UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 21;

-- Item 2: 2x Wireless Earbuds (product 13), FAILS: only 0 in stock
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (currval(pg_get_serial_sequence('orders', 'order_id')),
        13, 2, (SELECT price FROM products WHERE product_id = 13));

UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 13;
-- ^ ERROR: violates check constraint "products_stock_quantity_check"

ROLLBACK;  -- undo everything since BEGIN