

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_LCS_APPROVE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_LCS_APPROVE ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_LCS_APPROVE 
after update of sos on oper
for each row
 WHEN (old.sos!=5 and new.sos=5) declare
l_cnt number :=0;
begin

 select count(*) into l_cnt from ttsap where ttap='ZZZ' and tt= :new.tt;

 if l_cnt>0 then
   LCS_PACK_SERVICE.APPROVE(:new.ref, sys_context('bars_context','user_mfo'), 'BRS_EXCH');
 end if;

end tau_oper_lcs_approve;
/
ALTER TRIGGER BARS.TAU_OPER_LCS_APPROVE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_LCS_APPROVE.sql =========**
PROMPT ===================================================================================== 
