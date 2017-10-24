

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_TYPES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_TYPES 
BEFORE INSERT ON BARS.DPU_TYPES
FOR EACH ROW
 WHEN ( new.TYPE_ID IS NULL OR new.TYPE_ID = 0 ) BEGIN
  select max(TYPE_ID) + 1
    into :new.TYPE_ID
    from BARS.DPU_TYPES;
END TBI_DPU_TYPES;
/
ALTER TRIGGER BARS.TBI_DPU_TYPES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
