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
