WITH trips_cte AS (
    SELECT
        company,
        COUNT(*) AS trips
    FROM {{ ref("trips_prep") }} AS t
    JOIN {{ ref("scooters") }} AS s
        ON t.scooter_hw_id = s.hardware_id
    GROUP BY company
)
SELECT
    t.company,
    trips,
    scooters,
    trips::float / scooters AS trips_per_scooter
FROM trips_cte AS t
JOIN {{ ref("companies") }} AS c
    ON t.company = c.company
