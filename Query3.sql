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
