
# Total orders
select count(Order_id) as total_orders
from order_details;


# Distribution of Orders by Hour
SELECT 
    HOUR(order_time) AS hour,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY HOUR(order_time);

#Average Number of Pizzas Ordered Per Day
SELECT 
    ROUND(AVG(quantity), 0) as order_quantity
FROM (SELECT 
        orders.order_date,
        SUM(order_details.quantity) AS quantity
    FROM orders
    JOIN order_details
        ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS order_quantity;
