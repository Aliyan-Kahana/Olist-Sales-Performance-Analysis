SELECT 
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(order_totals.order_value), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN (
    SELECT order_id, SUM(price) AS order_value
    FROM order_items
    GROUP BY order_id
) order_totals ON o.order_id = order_totals.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 5;

# What are the top 5 and bottom 5 product categories by total sales volume and total revenue using English category names?
WITH category_sales AS (
    SELECT 
        t.product_category_name_english AS category_name,
        COUNT(oi.order_item_id) AS items_sold,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
    GROUP BY t.product_category_name_english
)
(SELECT category_name, items_sold, total_revenue, 'Top 5' AS group_type
 FROM category_sales
 ORDER BY total_revenue DESC
 LIMIT 5)
UNION ALL
(SELECT category_name, items_sold, total_revenue, 'Bottom 5' AS group_type
 FROM category_sales
 ORDER BY total_revenue ASC
 LIMIT 5);

# Which product categories have the highest average freight cost relative to their average item price?
SELECT 
    t.product_category_name_english AS category_name,
    ROUND(AVG(oi.price), 2) AS avg_price,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight,
    ROUND((AVG(oi.freight_value) / AVG(oi.price)) * 100, 2) AS freight_to_price_ratio_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
HAVING AVG(oi.price) > 0
ORDER BY freight_to_price_ratio_pct DESC
LIMIT 10;

# What are the most common payment methods used by customers, and how many orders were paid using each method?
SELECT 
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_amount_paid
FROM order_payments
GROUP BY payment_type
ORDER BY total_orders DESC;
select count(*) from master_df;