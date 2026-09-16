-- ================================================================
-- TOPIC 07 | Snapshots (SCD Type 2)
-- Concepts: snapshot config, strategy=check, time travel on data
-- ================================================================
{% snapshot snap_member_enrollment %}

{{
    config(
        target_schema='silver',
        unique_key='member_id',
        strategy='check',
        check_cols=['plan_id', 'termination_date', 'is_active']
    )
}}

select
    member_id,
    full_name,
    plan_id,
    enrollment_date,
    termination_date,
    is_active,
    state,
    created_at

from {{ ref('stg_members') }}

{% endsnapshot %}
