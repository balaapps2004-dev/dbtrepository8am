select
    event_id,
    claim_id,
    member_id,
    event_type,
    event_time,
    ingested_at
from {{ source('s1', 't_claim_events') }}
