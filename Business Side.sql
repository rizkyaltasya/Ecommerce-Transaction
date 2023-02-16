--- Business Side:
#1. Find out our total sales for a whole business monthly, daily, weekly 
#2. Determine average sales for a whole business monthly, daily, weekly (Rare)
#3. Compare number that above average sales from each type monthly, daily, weekly (Rare) 
#4. Find out the trend for customer growth monthly which remarks by new & first sign up
#5. Determine sales revenue, net profit, retention rate, cost ratio and net promoter score
#6. Conclusion of business side
#7. Added payment method monthly, daily, weekly

--- 1
SELECT 
    MONTH(order_date) AS month,
    ROUND(SUM(amount_usd), 3) AS total_revenue,
    ROUND(SUM(profit), 3) AS total_profit
FROM
    ecommerce
GROUP BY 1
ORDER BY 1;

---- 2
with cte as (
select
	avg(amount_usd) as average_revenue
from
	ecommerce)
select
	month(order_date) as month,
    count(ecommerce.customer_id) as total_customer,
	sum(case when ecommerce.amount_usd > cte.average_revenue then 1 else 0 end) as total_customers_above_average_revenue,
    sum(case when ecommerce.amount_usd > cte.average_revenue then 1 else 0 end)/count(ecommerce.customer_id) as conversion_rate_above_average_revenue
from
	ecommerce
		join
	cte on ecommerce.customer_id = ecommerce.customer_id
group by 1
order by 1;

SELECT 
    customer_login_type
FROM
    ecommerce
GROUP BY 1;

--- 3
SELECT 
    MONTH(order_date) AS month,
    customer_login_type,
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    ecommerce
GROUP BY 1 , 2
ORDER BY 1 , 3 DESC;

--- 4
SELECT 
    MONTH(order_date) AS month,
    ROUND(SUM(amount_usd) / COUNT(DISTINCT customer_id),
            3) AS revenue_per_customer,
    ROUND(SUM(profit) / COUNT(DISTINCT customer_id),
            3) AS profit_per_customer
FROM
    ecommerce
GROUP BY 1
ORDER BY 1;

--- 5 

	
    





