{{
    config(
        materialized='ephemeral'
    )
}}
select * from {{ source('s1', 'customers') }}