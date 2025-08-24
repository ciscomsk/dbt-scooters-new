WITH unnest_cte AS (
    SELECT
        UNNEST(ARRAY[started_at, finished_at]) AS timestamp,
        UNNEST(ARRAY[1, -1]) AS increment
    FROM {{ source("scooters_raw", "trips") }}
),
sum_cte AS (
    SELECT
        timestamp,
        SUM(increment) AS increment,
        true AS preserve_row
    FROM unnest_cte
    WHERE
    {% if is_incremental() %}
        timestamp > (SELECT MAX(timestamp) FROM {{ this }})
    {% else %}
        timestamp < (DATE '2023-06-01' + INTERVAL '7' HOUR) AT TIME ZONE 'Europe/Moscow'
    {% endif %}
    GROUP BY timestamp
    {% if is_incremental() %}
    UNION ALL
    SELECT
        timestamp,
        concurrency AS increment,
        false AS preserve_row
    FROM {{ this }}
    WHERE timestamp = (SELECT MAX(timestamp) FROM {{ this }})
    {% endif %}
),
cumsum_cte AS (
    SELECT
        timestamp,
        SUM(increment) OVER (ORDER BY timestamp) AS concurrency,
        preserve_row
    FROM sum_cte
)
SELECT
    timestamp,
    concurrency,
    {{ updated_at() }}
FROM cumsum_cte
WHERE preserve_row
ORDER BY timestamp
