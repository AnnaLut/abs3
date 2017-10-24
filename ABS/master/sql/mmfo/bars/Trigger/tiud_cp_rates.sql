

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CP_RATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CP_RATES ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CP_RATES 
   AFTER INSERT OR UPDATE OR DELETE
   ON BARS.CP_RATES
   FOR EACH ROW
DECLARE
   L_BANKDATE   DATE := GL.BDATE;
   L_USERID     NUMBER (38) := GL.AUID;
   L_ACTIONID   NUMBER (1);
   L_IDUPD      NUMBER (38);
BEGIN
   IF DELETING
   THEN
      L_ACTIONID := -1;                                            -- удаление

      SELECT S_CP_RATES_UPDATE.NEXTVAL INTO L_IDUPD FROM DUAL;

      INSERT INTO CP_RATES_UPDATE (ID,
                                   VDATE,
                                   BSUM,
                                   RATE_O,
                                   RATE_B,
                                   RATE_S,
                                   IDB,
                                   DY,
                                   KOEFF,
                                   PRO,
                                   ACTION,
                                   IDUPD,
                                   WHEN,
                                   USERID,
                                   PRI)
           VALUES (:OLD.ID,
                   :OLD.VDATE,
                   :OLD.BSUM,
                   :OLD.RATE_O,
                   :OLD.RATE_B,
                   :OLD.RATE_S,
                   :OLD.IDB,
                   :OLD.DY,
                   :OLD.KOEFF,
                   :OLD.PRO,
                   L_ACTIONID,
                   L_IDUPD,
                   SYSDATE,
                   L_USERID,
                   :OLD.PRI);
   ELSIF INSERTING
   THEN
      L_ACTIONID := 0;                                             -- открытие

      SELECT S_CP_RATES_UPDATE.NEXTVAL INTO L_IDUPD FROM DUAL;

      INSERT INTO CP_RATES_UPDATE (ID,
                                   VDATE,
                                   BSUM,
                                   RATE_O,
                                   RATE_B,
                                   RATE_S,
                                   IDB,
                                   DY,
                                   KOEFF,
                                   PRO,
                                   ACTION,
                                   IDUPD,
                                   WHEN,
                                   USERID,
                                   PRI)
           VALUES (:new.ID,
                   :new.VDATE,
                   :new.BSUM,
                   :new.RATE_O,
                   :new.RATE_B,
                   :new.RATE_S,
                   :new.IDB,
                   :new.DY,
                   :new.KOEFF,
                   :new.PRO,
                   L_ACTIONID,
                   L_IDUPD,
                   SYSDATE,
                   L_USERID,
                   :new.PRI);
   ELSE
      L_ACTIONID := 1;                                            -- изменение

      -- проверим, действительно ли что-то менялось
      IF    :OLD.ID     != :NEW.ID
         OR :OLD.VDATE  != :NEW.VDATE
         OR :OLD.BSUM   != :NEW.BSUM
         OR :OLD.RATE_O != :NEW.RATE_O
         OR :OLD.RATE_B != :NEW.RATE_B
         OR :OLD.RATE_S != :NEW.RATE_S
         OR :OLD.IDB    != :NEW.IDB
         OR :OLD.DY     != :NEW.DY
         OR :OLD.KOEFF  != :NEW.KOEFF
         OR :OLD.PRO    != :NEW.PRO
         OR :OLD.PRI    != :NEW.PRI
      THEN
         SELECT S_CP_RATES_UPDATE.NEXTVAL INTO L_IDUPD FROM DUAL;

         INSERT INTO CP_RATES_UPDATE (ID,
                                   VDATE,
                                   BSUM,
                                   RATE_O,
                                   RATE_B,
                                   RATE_S,
                                   IDB,
                                   DY,
                                   KOEFF,
                                   PRO,
                                   ACTION,
                                   IDUPD,
                                   WHEN,
                                   USERID,
                                   PRI)
           VALUES (:new.ID,
                   :new.VDATE,
                   :new.BSUM,
                   :new.RATE_O,
                   :new.RATE_B,
                   :new.RATE_S,
                   :new.IDB,
                   :new.DY,
                   :new.KOEFF,
                   :new.PRO,
                   L_ACTIONID,
                   L_IDUPD,
                   SYSDATE,
                   L_USERID,
                   :new.PRI);
      ELSE
         RETURN;                                -- ничего не менялось, выходим
      END IF;
   END IF;
END;


/
ALTER TRIGGER BARS.TIUD_CP_RATES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CP_RATES.sql =========*** End *
PROMPT ===================================================================================== 
