# Commercial Bakery Sales & Customer Segmentation Analysis (PostgreSQL)

## Business Overview
This project analyzes retail, corporate, and event bakery sales across Nairobi neighborhoods using PostgreSQL and pgAdmin 4. The objective is to evaluate regional revenue performance, segment high-value VIP customers, and audit slow-moving inventory to support commercial decision-making.

## Database Architecture
The database uses a 3-table relational schema connecting transactional sales records to product and customer lookup tables:
* **`products`**: Stores product catalog details (`product_id`, `product_name`, `category`, `unit_price`).
* **`customers`**: Stores client profiles (`customer_id`, `full_name`, `customer_type`, `region`).
* **`sales`**: Central transaction table (`sale_id`, `product_id`, `customer_id`, `quantity`, `sale_date`).

---

## Key Business Questions & SQL Solutions

### 1. Regional Sales & Revenue Performance
**Question:** *Which Nairobi neighborhoods generate the highest unit volume and revenue?*
```sql
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
        WHEN SUM(s.quantity * p.unit_price) >= 10000 THEN 'VIP'
        ELSE 'Standard'
    END AS customer_tier
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.full_name, c.customer_type
ORDER BY total_spent DESC;
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;

##**Key Takeaways and recommendations
Corporate orders in Westlands drove the highest total revenue.
Segmenting buyers at the Ksh 10000 threshold isolates repeat high-clients for targeted retention offers.
**
