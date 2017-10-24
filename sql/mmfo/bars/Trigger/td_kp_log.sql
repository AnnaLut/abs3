

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_KP_LOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_KP_LOG ***

  CREATE OR REPLACE TRIGGER BARS.TD_KP_LOG 
BEFORE DELETE
ON KP_LOG
FOR EACH ROW
BEGIN
   DELETE FROM KP_LOG_ND WHERE LOG=:OLD.LOG;
END;




/
ALTER TRIGGER BARS.TD_KP_LOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_KP_LOG.sql =========*** End *** =
PROMPT ===================================================================================== 
