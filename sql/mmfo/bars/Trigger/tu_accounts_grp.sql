

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_GRP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACCOUNTS_GRP ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNTS_GRP 
   BEFORE UPDATE OF GRP
   ON accounts
   FOR EACH ROW
BEGIN
   IF :NEW.grp < 16
   THEN
      :NEW.sec :=
         UTL_RAW.BIT_OR (
            NVL (:OLD.sec, '0000'),
            UTL_RAW.SUBSTR (
               UTL_RAW.CAST_FROM_BINARY_INTEGER (
                  POWER (2, 16 - MOD (:NEW.grp, 16) - 1)),
               3,
               2));
   ELSIF :NEW.grp >= 16 AND :NEW.grp < 512
   THEN
      :NEW.sec :=
         UTL_RAW.BIT_OR (
            NVL (:OLD.sec, '0000'),
            UTL_RAW.OVERLAY (
               UTL_RAW.CAST_FROM_BINARY_INTEGER (
                  POWER (2, 16 - MOD (:NEW.grp, 16) - 1)),
               '0000',
               2 * TRUNC (:NEW.grp / 16) - 1));
   END IF;
END TU_ACCOUNTS_GRP;



/
ALTER TRIGGER BARS.TU_ACCOUNTS_GRP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_GRP.sql =========*** End
PROMPT ===================================================================================== 
