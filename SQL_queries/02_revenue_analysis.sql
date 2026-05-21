# Total Revenue Generated 
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_sales_revenue
FROM order_details
JOIN pizzas
    ON pizzas.pizza_id = order_details.pizza_id;
    
# Percentage Contribution by Pizza Category

SELECT 
    pizza_types.category,
    ROUND(
        SUM(order_details.quantity * pizzas.price) /
        (
            SELECT SUM(order_details.quantity * pizzas.price)
            FROM order_details
            JOIN pizzas
                ON pizzas.pizza_id = order_details.pizza_id
        ) * 100,
    2) AS revenue
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

# Cumulative Revenue Over Time
SELECT 
    order_date,
    SUM(revenue) OVER(ORDER BY order_date) AS cum_revenue
FROM
(
    SELECT 
        orders.order_date,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
    JOIN pizzas
        ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders
        ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS sales;
