#Which top 5 customer states generate the highest total revenue for delivered orders, and what is the average order value in each
#of those states?
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

# What percentage of delivered orders arrived on time in each customer state, and how many days early or late were they on average?
SELECT 
    c.customer_state,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS on_time_pct,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date)), 2) AS avg_days_vs_estimate
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY on_time_pct ASC;

# How does delivery speed affect customer reviews? Group delivered orders into delivery-time bands and compare the average review score.
SELECT 
    CASE 
        WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) <= 7 THEN '0-7 days'
        WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) <= 14 THEN '8-14 days'
        WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) <= 21 THEN '15-21 days'
        ELSE 'Over 21 days'
    END AS delivery_band,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'Delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_band
ORDER BY MIN(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp));

# Who are the top 3 sellers by revenue in each seller state?
WITH seller_revenue AS (
    SELECT 
        s.seller_state,
        s.seller_id,
        COUNT(DISTINCT oi.order_id) AS total_orders,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM order_items oi
    JOIN sellers s ON oi.seller_id = s.seller_id
    GROUP BY s.seller_state, s.seller_id
),
ranked_sellers AS (
    SELECT 
        seller_state,
        seller_id,
        total_orders,
        total_revenue,
        RANK() OVER (PARTITION BY seller_state ORDER BY total_revenue DESC) AS revenue_rank
    FROM seller_revenue
)
SELECT seller_state, seller_id, total_orders, total_revenue, revenue_rank
FROM ranked_sellers
WHERE revenue_rank <= 3
ORDER BY seller_state, revenue_rank;

# How does revenue change from one month to the next? Show month-over-month growth for delivered orders.
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(oi.price), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
)
SELECT 
    order_month,
    revenue,
    LAG(revenue) OVER (ORDER BY order_month) AS previous_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY order_month)) * 100.0 / LAG(revenue) OVER (ORDER BY order_month), 2) AS mom_growth_pct
FROM monthly_revenue
ORDER BY order_month;

select count(*) from master_df;
