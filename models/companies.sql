SELECT
    company,
    COUNT(*) AS models,
    SUM(scooters) AS scooters
FROM
    {{ ref("scooters") }}
GROUP BY company
