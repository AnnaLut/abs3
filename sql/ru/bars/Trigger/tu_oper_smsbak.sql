

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SMSBAK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_SMSBAK ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_SMSBAK 
after update of sos on oper
for each row
 WHEN (
new.sos<0 and old.sos>0 and new.tt ='SMS'
      ) begin
 update MSG_SUBMIT_DATA set payedref=null where payedref=:old.ref;
end tu_oper_smsbak;
/
ALTER TRIGGER BARS.TU_OPER_SMSBAK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SMSBAK.sql =========*** End 
PROMPT ===================================================================================== 
