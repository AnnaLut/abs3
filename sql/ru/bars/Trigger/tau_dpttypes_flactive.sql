

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_DPTTYPES_FLACTIVE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_DPTTYPES_FLACTIVE ***

  CREATE OR REPLACE TRIGGER BARS.TAU_DPTTYPES_FLACTIVE 
AFTER UPDATE OF FL_ACTIVE ON BARS.DPT_TYPES
FOR EACH ROW
 WHEN (new.TYPE_ID > 0 AND new.FL_ACTIVE < old.FL_ACTIVE) BEGIN

  PUL.PUT( 'DPT_TYPE_ACTIVE', to_char(:new.FL_ACTIVE) );

  UPDATE DPT_VIDD
     SET FLAG = :new.FL_ACTIVE
   WHERE TYPE_ID = :new.TYPE_ID;

  PUL.PUT( 'DPT_TYPE_ACTIVE', null );

END TAU_DPTTYPES_FLACTIVE;
/
ALTER TRIGGER BARS.TAU_DPTTYPES_FLACTIVE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_DPTTYPES_FLACTIVE.sql =========*
PROMPT ===================================================================================== 
