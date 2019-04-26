create or replace view pfu.v_pfu_payment_for_sign as
select o.ref
  from bars.oper o,
       bars.oper_visa ov
 where o.tt in ('PKX ', '024', '024')
   and o.pdat > sysdate - 5
   and o.sos not in (5, -1, -2)
   and o.nextvisagrp is null
   and o.ref = ov.ref
   and ov.groupid =  to_number(bars.getglobaloption('FM_GRP2'));
/   
 
  grant select on pfu.v_pfu_payment_for_sign to bars_access_defrole;
   
   
   
  
