{{ config(
    materialized='incremental',
    incremental_strategy='microbatch',
    event_time='ORDER_DATE',
    batch_size='year',
    begin='2024-01-01',
    unique_key='ORDER_ID'
) }}

select *
from {{ ref('stg_orders') }}