{% snapshot snap_ticket_status_track %}
    {{
        config(
            target_schema='bronze',
            target_database='dev_db',
            unique_key='ticket_id',
            strategy='check',
            check_cols=['status']
        )
    }}

    select * from {{ ref('tickets_status_check') }}
 {% endsnapshot %}