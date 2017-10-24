

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CM_CREDITS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CM_CREDITS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CM_CREDITS 
   BEFORE INSERT OR UPDATE
   ON BARS.CM_CREDITS
   FOR EACH ROW
DECLARE
   l_id   INT;
   erm    VARCHAR2 (1024);
BEGIN
   INSERT INTO CM_CREDITS_UPDATE (id,
                                  nd,
                                  branch,
                                  kv,
                                  nls,
                                  dclass,
                                  dvkr,
                                  dsum,
                                  ddate,
                                  change_date)
      SELECT BARS.S_cm_credits_update.NEXTVAL,
             :NEW.nd,
             :NEW.branch,
             :NEW.kv,
             :NEW.nls,
             :NEW.dclass,
             :NEW.dvkr,
             :NEW.dsum,
             :NEW.ddate,
             sysdate
        FROM DUAL;
END TIU_CM_CREDITS;


/
ALTER TRIGGER BARS.TIU_CM_CREDITS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CM_CREDITS.sql =========*** End 
PROMPT ===================================================================================== 
