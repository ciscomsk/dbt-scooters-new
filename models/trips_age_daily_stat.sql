SELECT
    age,
    AVG(trips) AS avg_trips,
    AVG(revenue_rub) AS avg_revenue_rub
FROM {{ ref("trips_age_daily") }}
GROUP BY age
ORDER BY age
