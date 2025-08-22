SELECT
    st_transform(hex.geom, 4326) AS geom,
    COUNT(*) AS trips
FROM {{ ref("trips_geom") }} AS t
CROSS JOIN st_hexagongrid(500, st_transform(t.start_point, 3857)) AS hex
WHERE st_intersects(st_transform(t.start_point, 3857), hex.geom)
GROUP BY geom
