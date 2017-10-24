

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_TMP_NBU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_TMP_NBU ***

  CREATE OR REPLACE TRIGGER BARS.TBI_TMP_NBU 
   BEFORE UPDATE
   ON TMP_NBU
   FOR EACH ROW
BEGIN
   INSERT INTO TMP_NBU_HIST (KODP,
                             DATF,
                             DATCH,
                             KODF,
                             ZNAP,
                             KF,
                             MDF,
                             ws_us)
        VALUES ('OLD: ' || :old.KODP || ' NEW: ' || :new.KODP,
                :old.DATF,
                 SYSDATE,
                :old.KODF,
                'OLD: ' || :old.ZNAP || ' NEW: ' || :new.ZNAP,
                :old.KF,
                SYS_CONTEXT ('USERENV', 'OS_USER'),
                USERENV ('TERMINAL'));
END TBI_TMP_NBU;


/
ALTER TRIGGER BARS.TBI_TMP_NBU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_TMP_NBU.sql =========*** End ***
PROMPT ===================================================================================== 
