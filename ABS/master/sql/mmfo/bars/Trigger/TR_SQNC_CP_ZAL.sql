

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TR_SQNC_CP_ZAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TR_SQNC_CP_ZAL ***

  CREATE OR REPLACE TRIGGER BARS.TR_SQNC_CP_ZAL 
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
ALTER TRIGGER BARS.TR_SQNC_CP_ZAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TR_SQNC_CP_ZAL.sql =========*** End 
PROMPT ===================================================================================== 
