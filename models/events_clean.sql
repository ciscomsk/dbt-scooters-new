{% set date = var("date", none) %}
SELECT DISTINCT
    user_id,
    timestamp,
    type_id,
    {{ updated_at() }}
FROM {{ source("scooters_raw", "events") }}
WHERE
{% if is_incremental() %}
    {% if date %}
        DATE(timestamp) = DATE '{{ date }}'
    {% else %}
        timestamp > (SELECT MAX(timestamp) FROM {{ this }})
    {% endif %}
{% else %}
    timestamp < TIMESTAMP '2023-08-01'
{% endif %}
