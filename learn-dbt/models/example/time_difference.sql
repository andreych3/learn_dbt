{{ config(materialized='incremental', unique_key = 'table_time') }}


select *, to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) as table_time
from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
where to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) < current_time

{% if is_incremental() %}
  and table_time > (select max(table_time) from {{this}})
{% endif %}
