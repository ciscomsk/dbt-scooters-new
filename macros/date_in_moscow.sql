{% macro date_in_moscow(ts_col) %}
    ({{ ts_col }} AT TIME ZONE 'Europe/Moscow')::date
{%  endmacro %}