--- Marketing Side
#1. Compare percentage rate customer id for each device monthly 
#2. Identify typical merchant prospective based on traffic merchant from customer ID & total sales monthly & daily 
#3. Create intensity of payment method for running campaign marketing & doing partnership with payment gathaway company monthly & daily
#4. Conversion rate of customer login type from each device
#5. Conclusion of Marketing side

--- 1
SELECT 
    device_type
FROM
    ecommerce
GROUP BY 1;
    
SELECT 
    MONTH(order_date) AS month,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE
            WHEN device_type = 'Mobile' THEN customer_id
            ELSE NULL
        END) AS total_customers_mobile,
    COUNT(DISTINCT CASE
            WHEN device_type = 'Mobile' THEN customer_id
            ELSE NULL
        END) / COUNT(DISTINCT customer_id) AS mobile_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN device_type = 'Web' THEN customer_id
            ELSE NULL
        END) AS total_customers_website,
    COUNT(DISTINCT CASE
            WHEN device_type = 'Web' THEN customer_id
            ELSE NULL
        END) / COUNT(DISTINCT customer_id) AS website_conversion_rate
FROM
    ecommerce
GROUP BY 1 
ORDER BY 1;

--- 2
SELECT 
    merchant,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(amount_usd), 3) AS total_sales,
    ROUND(SUM(amount_usd) / COUNT(DISTINCT customer_id),
            3) AS revenue_per_customer,
    ROUND(SUM(profit), 3) AS total_profit,
    ROUND(SUM(profit) / COUNT(DISTINCT customer_id),
            3) AS profit_per_customer
FROM
    ecommerce
GROUP BY 1
ORDER BY 3,5,6;

--- 3
SELECT 
    payment_method,
    ROUND(AVG(CASE
                WHEN wkday = 0 THEN customer_id
                ELSE NULL
            END),
            2) AS mon,
    ROUND(AVG(CASE
                WHEN wkday = 1 THEN customer_id
                ELSE NULL
            END),
            2) AS tue,
    ROUND(AVG(CASE
                WHEN wkday = 2 THEN customer_id
            END),
            2) AS wed,
    ROUND(AVG(CASE
                WHEN wkday = 3 THEN customer_id
            END),
            2) AS thu,
    ROUND(AVG(CASE
                WHEN wkday = 4 THEN customer_id
                ELSE NULL
            END),
            2) AS fri,
    ROUND(AVG(CASE
                WHEN wkday = 5 THEN customer_id
                ELSE NULL
            END),
            2) AS sat,
    ROUND(AVG(CASE
                WHEN wkday = 6 THEN customer_id
                ELSE NULL
            END),
            2) AS sun,
    ROUND(AVG(customer_id), 2) AS avg_sessions
FROM
    (SELECT 
		WEEKDAY(order_date) AS wkday,
		payment_method,
		count(distinct customer_id) as customer_id
    FROM
        ecommerce
    GROUP BY 1 , 2) AS daily_customer
GROUP BY 1
order by 9 DESC;

SELECT 
    WEEK(order_date) AS week,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'Member' THEN customer_id
            ELSE NULL
        END) AS total_members,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'Member' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS member_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'New ' THEN customer_id
            ELSE NULL
        END) AS total_new_member,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'New ' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS new_customer_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'Guest' THEN customer_id
            ELSE NULL
        END) AS total_guests,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'Guest' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS guests_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'First SignUp' THEN customer_id
            ELSE NULL
        END) AS total_first_signup,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'First SignUp' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS first_sign_up_conversion_rate
FROM
    ecommerce
WHERE
    device_type = 'web'
GROUP BY 1;

SELECT 
    HOUR(order_date) AS hour,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'Member' THEN customer_id
            ELSE NULL
        END) AS total_members,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'Member' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS member_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'New ' THEN customer_id
            ELSE NULL
        END) AS total_new_member,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'New ' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS new_customer_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'Guest' THEN customer_id
            ELSE NULL
        END) AS total_guests,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'Guest' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS guests_conversion_rate,
    COUNT(DISTINCT CASE
            WHEN customer_login_type = 'First SignUp' THEN customer_id
            ELSE NULL
        END) AS total_first_signup,
    ROUND(COUNT(DISTINCT CASE
                    WHEN customer_login_type = 'First SignUp' THEN customer_id
                    ELSE NULL
                END) / COUNT(DISTINCT customer_id),
            3) AS first_sign_up_conversion_rate
FROM
    ecommerce
WHERE
    device_type = 'web'
GROUP BY 1;
    

