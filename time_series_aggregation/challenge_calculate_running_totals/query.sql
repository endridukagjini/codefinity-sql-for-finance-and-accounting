SELECT transaction_date, amount, description,
    SUM(amount) OVER ( 
    ORDER BY transaction_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM transactions-- Write your code here
WHERE category = 'Expense'
ORDER BY transaction_date;