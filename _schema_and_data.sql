DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    unit_price NUMERIC(10, 2)
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    sale_date DATE,
    region VARCHAR(30)
);

INSERT INTO products (product_name, category, unit_price) VALUES
('Chocolate Fudge Cake', 'Cakes', 2500.00),
('Red Velvet Bento', 'Bento', 1200.00),
('Salted Caramel Cupcakes', 'Cupcakes', 1800.00),
('Cinnamon Rolls Box', 'Pastries', 1500.00),
('Lotus Biscoff Cake', 'Cakes', 3200.00);

INSERT INTO sales (product_id, quantity, sale_date, region) VALUES
(1, 3, '2026-11-01', 'Westlands'),
(2, 5, '2026-11-02', 'Kilimani'),
(3, 2, '2026-11-03', 'Fedha'),
(1, 1, '2026-11-04', 'Karen'),
(5, 2, '2026-11-05', 'Westlands'),
(4, 4, '2026-11-06', 'Fedha');

DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50),
    phone VARCHAR(20),
    customer_type VARCHAR(20),
	region VARCHAR (20)
);

INSERT INTO customers (full_name, phone, customer_type,region) VALUES
('Amina Hassan', '0712 345 678', 'Corporate', 'Westlands'),
('Brian Kamau', '0722 987 654', 'Individual', 'Fedha'),
('Grace Wanjiku', '0733 456 789', 'Individual', 'Karen'),
('David Ochieng', '0701 112 233', 'Corporate', 'Kilimani');

ALTER TABLE sales
ADD COLUMN customer_id INT REFERENCES customers(customer_id);

UPDATE sales SET customer_id = 1 WHERE sale_id IN (1, 5);
UPDATE sales SET customer_id = 2 WHERE sale_id IN (2, 4);
UPDATE sales SET customer_id = 3 WHERE sale_id = 3;
UPDATE sales SET customer_id = 4 WHERE sale_id = 6;


