select
    claim_id,
    member_id,
    provider_id,
    service_date,
    upper(claim_status) as claim_status,
    billed_amount,
    allowed_amount,
    paid_amount,
    updated_at,
    ingested_at
from {{ source('s1', 't_claims') }}