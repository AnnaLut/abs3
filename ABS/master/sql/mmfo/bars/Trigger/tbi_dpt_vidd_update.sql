

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_VIDD_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_VIDD_UPDATE 
BEFORE INSERT ON bars.dpt_vidd_update FOR EACH ROW
BEGIN
  SELECT s_dpt_vidd_update.NEXTVAL INTO :NEW.IDU FROM DUAL;
END;




/
ALTER TRIGGER BARS.TBI_DPT_VIDD_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_UPDATE.sql =========***
PROMPT ===================================================================================== 
