
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_incomplete_opers.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_INCOMPLETE_OPERS ("ATM_ID", "ATM_TIME", "ATM_OP_TYPE", "ATM_CUR", "ATM_AMN", "ATM_USER", "TEL_OP_TYPE", "TEL_AMN", "TEL_CUR", "TEL_USER", "TEL_TIME", "TEL_ID") AS 
  select t.rowid as atm_id, t.oper_time atm_time, t.oper_type atm_op_type, t.cur_code atm_cur, t.amount atm_amn, t.user_ref atm_user,
       co.op_type tel_op_type, co.oper_amount tel_amn, co.cur_code tel_cur, co.last_user tel_user, co.last_dt tel_time, co.doc_ref tel_id
--null tel_op_type, null tel_amn, null tel_cur, null tel_user, null tel_time, null as tel_id
from TELLER_ATM_OPERS t,  teller_opers o, teller_cash_opers co
  where t.oper_ref is null
    and t.eq_ip = teller_utils.get_device_url
    and o.work_date = gl.bD
    and o.user_ref = user_id
    and o.id = co.doc_ref
    and co.atm_status = -1
/*where oper_ref is null
union all
select null, null,null,null,null,null, co.op_type, co.oper_amount, co.cur_code, co.last_user, co.last_dt, co.doc_ref
  from teller_opers o, teller_cash_opers co
  where o.work_date = gl.bD
    and o.id = co.doc_ref
    and co.atm_status = -1);
*/
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_incomplete_opers.sql =========
 PROMPT ===================================================================================== 
 