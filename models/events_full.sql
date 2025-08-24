SELECT
    e.type_id,
    user_id,
    timestamp,
    type
FROM {{ ref("events_clean") }} AS e
LEFT JOIN {{ ref("event_types") }} AS t
    ON e.type_id = t.type_id