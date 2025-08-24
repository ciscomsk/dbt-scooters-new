SELECT
    COUNT(type = 'cancel_search' or null)::float / COUNT(type = 'start_search' or null) * 100 AS cancel_pct
FROM {{ ref("events_full") }}