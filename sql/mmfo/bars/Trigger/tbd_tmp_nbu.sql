

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_TMP_NBU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_TMP_NBU ***

  CREATE OR REPLACE TRIGGER BARS.TBD_TMP_NBU 
   BEFORE DELETE
   ON TMP_NBU
   FOR EACH ROW
BEGIN
   if not (lower(SYS_CONTEXT ('USERENV', 'OS_USER')) in ('oracle') or 
           upper(USERENV ('TERMINAL')) in ('UNKNOWN'))
   then
       INSERT INTO TMP_NBU_HIST (KODP,
                                 DATF,
                                 DATCH,
                                 KODF,
                                 ZNAP,
                                 KF,
                                 MDF,
                                 ws_us)
        VALUES ('DELETE KODP: ' || :old.KODP ,
                :old.DATF,
                 SYSDATE,
                :old.KODF,
                'ZNAP: ' || :old.ZNAP ,
                :old.KF,
                SYS_CONTEXT ('USERENV', 'OS_USER'),
                USERENV ('TERMINAL'));
   end if;
END;
/
ALTER TRIGGER BARS.TBD_TMP_NBU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_TMP_NBU.sql =========*** End ***
PROMPT ===================================================================================== 
