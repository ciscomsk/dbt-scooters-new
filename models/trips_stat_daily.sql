SELECT
    date,
    COUNT(*) AS trips,
    MAX(price_rub) AS max_price_rub,
    AVG(distance_m) / 1000 AS avg_distance_km,
    AVG(price_rub) / AVG(duration_s) * 60 AS avg_price_rub_per_min
FROM {{ ref("trips_prep") }}
GROUP BY date
ORDER BY date
