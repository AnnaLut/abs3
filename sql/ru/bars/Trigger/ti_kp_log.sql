

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KP_LOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KP_LOG ***

  CREATE OR REPLACE TRIGGER BARS.TI_KP_LOG 
AFTER INSERT  ON KP_LOG
FOR EACH ROW
BEGIN
 If Nvl(:NEW.LOG ,0) <> 0 then
    INSERT INTO KP_DEAL(ND,NAME,SUM) VALUES(-:NEW.LOG,:NEW.NAME,NULL);
 end if;
END TI_KP_LOG;
/
ALTER TRIGGER BARS.TI_KP_LOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KP_LOG.sql =========*** End *** =
PROMPT ===================================================================================== 
