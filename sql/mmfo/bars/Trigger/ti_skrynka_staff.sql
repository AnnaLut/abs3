

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SKRYNKA_STAFF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SKRYNKA_STAFF ***

  CREATE OR REPLACE TRIGGER BARS.TI_SKRYNKA_STAFF BEFORE INSERT  ON BARS.SKRYNKA_STAFF    FOR EACH ROW
DECLARE
BEGIN

      SELECT s_skrynka_staff.NEXTVAL
        INTO :NEW.id
        FROM DUAL;
  
END;
/
ALTER TRIGGER BARS.TI_SKRYNKA_STAFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SKRYNKA_STAFF.sql =========*** En
PROMPT ===================================================================================== 
