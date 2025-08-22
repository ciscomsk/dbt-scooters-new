WITH date_age_cte AS (
    SELECT
        t.*,
        EXTRACT(YEAR FROM started_at) - EXTRACT(YEAR FROM birth_date) AS age
    FROM {{ ref("trips_prep") }} AS t
    INNER JOIN {{ source("scooters_raw", "users") }} as u
        ON t.user_id = u.id
    )
SELECT
    date,
    age,
    COUNT(*) AS trips,
    SUM(price_rub) AS revenue_rub
FROM date_age_cte
GROUP BY
    date,
    age
