

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_AGREEMENTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_AGREEMENTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_AGREEMENTS 
BEFORE INSERT ON BARS.DPU_AGREEMENTS
FOR EACH ROW
 WHEN ( NEW.AGRMNT_ID IS NULL OR NEW.AGRMNT_ID = 0 ) BEGIN
  SELECT S_DPU_AGREEMENTS.NEXTVAL
    INTO :NEW.AGRMNT_ID
    FROM DUAL;
END TBI_DPU_AGREEMENTS;
/
ALTER TRIGGER BARS.TBI_DPU_AGREEMENTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_AGREEMENTS.sql =========*** 
PROMPT ===================================================================================== 
