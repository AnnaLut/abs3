

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOUNTSW_W4ARSUM.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_ACCOUNTSW_W4ARSUM ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_ACCOUNTSW_W4ARSUM 
   AFTER INSERT OR UPDATE OR DELETE
   ON accountsw
   FOR EACH ROW
DECLARE
   PROCEDURE add (p_acc NUMBER, p_value VARCHAR2)
   IS
      l_s   NUMBER;
   BEGIN
      l_s := TO_NUMBER (NVL (p_value, 0)) * 100;

      INSERT INTO ow_acc_que (acc, s, sos)
           VALUES (p_acc, l_s, 0);
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         UPDATE ow_acc_que
            SET s = l_s, dat = SYSDATE
          WHERE acc = p_acc AND sos = 0;
      WHEN OTHERS
      THEN
         IF SQLCODE = -06502
         THEN
            raise_application_error (
               -20000,
               'Невірне значення параметру <Арештована сума>');
         ELSE
            RAISE;
         END IF;
   END;
BEGIN
   IF DELETING
   THEN
      IF :old.tag = 'W4_ARSUM'
      THEN
         add (:old.acc, NULL);
      END IF;
   ELSIF INSERTING
   THEN
      IF :new.tag = 'W4_ARSUM'
      THEN
         add (:new.acc, :new.VALUE);
      END IF;
   ELSE
      IF :new.tag = 'W4_ARSUM' AND :new.VALUE <> :old.VALUE
      THEN
         add (:new.acc, :new.VALUE);
      END IF;
   END IF;
END;
/
ALTER TRIGGER BARS.TAIUD_ACCOUNTSW_W4ARSUM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOUNTSW_W4ARSUM.sql ========
PROMPT ===================================================================================== 
