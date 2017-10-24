

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_VIDD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_VIDD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_VIDD 
   BEFORE INSERT
   ON BARS.DPU_VIDD
   FOR EACH ROW
      WHEN (new.vidd IS NULL OR new.vidd = 0) BEGIN
   SELECT s_dpu_vidd.NEXTVAL INTO :new.vidd FROM DUAL;
END;


/
ALTER TRIGGER BARS.TBI_DPU_VIDD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_VIDD.sql =========*** End **
PROMPT ===================================================================================== 
