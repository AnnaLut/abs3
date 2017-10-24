

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_LST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STO_LST ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STO_LST 
BEFORE INSERT ON BARS.STO_LST FOR EACH ROW
 WHEN (
NEW.ids IS NULL
      ) BEGIN
 SELECT bars_sqnc.get_nextval('S_STO_IDS') INTO :NEW.ids FROM dual;
END;
/
ALTER TRIGGER BARS.TBI_STO_LST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_LST.sql =========*** End ***
PROMPT ===================================================================================== 
