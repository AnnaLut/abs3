

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_VYP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_VYP ***

  CREATE OR REPLACE TRIGGER BARS.TIU_VYP 
  AFTER INSERT ON "BARS"."VYPISKA"
  REFERENCING FOR EACH ROW
  DECLARE
   dapp_ DATE;
BEGIN
   BEGIN
      SELECT dapp INTO dapp_
        FROM accounts_its WHERE nls=:NEW.nls AND kv=:NEW.kv;
      IF dapp_ >= :NEW.fdat THEN
         UPDATE accounts_its
            SET dapp=:NEW.fdat,ostc=:NEW.ost,dos=:NEW.dos,kos=:NEW.kos
          WHERE nls=:NEW.nls AND kv=:NEW.kv;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         INSERT INTO accounts_its (nls,kv,nbs,dapp,ostc,dos,kos)
              VALUES (:NEW.nls,:NEW.kv,SUBSTR(:NEW.nls,1,4),
                      :NEW.fdat,:NEW.ost,:NEW.dos,:NEW.kos);
   END;
END;



/
ALTER TRIGGER BARS.TIU_VYP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_VYP.sql =========*** End *** ===
PROMPT ===================================================================================== 
