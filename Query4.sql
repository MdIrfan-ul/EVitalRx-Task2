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
