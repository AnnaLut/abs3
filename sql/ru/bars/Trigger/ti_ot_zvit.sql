

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_OT_ZVIT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OT_ZVIT ***

  CREATE OR REPLACE TRIGGER BARS.TI_OT_ZVIT 
BEFORE INSERT ON bars.ot_zvit FOR EACH ROW
BEGIN
   IF nvl(:new.id_rec, 0) = 0 THEN
      SELECT s_ot_zvit.nextval INTO :new.id_rec FROM dual;
   END IF;
END;
/
ALTER TRIGGER BARS.TI_OT_ZVIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_OT_ZVIT.sql =========*** End *** 
PROMPT ===================================================================================== 
