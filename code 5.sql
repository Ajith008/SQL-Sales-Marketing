use project_sql;

-- 1. Which account has the highest average order size (by total or revenue)?
SELECT account_id, 
       AVG(total) AS avg_order_size
FROM orders
GROUP BY account_id
ORDER BY avg_order_size DESC
LIMIT 10;
/*
Account 4251 has the highest average order size, with an average of $4099.88 per order.
The next highest is Account 4101, with an average of $2093.00, significantly lower than Account 4251 but still substantial.
The other top accounts show a steady decline in average order size, with Account 1031 at $1363.00 and Account 3021 at $1182.00.
The average order sizes continue to decrease across the remaining accounts, with the lowest in the top 10 being Account 3761 at $884.67.

Inference:
High-value accounts: Account 4251 stands out as the most significant contributor in terms of order size, 
indicating it could be a high-value customer or a major account with substantial purchasing power.

High revenue potential: Accounts with higher average order sizes may represent more valuable clients, 
and focusing on retaining these accounts or incentivizing repeat business could be beneficial for increasing total revenue.

Business focus: The business should consider analyzing why accounts like 4251 have such large order sizes—whether it’s due to bulk purchases, 
special pricing agreements, or other factors—and whether those factors can be leveraged for other accounts.
Overall, these accounts with larger average order sizes are key contributors to total revenue, 
and strategic actions to maintain or expand these accounts could yield significant financial returns.
*/

-- 2. What percentage of orders comes from repeat customers?
WITH repeat_customers AS (
    SELECT account_id
    FROM orders
    GROUP BY account_id
    HAVING COUNT(*) > 1
)
SELECT COUNT(DISTINCT o.account_id) AS total_customers, 
       COUNT(DISTINCT rc.account_id) AS repeat_customers,
       (COUNT(DISTINCT rc.account_id) * 100.0 / COUNT(DISTINCT o.account_id)) AS repeat_customer_percentage
FROM orders o
LEFT JOIN repeat_customers rc ON o.account_id = rc.account_id;
/*
Total customers: There are 328 distinct customers in the data.
Repeat customers: Out of these, 291 customers have placed more than one order, qualifying as repeat customers.
Percentage of repeat customers: 88.72% of customers are repeat buyers.

Inference:
Strong customer retention: A high percentage (88.72%) of customers are repeat buyers, indicating strong customer loyalty or satisfaction with the service/product.

Repeat business is a key revenue driver: The majority of orders come from customers who make multiple purchases, 
which is a positive sign for long-term revenue generation.

Opportunity for growth: While a large portion of business comes from repeat customers, 
there may still be an opportunity to convert one-time buyers into repeat customers through targeted marketing strategies or loyalty programs.

In summary, maintaining and nurturing repeat customers is crucial, but efforts to increase the percentage of repeat business among first-time buyers could further boost sales.
*/