{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='claim_id',
        cluster_by=['service_date'],
        on_schema_change='sync_all_columns'
    )
}}

with changed_claims as (

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

    {% if is_incremental() %}
      -- Re-read a small lookback window to catch late-arriving corrections.
      where updated_at >= (
          select dateadd(day, -3, coalesce(max(updated_at), '1900-01-01'::timestamp_ntz))
          from {{ this }}
      )
    {% endif %}

)

select *
from changed_claims