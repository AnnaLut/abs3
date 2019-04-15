create or replace view bars.v_subsidy_ebk_packages as
select tu."ID",tu."UNIT_TYPE_ID",tu."EXTERNAL_FILE_ID",tu."RECEIVER_URL",tu."REQUEST_DATA",tu."RESPONSE_DATA",tu."STATE_ID",tu."FAILURES_COUNT",tu."KF",tt.sys_time
  from barstrans.transport_unit tu,
       barstrans.transport_tracking tt
 where tu.unit_type_id = 7
   and tt.state_id = 1
   and tu.id = tt.unit_id;
   
grant select on bars.v_subsidy_ebk_packages to bars_access_defrole;
