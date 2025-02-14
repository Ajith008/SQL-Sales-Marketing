use project_sql;

-- 1. What is the monthly trend in total revenue for each region?
SELECT r.region_name AS region_name, 
       extract(month from o.occurred_at) AS month_val, 
       SUM(o.total_amt_usd) AS total_revenue
FROM orders o
JOIN accounts a ON o.account_id = a.account_id
JOIN sales_reps sr ON a.sales_rep_id = sr.id
JOIN region r ON sr.region_id = r.region_id
GROUP BY r.region_name, month_val
ORDER BY r.region_name, month_val;
/*
Midwest: Revenue starts at $71,606 in January and steadily increases through the year, peaking at $212,929 in December. 
There's a significant increase in the second half of the year.

Northeast: This region shows a strong upward trend, starting at $230,050 in January and peaking at $439,174 in December. 
The highest revenues occur in the second half, especially in December.

Southeast: Revenue starts at $178,060 and fluctuates, but grows consistently toward $363,155 in December. 
The region's revenues spike in the second half of the year, particularly in August.

West: The West region shows a dip early in the year but significantly increases starting in June, reaching a peak of $500,922 in December.

Inference:
Strong seasonality: All regions experience an increase in revenue during the second half of the year, particularly in December. 
This could indicate holiday sales or other seasonal trends.

Regional performance: The Northeast and West regions have higher revenue spikes, especially in December, 
which suggests stronger market performance or product demand in these regions during the latter part of the year.

Southeast and Midwest: While these regions see growth, they don’t experience the same level of peak growth as the Northeast and West, 
indicating that their markets might be less seasonal or have more consistent but moderate sales.
*/

-- 2. Are there seasonal trends in orders or web events?
SELECT EXTRACT(month FROM occurred_at) AS order_month, 
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY total_orders DESC;
/*
December: The month with the highest number of orders (520). This suggests a peak in demand, likely due to holiday shopping or end-of-year promotions.

November: Following December, November has 412 orders, indicating strong pre-holiday sales or promotions as well.

October: Orders slightly decrease to 400, but still maintain a relatively high level.

March through February: These months show a consistent decrease in the number of orders, with the lowest in February (241).

Inference:
Seasonal peak in late fall and winter: December and November show significantly higher order volumes, which likely correspond to holiday shopping periods. 
This suggests that the business sees an uptick in sales during the end-of-year months.
Steady drop in early months: The decrease in orders from January to February suggests a post-holiday lull in sales.
*/

-- 3. How has the average order value changed over time?
SELECT extract(month from occurred_at) AS month_val, 
       round(AVG(total_amt_usd),2) AS avg_order_value
FROM orders
GROUP BY month_val
ORDER BY month_val;
/*
January: The average order value starts at $2214.71, which is relatively low compared to other months.

March: The value increases to $2821.13, showing a notable rise.

April-May: April sees a slight decrease ($2644.09), followed by a more significant drop in May ($2176.48).

June: A noticeable jump in average order value to $3088.65, the highest value of the year.

July to October: After June, the value begins to decrease again, with some fluctuations, 
reaching a low in August ($2391.03) and staying relatively stable for the next few months.

December: The average order value spikes again to $2915.73, suggesting strong sales towards the end of the year.

Inference:
Fluctuations: There are fluctuations in the average order value, with the highest values observed in June and December. 
These months may coincide with seasonal trends, such as mid-year sales or holiday promotions, influencing the average order value.

Consistent variation: The data shows a consistent trend of higher average order values in the middle and end of the year, 
with slight dips during the spring and summer months. This could be due to different sales strategies or external factors like holidays and promotions.
*/