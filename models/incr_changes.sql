{{
    config(
        materialized='incremental',
        unique_key='empno',
        on_schema_change='append_new_columns'        
    )
}}
select * from dev_db.bronze.s_emp

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where d_upd_Date > (select max(d_upd_Date) from {{ this }}) 
{% endif %}