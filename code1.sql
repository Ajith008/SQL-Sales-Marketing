use project_sql;

/*SET SESSION sql_mode = '';
LOAD DATA INFILE 'web_events.csv' INTO TABLE web_events
FIELDS terminated by ','
IGNORE 1 LINES;
SELECT * FROM web_events;*/

-- 1. How many accounts are there in total, and how are they distributed across regions?
SELECT 
    r.region_name,
    COUNT(a.account_id) AS total_accounts
FROM 
    accounts a
JOIN 
    sales_reps s ON a.sales_rep_id = s.id
JOIN 
    region r ON s.region_id = r.region_id
GROUP BY 
    r.region_name
ORDER BY 
    total_accounts DESC;
    
    
/*
Total Accounts: 351, with Northeast (106) having the most and Midwest (48) the least.
Inference: The Northeast is likely a key market, while the Midwest may need more sales efforts or market expansion.
*/
    
    -- 2. Which sales rep manages the most accounts, and which manages the least?
SELECT 
    s.rep_name,
    COUNT(a.account_id) AS accounts_managed
FROM 
    accounts a
JOIN 
    sales_reps s ON a.sales_rep_id = s.id
GROUP BY 
    s.rep_name
ORDER BY 
    accounts_managed DESC;

/*
Most Accounts Managed: Georgianna Chisholm (15 accounts)
Least Accounts Managed: Multiple sales reps (3 accounts each)
Inference: Account distribution among sales reps is uneven. 
Georgianna Chisholm handles the highest workload, while several reps manage significantly fewer accounts, 
indicating potential imbalances in workload or sales opportunities.
*/