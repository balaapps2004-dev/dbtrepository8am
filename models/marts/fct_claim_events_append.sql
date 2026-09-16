{{
    config(
        materialized='incremental',
        incremental_strategy='append'
    )
}}

select
    event_id,
    claim_id,
    member_id,
    event_type,
    event_time,
    ingested_at
from {{ ref('stg_claim_events') }}

{% if is_incremental() %}
  -- Append does not deduplicate for you. The filter defines what is new.
  where ingested_at > (
      select coalesce(max(ingested_at), '1900-01-01'::timestamp_ntz)
      from {{ this }}
  )
{% endif %}