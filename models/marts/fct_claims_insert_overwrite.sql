{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite',
        overwrite_columns=[
            'claim_id', 'member_id', 'provider_id', 'service_date',
            'claim_status', 'billed_amount', 'allowed_amount',
            'paid_amount', 'updated_at', 'ingested_at'
        ]
    )
}}

-- IMPORTANT FOR SNOWFLAKE:
-- insert_overwrite replaces the ENTIRE target table, not just a partition.
-- Therefore this practice model intentionally returns the complete current source state.
select
    claim_id,
    member_id,
    provider_id,
    service_date,
    claim_status,
    billed_amount,
    allowed_amount,
    paid_amount,
    updated_at,
    ingested_at
from {{ ref('stg_claims_info') }}