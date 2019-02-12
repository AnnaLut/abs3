

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_LCS_BACK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_LCS_BACK ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_LCS_BACK 
after update of sos ON BARS.OPER
for each row
    WHEN (
new.sos<0 and old.sos>=0
      ) declare
l_cnt number :=0;
begin

 select count(*) into l_cnt from ttsap where ttap='ZZZ' and tt= :new.tt;

 if l_cnt>0 then
   LCS_PACK_SERVICE.BACK(:new.ref, sys_context('bars_context','user_mfo'), 'BRS_EXCH');
 end if;


end tau_oper_lcs_back;


/
ALTER TRIGGER BARS.TAU_OPER_LCS_BACK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_LCS_BACK.sql =========*** E
PROMPT ===================================================================================== 
