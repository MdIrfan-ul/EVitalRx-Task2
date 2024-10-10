# Task-2 Database Query on POSTGRESQL


## Task Overview:-

Prepare queries for the below statements:

1.Find User wise - product-wise ordering quantity with total item value
2.Weekly Orders analysis for the first quarter of 2024
3.Retrieve the Product name and No. of Orders from Sales. Exclude products with fewer than 5 Orders.
4.Find the products that are sold more than 7 times or have not sold yet in the first quarter of 2024
___

# Technologies Used:
[![Languages Used](https://skillicons.dev/icons?i=postgresql,git,github)](https://skillicons.dev)

__
## Query
1.Find User wise - product-wise ordering quantity with total item value.

```bash
SELECT 
    u.name AS user_name,
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.price) AS total_item_value
FROM 
    order_items AS oi
INNER JOIN 
    orders AS o ON oi.order_id = o.order_id
INNER JOIN 
    users AS u ON o.user_id = u.user_id
INNER JOIN 
    products AS p ON oi.product_id = p.product_id
GROUP BY 
    u.name, p.name
ORDER BY 
    u.name, p.name;
```

2.Weekly Orders analysis for the first quarter of 2024.

```bash
SELECT 
    DATE_TRUNC('week', o.created_at) AS week,
    COUNT(o.order_id) AS total_orders
FROM 
    orders AS o
WHERE 
    o.created_at BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY 
    week
ORDER BY 
    week;
```
3.Retrieve the Product name and No. of Orders from Sales. Exclude products with fewer than 5 Orders.

```bash
SELECT 
    p.name AS product_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    order_items AS oi
INNER JOIN 
    orders AS o ON oi.order_id = o.order_id
INNER JOIN 
    products AS p ON oi.product_id = p.product_id
GROUP BY 
    p.name
HAVING 
    COUNT(DISTINCT o.order_id) >= 5
ORDER BY 
    total_orders DESC;
```

4.Find the products that are sold more than 7 times or have not sold yet in the first quarter of 2024.
```bash
SELECT 
    p.product_name,
    COALESCE(SUM(oi.quantity), 0) AS total_sold
FROM 
    products AS p
LEFT JOIN 
    order_items AS oi ON p.product_id = oi.product_id
LEFT JOIN 
    orders AS o ON oi.order_id = o.order_id
    AND o.created_at BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY 
    p.product_name
HAVING 
    COALESCE(SUM(oi.quantity), 0) > 7
ORDER BY 
    total_sold DESC;
```