-- ================================================================
-- TOPIC 08 | Custom Data Tests
-- File    : tests/test_claims_amounts.sql
-- Concepts: custom singular test, business rule validation
--           A test PASSES when it returns 0 rows
-- Business Rule: paid_amount should never exceed allowed_amount
-- ================================================================
select
    claim_id,
    paid_amount,
    allowed_amount,
    paid_amount - allowed_amount as overpayment_amount
from {{ ref('stg_claims') }}
where paid_amount > allowed_amount
  and claim_status = 'PAID'
