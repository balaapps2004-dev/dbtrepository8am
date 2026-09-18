-- Analysis 1: Top 5 most expensive claim types by specialty
select
    provider_specialty,
    claim_type,
    count(claim_id)         as claim_count,
    sum(paid_amount)        as total_paid,
    avg(paid_amount)        as avg_paid,
    max(paid_amount)        as max_paid
from {{ ref('fct_claims') }}
where is_paid = true
group by provider_specialty, claim_type
order by total_paid desc
limit 10;

-- Analysis 2: Denial rate by plan type and state
select
    plan_type,
    member_state,
    count(claim_id)                                             as total_claims,
    count(case when is_denied then 1 end)                      as denied_claims,
    round(count(case when is_denied then 1 end) * 100.0
          / nullif(count(claim_id), 0), 2)                     as denial_rate_pct
from {{ ref('fct_claims') }}
group by plan_type, member_state
order by denial_rate_pct desc;

-- Analysis 3: In-network vs out-of-network spend comparison
select
    is_in_network,
    count(claim_id)         as claim_count,
    sum(billed_amount)      as total_billed,
    sum(allowed_amount)     as total_allowed,
    sum(paid_amount)        as total_paid,
    avg(discount_pct)       as avg_discount_pct
from {{ ref('fct_claims') }}
group by is_in_network;
