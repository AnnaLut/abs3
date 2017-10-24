

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_TYPES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_TYPES 
   BEFORE INSERT
   ON BARS.DPU_TYPES
   FOR EACH ROW
DECLARE
   l_typeid   DPU_TYPES.TYPE_ID%TYPE;
BEGIN
   IF :new.TYPE_ID IS NULL OR :new.TYPE_ID = 0
   THEN
      SELECT MAX (TYPE_ID) INTO l_typeid FROM DPU_TYPES;

      :new.TYPE_ID := l_TYPEID;
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_DPU_TYPES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
