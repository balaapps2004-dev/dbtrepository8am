select c_custkey,c_name, {{ mcr_mkt('c_mktsegment') }} as c_mktsegment
 from dev_db.bronze.customer