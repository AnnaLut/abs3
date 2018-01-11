

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SKRYNKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SKRYNKA ***

  CREATE OR REPLACE TRIGGER BARS.TI_SKRYNKA 
   BEFORE INSERT
   ON BARS.SKRYNKA    FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.n_sk IS NULL
   THEN
      SELECT bars_sqnc.get_nextval('S_SKRYNKA_N_SK')
        INTO :NEW.n_sk
        FROM DUAL;
   END IF;

   INSERT INTO SKRYNKA_ALL(N_SK,KF)
   VALUES (:NEW.n_sk, sys_context('bars_context','user_mfo'));

END;
/
ALTER TRIGGER BARS.TI_SKRYNKA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SKRYNKA.sql =========*** End *** 
PROMPT ===================================================================================== 
