create or replace view bars.v_subsidy_data as
select sd."EXTREQID",sd."RECEIVERACCNUM",sd."RECEIVERNAME",sd."RECEIVERIDENTCODE",sd."RECEIVERBANKCODE",sd."AMOUNT",sd."PURPOSE",sd."SIGNATURE",sd."EXTROWID",sd."REF",sd."ERR",sd."FEERATE",sd."RECEIVERRNK",sd."PAYERACCNUM",sd."PAYERBANKCODE",sd."PAYTYPE", tt.sys_time
  from subsidy_data sd,
       barstrans.transport_unit tu,
       barstrans.transport_tracking tt
 where tu.unit_type_id = 7
   and tt.state_id = 6
   and tu.id = tt.unit_id
   and tu.external_file_id = sd.extreqid;
   
grant select on bars.v_subsidy_data to bars_access_defrole;
