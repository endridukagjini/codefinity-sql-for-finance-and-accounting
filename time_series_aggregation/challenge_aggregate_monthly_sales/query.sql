-- Write your code here
SELECT DATE_TRUNC('month', transaction_date)::date AS month,
    SUM(amount) AS total_sales
FROM transactions
WHERE category = 'Sales'
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month;
