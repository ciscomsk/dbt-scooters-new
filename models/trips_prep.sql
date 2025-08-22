SELECT
    id,
    user_id,
    scooter_hw_id,
    started_at,
    finished_at,
    start_lat,
    start_lon,
    finish_lat,
    finish_lon,
    distance AS distance_m,
    price::numeric(20, 2) / 100 AS price_rub,
    EXTRACT (EPOCH FROM (finished_at - started_at)) AS duration_s,
    CASE
        WHEN price = 0 AND started_at != finished_at THEN true
        ELSE false
    END AS is_free,
    started_at::date AS date
FROM {{ source("scooters_raw", "trips") }}
