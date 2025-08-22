SELECT DISTINCT
    user_id,
    timestamp,
    type_id
FROM {{ source("scooters_raw", "events") }}
{% if is_incremental() %}
    WHERE timestamp > (SELECT MAX(timestamp) FROM {{ this }})
{% else %}
    WHERE timestamp < DATE '2023-08-01'
{% endif %}