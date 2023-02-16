---- Product Side -----
#1. Compare for each product category monthly
#2. Find out conversion rate from each product category to specific product with the partition rank
#3. Identify product level sales analysis include total sales and average sales per order
#4. Compare frequently payment method for each section of product category
#5. Conclusion of product side

---- 1
SELECT 
    MONTH(order_date) AS month,
    product_category,
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    ecommerce
GROUP BY 1, 2;

---- 2    
SELECT 
    product,
    COUNT(DISTINCT CASE
            WHEN product_category = 'Auto & Accessories' THEN customer_id
            ELSE NULL
        END) AS total_customers_type_auto_and_accessories
FROM
    ecommerce
WHERE
    product_category = 'Auto & Accessories'
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    product,
    COUNT(DISTINCT customer_id) AS total_customers_fashion
FROM
    ecommerce
WHERE
    product_category = 'Fashion'
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    product,
    COUNT(DISTINCT customer_id) AS total_customers_home_and_furnitures
FROM
    ecommerce
WHERE
    product_category = 'Home & Furniture'
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    product,
    COUNT(DISTINCT customer_id) AS total_customers_electronics
FROM
    ecommerce
WHERE
    product_category = 'Electronic'
GROUP BY 1
ORDER BY 2 DESC;

---- 3
SELECT 
    product_category,
    COUNT(DISTINCT customer_id) AS total_customer,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'Member' THEN customer_id
            ELSE NULL
        END) AS Total_Members,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'Guest' THEN customer_id
            ELSE NULL
        END) AS Total_Guests,
    COUNT(DISTINCT CASE
            WHEN customer_login_type IN ('New ' , 'first SignUp') THEN customer_id
            ELSE NULL
        END) AS Total_New_and_Potential_Customer
FROM
    ecommerce
GROUP BY 1
ORDER BY 3 DESC;
    
SELECT 
    product_category,
    ROUND(SUM(amount_usd), 3) AS total_revenue,
    ROUND(SUM(amount_usd) / COUNT(DISTINCT customer_id),
            3) AS revenue_per_customer,
    ROUND(SUM(profit), 3) AS total_profit,
    ROUND(SUM(profit) / COUNT(DISTINCT customer_id),
            3) AS profit_per_customer
FROM
    ecommerce
GROUP BY 1
ORDER BY 3 DESC;

--- 4
SELECT 
    payment_method,
    COUNT(DISTINCT customer_id) AS total_customer_payments,
    COUNT(DISTINCT CASE
            WHEN product_category = 'Auto & Accessories' THEN customer_id
            ELSE NULL
        END) AS total_payments_auto_accessories,
    COUNT(DISTINCT CASE
            WHEN product_category = 'Fashion' THEN customer_id
            ELSE NULL
        END) AS total_payments_fashion,
    COUNT(DISTINCT CASE
            WHEN product_category = 'Electronic' THEN customer_id
            ELSE NULL
        END) AS total_payments_electronic,
    COUNT(DISTINCT CASE
            WHEN product_category = 'Home & Furniture' THEN customer_id
            ELSE NULL
        END) AS total_payments_home_furniture
FROM
    ecommerce
GROUP BY 1
ORDER BY 2 DESC;







