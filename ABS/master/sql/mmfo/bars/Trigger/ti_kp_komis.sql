

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KP_KOMIS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KP_KOMIS ***

  CREATE OR REPLACE TRIGGER BARS.TI_KP_KOMIS 
BEFORE INSERT  ON KP_KOMIS
 FOR EACH ROW
BEGIN
  SELECT S_KP_KOMIS.nextval into :NEW.ID FROM dual ;
  :NEW.PR_FL := nvl(:NEW.PR_FL,0);
  :NEW.PR_UL := nvl(:NEW.PR_UL,0);
END ti_KP_komis;




/
ALTER TRIGGER BARS.TI_KP_KOMIS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KP_KOMIS.sql =========*** End ***
PROMPT ===================================================================================== 
