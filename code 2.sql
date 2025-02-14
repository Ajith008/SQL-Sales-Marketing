-- Sales Performance
-- 1. Which region has the highest total sales revenue?
select a.region_name,sum(d.total_amt_usd) as total_sales_revenue
from region as a
inner join
sales_reps as b
on a.region_id = b.region_id
inner join
accounts as c
on b.id = c.sales_rep_id
inner join
orders as d
on c.account_id = d.account_id
group by a.region_name
order by sum(d.total_amt_usd) desc
limit 1;
/*
Region with Highest Sales Revenue: Northeast ($3,599,720.49)
Inference: The Northeast not only has the most accounts but also generates the highest revenue, 
indicating a strong market presence and sales performance. 
This region may have higher-value accounts, better sales strategies, or a more active customer base.
*/

-- 2. What is the average order value for each account?
SELECT account_id, AVG(TOTAL_AMT_USD) as avg_sales_revenue from orders
GROUP BY account_id
order by avg(total_amt_usd) desc;
/*
High Variability in Average Order Value:
The average order value varies significantly across accounts, 
ranging from $31,583 to $885, indicating different customer purchasing behaviors and spending capacities.

Top-Spending Accounts:
The highest average order value ($31,583.25) belongs to account 4251, 
suggesting this account frequently places large orders or deals in high-value transactions. 
Other top accounts (e.g., 4101, 3021) also have relatively high spending.

Long Tail Distribution:
The distribution suggests a few accounts contribute a large portion of revenue, 
while many others have relatively lower average order values.

Potential Account Segmentation:
The data suggests the possibility of segmenting accounts into high, medium, and low-value customers. 
This can inform targeted marketing strategies and account management efforts.

Sales Strategy Insights:
For accounts with low average order values, strategies such as upselling, 
bundling, or discounts could be used to increase their spending.
Top accounts should be prioritized for relationship management to maintain or increase their order size.
*/

-- 3. Identify the top 5 accounts by total revenue.
select account_id, sum(total_amt_usd) as total_revenue from orders
group by account_id
order by sum(total_amt_usd) desc
limit 5;
/*
Top Revenue Accounts: Account 4251 generates the highest revenue ($252,666.04), followed by 4161, 1521, 4151, and 1281.
Revenue Concentration: A few accounts contribute significantly to total revenue, suggesting a need for customer retention strategies.
Business Strategy: These high-value accounts should receive premium service and personalized engagement to maintain loyalty.
Risk Factor: Heavy reliance on these accounts poses a churn risk, so diversification of revenue sources is essential.
*/


-- 4. Which sales rep has the highest sales revenue, and how does it compare to others?
WITH sales_revenue AS (
    SELECT 
        sr.rep_name AS sales_rep_name,
        round(SUM(o.total_amt_usd),2) AS total_revenue
    FROM 
        sales_reps sr
    JOIN 
        accounts a ON sr.id = a.sales_rep_id
    JOIN 
        orders o ON a.account_id = o.account_id
    GROUP BY 
        sr.rep_name
)

SELECT 
    sales_rep_name,
    total_revenue,
    round(total_revenue - FIRST_VALUE(total_revenue) OVER (ORDER BY total_revenue DESC),2) AS revenue_difference,
    ROUND(100.0 * (total_revenue - FIRST_VALUE(total_revenue) OVER (ORDER BY total_revenue DESC)) / FIRST_VALUE(total_revenue) OVER (ORDER BY total_revenue DESC), 2) AS percentage_difference
FROM 
    sales_revenue
ORDER BY 
    total_revenue DESC;
/*
Top Sales Rep:
Earlie Schleusner has the highest total revenue of $506,470.92, significantly leading the others.

Comparison with Others:
The second-highest rep, Moon Torian, lags by $32,098.84, a 6.34% decrease in revenue.
As we move down, the gap widens with reps like Tia Amato (7.95% lower) and Dawna Agnew (18.86% lower), 
highlighting Earlie Schleusner's dominance in terms of revenue generation.

Revenue Gap:
The difference between the highest and lowest (Nakesha Renn at $15,717.12) is a massive $490,753.80, 
which emphasizes the performance disparity across sales reps.

Focus for Strategy:
Earlie Schleusner's performance could be a benchmark for others. 
Replicating their sales tactics, customer engagement, or account management strategies could benefit others.
High-performing reps could serve as mentors or models for training and improving overall sales performance.
*/