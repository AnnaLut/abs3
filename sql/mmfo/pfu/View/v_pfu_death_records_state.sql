create or replace view v_pfu_death_records_state as
select "ID","NAME"
    from pfu_death_records_state;
/

grant select on v_pfu_death_records_state to bars_access_defrole;