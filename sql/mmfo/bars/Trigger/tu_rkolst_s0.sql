

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_RKOLST_S0.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_RKOLST_S0 ***

  CREATE OR REPLACE TRIGGER BARS.TU_RKOLST_S0 BEFORE update of S0 on RKO_LST
FOR EACH ROW
BEGIN
  IF nvl(:NEW.S0,0)=0 THEN
     :NEW.KOLDOK:=0;
     :NEW.SUMDOK:=0;
  END IF;
END;




/
ALTER TRIGGER BARS.TU_RKOLST_S0 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_RKOLST_S0.sql =========*** End **
PROMPT ===================================================================================== 
