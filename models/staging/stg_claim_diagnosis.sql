select
    claim_id,
    diagnosis_code,
    diagnosis_sequence,
    updated_at,
    ingested_at
from {{ source('s1', 't_claim_diagnosis') }}