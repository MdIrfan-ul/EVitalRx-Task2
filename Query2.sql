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
