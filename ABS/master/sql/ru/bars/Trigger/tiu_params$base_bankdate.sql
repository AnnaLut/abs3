

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$BASE_BANKDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_PARAMS$BASE_BANKDATE ***

  CREATE OR REPLACE TRIGGER BARS.TIU_PARAMS$BASE_BANKDATE 
before insert or update of val on params$base
for each row
 WHEN (new.par = 'BANKDATE' or new.par = 'RRPDAY') begin
    bars_context.reload_context;
end tiu_params$base_bankdate;
/
ALTER TRIGGER BARS.TIU_PARAMS$BASE_BANKDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$BASE_BANKDATE.sql =======
PROMPT ===================================================================================== 
