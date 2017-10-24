

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SEC_LOGINS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SEC_LOGINS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SEC_LOGINS 
  BEFORE INSERT OR UPDATE OF SECID ON "BARS"."SEC_LOGINS"
  REFERENCING FOR EACH ROW
  BEGIN
   :new.secid:= upper(:new.secid);

END;



/
ALTER TRIGGER BARS.TBI_SEC_LOGINS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SEC_LOGINS.sql =========*** End 
PROMPT ===================================================================================== 
