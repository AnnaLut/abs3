

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_GRP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STO_GRP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STO_GRP 
BEFORE INSERT ON BARS.STO_GRP FOR EACH ROW
 WHEN (
NEW.idg IS NULL
      ) BEGIN
 SELECT s_sto_idg.NEXTVAL INTO :NEW.idg FROM dual;
END;
/
ALTER TRIGGER BARS.TBI_STO_GRP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_GRP.sql =========*** End ***
PROMPT ===================================================================================== 
