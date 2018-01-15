create or replace view v_msp_req_for_parse as
select ID,REQ_xml,STATE, act_type, create_date
    from msp_requests mr
   where mr.state = -1
     and mr.act_type = 1;
/
   
grant select on v_msp_req_for_parse to bars_access_defrole;
