{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key='claim_id'
    )
}}

with changed_claims as (
    select distinct claim_id
    from {{ ref('stg_claim_diagnosis') }}

    {% if is_incremental() %}
      where updated_at >= (
          select dateadd(day, -3, coalesce(max(updated_at), '1900-01-01'::timestamp_ntz))
          from {{ this }}
      )
    {% endif %}
),

latest_diagnosis_set as (
    select
        d.claim_id,
        d.diagnosis_code,
        d.diagnosis_sequence,
        d.updated_at,
        d.ingested_at
    from {{ ref('stg_claim_diagnosis') }} d
    inner join changed_claims c
        on d.claim_id = c.claim_id
)

select *
from latest_diagnosis_set
