

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_USER_VISA_MSG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_USER_VISA_MSG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_USER_VISA_MSG ("SWREF", "MT", "TRN", "SENDER_BIC", "SENDER_NAME", "RECEIVER_BIC", "RECEIVER_NAME", "CURRENCY", "AMOUNT", "VDATE", "REF", "NEXTVISAGRP", "EDITSTATUS") AS 
  select m.swref, m.mt, m.trn, m.sender_bic, m.sender_name,
       m.receiver_bic, m.receiver_name, m.currency, m.amount,
       m.vdate, d.ref, d.nextvisagrp, bars_swift.msgchk_geteditstatus(m.swref)  editstatus
  from v_sw_procmsg m, v_user_visa_docs d, sw_oper o
 where m.swref = o.swref
   and o.ref   = d.ref
 ;

PROMPT *** Create  grants  V_SW_USER_VISA_MSG ***
grant SELECT                                                                 on V_SW_USER_VISA_MSG to BARS013;
grant SELECT                                                                 on V_SW_USER_VISA_MSG to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_USER_VISA_MSG to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_USER_VISA_MSG.sql =========*** End
PROMPT ===================================================================================== 
