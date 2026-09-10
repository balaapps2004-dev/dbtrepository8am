-- ================================================================
-- TOPIC 08 | Custom Test: no service dates in the future
-- ================================================================
select
    claim_id,
    service_date
from {{ ref('stg_claims') }}
where service_date > current_date
