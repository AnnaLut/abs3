create or replace view pfu.v_pfu_payment_for_sign as
select o.ref
  from bars.oper o
       --bars.oper_visa ov
 where o.tt in ('PKX ', '024', 'PFR')
   and o.pdat between sysdate-1 and sysdate - 1/24
   and o.sos =1
   and o.nextvisagrp is null;
   --and o.ref = ov.ref
   --and ov.groupid =  to_number(bars.getglobaloption('FM_GRP2'));
/   
 
grant select on pfu.v_pfu_payment_for_sign to bars_access_defrole;

   
  
