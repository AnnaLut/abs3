

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_AGREEMENT_TYPES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_AGREEMENT_TYPES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_AGREEMENT_TYPES 
BEFORE INSERT ON BARS.DPU_AGREEMENT_TYPES
FOR EACH ROW
 WHEN ( new.id IS NULL OR new.id = 0 ) BEGIN
  SELECT S_DPU_AGREEMENT_TYPES.NEXTVAL
    INTO :new.id
    FROM DUAL;
END TBI_DPU_AGREEMENT_TYPES;
/
ALTER TRIGGER BARS.TBI_DPU_AGREEMENT_TYPES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_AGREEMENT_TYPES.sql ========
PROMPT ===================================================================================== 
