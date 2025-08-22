SELECT
    t.*,
    u.sex,
    EXTRACT(YEAR FROM t.started_at) - EXTRACT(YEAR FROM u.birth_date) AS age
FROM {{ ref("trips_prep") }} AS t
LEFT JOIN {{ source("scooters_raw", "users") }} AS u
    ON t.user_id = u.id
{% if is_incremental() %}
    WHERE t.id > (SELECT MAX(id) FROM {{ this }})
    ORDER BY t.id
    LIMIT 75000
{% else %}
    WHERE t.id <= 75000
{% endif %}
