{{
    config(
        materialized='incremental',
        incremental_strategy='append'
    )
}}
select * from {{ ref('stg_orders') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where UPDATED_AT > (select max(UPDATED_AT) from {{ this }}) 
{% endif %}