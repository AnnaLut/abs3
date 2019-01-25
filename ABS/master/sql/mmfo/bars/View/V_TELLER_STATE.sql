
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_state.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_STATE ("USER_REF", "CUR_CODE", "ATM_AMOUNT", "NON_ATM_AMOUNT") AS 
  select user_ref, to_char(cur_code) cur_code, atm_amount, non_atm_amount
from (
select o.user_ref, tv.kv cur_code, sum(co.atm_amount * case co.op_type when 'IN' then 1 when 'RIN' then 1 else -1 end) atm_amount,
       sum(co.non_atm_amount * case op_type when 'IN' then 1 when 'RIN' then 1 else -1 end) non_atm_amount
  from teller_opers o,
       teller_cash_opers co,
       tabval tv
  where o.work_date = gl.bd
    and co.doc_ref in (o.doc_ref, o.id)
    and (co.cur_code = tv.kv or co.cur_code = tv.lcv)
--    and not o.state in ('RJ')
    and co.atm_status = 2
  group by o.user_ref, tv.kv)
  where (atm_amount+non_atm_amount) != 0
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_STATE ***
grant SELECT                                                                 on V_TELLER_STATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TELLER_STATE  to BARS_ACCESS_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_state.sql =========*** End ***
 PROMPT ===================================================================================== 
 