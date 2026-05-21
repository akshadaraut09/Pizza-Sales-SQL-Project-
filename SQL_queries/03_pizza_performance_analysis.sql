# Highest Priced Pizza 
SELECT 
    pizza_types.name as top_pizza,
    pizzas.price
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

# -------------------------------------
# Most Common Pizza Size Ordered
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM pizzas
JOIN order_details
    ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

# --------------------------------------------
# Top 5 Most Ordered Pizza Types
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

# Top 3 Pizza Types by Revenue

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;
