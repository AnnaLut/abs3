

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CH_1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CH_1 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CH_1 
  BEFORE INSERT ON "BARS"."CH_1"
  REFERENCING FOR EACH ROW
  BEGIN
   select bars_sqnc.get_nextval('S_CH_1') into :new.id from dual;
   :NEW.FDAT:= gl.BDATE;
END;
/
ALTER TRIGGER BARS.TBI_CH_1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CH_1.sql =========*** End *** ==
PROMPT ===================================================================================== 
