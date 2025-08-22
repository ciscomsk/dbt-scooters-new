SELECT
    id,
    st_setsrid(st_makepoint(start_lon, start_lat), 4326) AS start_point,
    st_setsrid(st_makepoint(finish_lon, finish_lat), 4326) AS finish_point
FROM {{ source("scooters_raw", "trips") }}
