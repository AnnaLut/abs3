

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_DPUTYPES_FLACTIVE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_DPUTYPES_FLACTIVE ***

  CREATE OR REPLACE TRIGGER BARS.TAU_DPUTYPES_FLACTIVE 
   AFTER UPDATE OF FL_ACTIVE
   ON BARS.DPU_TYPES
   FOR EACH ROW
    WHEN (new.TYPE_ID > 0 AND new.FL_ACTIVE < old.FL_ACTIVE) BEGIN
   PUL.PUT ('DPU_TYPE_ACTIVE', TO_CHAR (:new.FL_ACTIVE));

   UPDATE DPU_VIDD
      SET FLAG = :new.FL_ACTIVE
    WHERE TYPE_ID = :new.TYPE_ID;

   PUL.PUT ('DPU_TYPE_ACTIVE', NULL);
END TAU_DPUTYPES_FLACTIVE;
/
ALTER TRIGGER BARS.TAU_DPUTYPES_FLACTIVE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_DPUTYPES_FLACTIVE.sql =========*
PROMPT ===================================================================================== 
