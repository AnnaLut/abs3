

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_KP_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_KP_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TD_KP_DEAL 
BEFORE DELETE
ON KP_DEAL
FOR EACH ROW
BEGIN
   DELETE FROM KP_KOMIS WHERE ND=:OLD.ND;
   DELETE FROM KP_TOBO WHERE ND=:OLD.ND;
   DELETE FROM KP_LOG_ND WHERE ND=:OLD.ND;
   IF :OLD.ND < 0 THEN
   	  DELETE FROM KP_LOG WHERE LOG=-:OLD.ND;
   END IF;
END ;
/
ALTER TRIGGER BARS.TD_KP_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_KP_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
