
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TR_SQNC_CP_ZAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TR_SQNC_CP_ZAL ***

create or replace trigger TR_SQNC_CP_ZAL
  before insert ON BARS.CP_ZAL
  REFERENCING  for each row
declare
  -- local variables here
begin
  
  IF INSERTING
        THEN          
          :NEW.ID_CP_ZAL := bars_sqnc.get_nextval('S_CP_ZAL'); 
  END IF; 
  
end TR_SQNC_CP_ZAL;

/
ALTER TRIGGER BARS.TBU_ACCOUNTS_DAZS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TR_SQNC_CP_ZAL.sql =========*** E
PROMPT ===================================================================================== 