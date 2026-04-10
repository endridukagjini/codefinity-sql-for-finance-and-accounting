SELECT
  year,
  month,
  total_revenue,
  last_year_revenue,
  ((total_revenue - last_year_revenue) * 100) / last_year_revenue AS yoy_growth_percent
FROM (
  SELECT
    EXTRACT(YEAR FROM revenue_date)   AS year,
    EXTRACT(MONTH FROM revenue_date)  AS month,
    SUM(amount)                       AS total_revenue,
    LAG(SUM(amount)) OVER (
      PARTITION BY EXTRACT(MONTH FROM revenue_date)
      ORDER BY   EXTRACT(YEAR  FROM revenue_date)
    )                                  AS last_year_revenue
  FROM revenue
  GROUP BY
    EXTRACT(YEAR  FROM revenue_date),
    EXTRACT(MONTH FROM revenue_date)
) sub
WHERE last_year_revenue IS NOT NULL
ORDER BY month, year;