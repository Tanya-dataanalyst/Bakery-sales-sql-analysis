SELECT 
    c.region,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.quantity * p.unit_price) AS total_revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.region
ORDER BY total_revenue DESC;
SELECT 
   c.full_name,
   c.customer_type,
   SUM(s.quantity * p.unit_price) AS total_spent,
   CASE
       WHEN SUM(s.quantity * p.unit_price)>=10000 THEN 'VIP'
	   ELSE 'Standard'
	   END AS customer_tier
FROM sales s
JOIN customers c ON s.customer_id=c.customer_id
JOIN products p ON s.product_id= p.product_id
GROUP BY c.full_name, c.customer_type
ORDER BY total_spent DESC;
SELECT 
    p.product_id,
	p.product_name,
	p.category,
	p.unit_price
FROM products p
LEFT JOIN sales s ON p.product_id=s.product_id
WHERE s.sale_id IS NULL;
