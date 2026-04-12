SELECT
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    CASE
        WHEN LAG(total_revenue) OVER (ORDER BY month) IS NULL THEN NULL
        WHEN LAG(total_revenue) OVER (ORDER BY month) = 0 THEN NULL
        ELSE (total_revenue - LAG(total_revenue) OVER (ORDER BY month)) / LAG(total_revenue)OVER (ORDER BY month) * 100
    END AS percent_growth
FROM (
    SELECT
        DATE_TRUNC('month', revenue_date) AS month,
        SUM(amount) AS total_revenue
    FROM revenue
    GROUP BY DATE_TRUNC('month', revenue_date)
) monthly_revenue
ORDER BY month;