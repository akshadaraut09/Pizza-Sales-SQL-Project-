# Total Quantity Ordered by Category

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

# Category-wise Pizza Distribution
SELECT 
    category,
    COUNT(name)
FROM pizza_types
GROUP BY category;

# Top 3 Revenue-Generating Pizzas in Each Category
SELECT name,revenue
FROM
(SELECT category,name,revenue,
        RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
    FROM
    (
        SELECT 
            pizza_types.category,
            pizza_types.name,
            SUM(order_details.quantity * pizzas.price) AS revenue
        FROM pizza_types
        JOIN pizzas
            ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN order_details
            ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY pizza_types.category, pizza_types.name
    ) AS a
) AS b
WHERE rn <= 3;

