

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ZGB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ZGB ***

  CREATE OR REPLACE TRIGGER BARS.TU_ZGB 
AFTER UPDATE OF OTM ON ZAG_B FOR EACH ROW
 -- VER @(#) TU_ZGB.SQL 3.1.1.1 99/11/24
 -- UPDATED BY SERGWEB 13-JUN-2001
DECLARE
    ern          CONSTANT POSITIVE := 746;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
 BEGIN
    IF NOT (:OLD.otm IS NULL AND :NEW.otm = 1 OR
-- A-File processing
            :OLD.otm = 0 AND :NEW.otm = 0 OR
            :OLD.otm = 0 AND :NEW.otm = 5 OR
-- B-File processing
            :OLD.otm = 0 AND :NEW.otm = 1 OR -- Payed
            :OLD.otm = 1 AND :NEW.otm = 2 OR -- Resigned
            :OLD.otm = 1 AND :NEW.otm = 3 OR -- Created
            :OLD.otm = 1 AND :NEW.otm = 1 OR -- Already RolledBack By DirectionLock
            :OLD.otm = 1 AND :NEW.otm = 5 OR -- Manual Settlement
            :OLD.otm = 2 AND :NEW.otm = 3 OR -- Created resigned
            :OLD.otm = 3 AND :NEW.otm = 5 OR -- Settlment
            :OLD.otm = 5 AND :NEW.otm = 7 OR -- Aknlgd
-- Force repeat create
            :OLD.otm = 3 AND :NEW.otm = 1 OR -- Repeat ^B
            :OLD.otm = 7 AND :NEW.otm = 5)   -- Repeat ^K
    THEN
       erm := '9915 - Zag_b.otm: '||:OLD.otm||'->'||:NEW.otm||' prohibited.';
       RAISE err;
    END IF;
EXCEPTION
   WHEN err THEN
        raise_application_error(-(20000+ern),erm,TRUE);
END tu_zgb;

/
ALTER TRIGGER BARS.TU_ZGB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ZGB.sql =========*** End *** ====
PROMPT ===================================================================================== 
