{% macro trips_geom_stat(trips_table, geom_col, grid) %}
    SELECT
        st_transform(hex.geom, 4326) AS geom,
        COUNT(*) AS trips
    FROM {{ trips_table }}
    CROSS JOIN st_hexagongrid({{ grid }}, st_transform({{ geom_col }}, 3857)) AS hex
    WHERE st_intersects(st_transform({{ geom_col }}, 3857), hex.geom)
    GROUP BY geom
{% endmacro %}