-- ================================================================
-- TOPIC 08 | Custom Test: inpatient claims must have admission date
-- ================================================================
select
    claim_id,
    claim_type,
    admission_date
from {{ ref('stg_claims') }}
where is_inpatient = true
  and admission_date is null
