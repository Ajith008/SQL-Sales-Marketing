use project_sql;

-- 1. What is the total number of web events for each account?
select account_id, count(*) as web_event_count 
from web_events
group by account_id
order by count(*) desc;
/*
Top Account by Web Events:
Account 3051 leads with the highest number of web events (101), followed closely by Account 3911 (96) and Account 2351 (94).

Web Event Distribution:
The number of web events per account varies significantly. While the top accounts have around 100 events, 
many others have much fewer events, with some accounts having as few as 1 event.
A majority of accounts have between 10 and 50 web events, suggesting that a large proportion of accounts may have low or moderate engagement on the web.

Low Engagement Accounts:
Accounts like 4001, 4021, 4071, 4321, and others only have 1 web event, highlighting potential areas where web activity is minimal.

Potential Insights:
Accounts with high web event counts may be more engaged with the platform or have more active customers, 
while accounts with low event counts could represent opportunities for increased marketing or outreach to boost interaction.
A focus on high-engagement accounts could reveal successful strategies that might be applied to lower-engagement accounts to increase activity.
*/

-- 2. How do web event frequencies correlate with total sales?
SELECT we.account_id, 
       COUNT(we.web_id) AS total_web_events, 
       round(SUM(o.total_amt_usd),2) AS total_sales
FROM web_events we
LEFT JOIN orders o ON we.account_id = o.account_id
GROUP BY we.account_id
ORDER BY total_sales DESC;
/*
Positive Correlation: There appears to be a positive correlation between the number of web events and total sales. 
Accounts with higher web events tend to have higher total sales, such as account 1521 with 3145 web events and $16,116,328.7 in sales. 
However, this trend may not be perfectly linear across all accounts.

Sales vs. Web Events: While the majority of high-sales accounts also have a significant number of web events (e.g., accounts 3051, 2351), 
some accounts with fewer web events still have high sales, indicating that web events alone may not fully explain sales performance.

Low Web Events & Low Sales: Several accounts with low web events (e.g., account 4401 with only 1 event and sales of $1) 
indicate that a low number of web events might not necessarily equate to low sales, although the correlation could be stronger for some accounts.

Potential for Further Investigation: Outliers, such as accounts with low web events and unexpectedly high sales, 
could be due to other factors such as marketing, product appeal, or external influencers, which warrant deeper investigation to 
understand what drives sales beyond web events.

In summary, the general trend suggests a correlation between web events and sales, but there are notable outliers, 
and the relationship between the two metrics is complex and not solely determinable from this dataset. 
Further analysis could involve factors like customer engagement, product type, or seasonal trends.
*/

-- 3. Which channel generates the most web events, and does it lead to higher sales conversions?
SELECT web_channel, COUNT(*) AS event_count
FROM web_events
GROUP BY web_channel
ORDER BY event_count DESC;
/*
The direct channel generates the most web events, significantly outpacing other channels. 
Despite this, it's important to assess if the number of events correlates with higher sales conversions. 
While direct traffic drives the most engagement, further analysis is needed to evaluate whether this high volume translates 
into higher conversion rates or if other channels, like Facebook or Adwords, yield better sales performance per event.
*/

-- 4. Identify accounts with web events but no associated orders.
SELECT we.account_id, COUNT(we.web_id) AS web_event_count
FROM web_events we
LEFT JOIN orders o ON we.account_id = o.account_id
WHERE o.order_id IS NULL
GROUP BY we.account_id;
/*
These accounts are likely engaging with the website (e.g., through browsing or other activities) 
but are not converting into sales. The significant number of web events, especially for accounts like 4291 (38 events) and 4311 (39 events), 
suggests potential issues in the conversion process. Further investigation is needed to understand why these accounts are not completing purchases, 
such as checking for possible issues with the sales funnel, user experience, or product offering.
*/