

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_KP_LOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_KP_LOG ***

  CREATE OR REPLACE TRIGGER BARS.TU_KP_LOG 
BEFORE UPDATE  ON KP_LOG
FOR EACH ROW
BEGIN
   UPDATE KP_DEAL SET NAME=:NEW.NAME,ND=-:NEW.LOG WHERE ND=-:OLD.LOG;
END TU_KP_LOG;




/
ALTER TRIGGER BARS.TU_KP_LOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_KP_LOG.sql =========*** End *** =
PROMPT ===================================================================================== 
