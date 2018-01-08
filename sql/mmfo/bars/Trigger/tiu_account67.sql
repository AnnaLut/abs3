

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNT67.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNT67 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNT67 
   BEFORE INSERT OR
          UPDATE OF kv,
                    nbs,
                    nls,
                    tip
   ON accounts
   FOR EACH ROW
 WHEN (
new.acc <> 0
      ) DECLARE
   NLS_   VARCHAR2 (15);
BEGIN
   IF :new.nls LIKE '0000%' AND :new.nbs IS NULL
   THEN
      RETURN;
   END IF;

   -- проверка на нецифровой символ в номере счета
   BEGIN
      SELECT TO_NUMBER (:new.nls) INTO nls_ FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (
            - (20000 + 111),
            'нецифровой символ в номере счета',
            TRUE);
   END;

   -- проверка на валюту счетов 6, 7 кл.
   IF :new.kv <> 980 AND SUBSTR (:new.nbs, 1, 1) IN ('6', '7')
   THEN
      raise_application_error (
         - (20000 + 222),
         'валюта в сч.6,7 кл. kv=' || :new.kv,
         TRUE);
   END IF;

   -- проверка на длину номера счета
   IF LENGTH (:new.nls) < 5
   THEN
      raise_application_error (
         - (20000 + 333),
         'длина номера счета менее 5 зн',
         TRUE);
   END IF;

   IF vkrzn (SUBSTR (F_OURMFO, 1, 5), :new.nls) <> :new.nls
   THEN
      raise_application_error (
         - (20000 + 444),
         'Ош.контр.разряда в счете',
         TRUE);
   END IF;

   -- тип счета 8999
   IF :new.nbs = '8999'
   THEN
      :new.tip := 'LIM';
   END IF;
END tiu_account67;
/
ALTER TRIGGER BARS.TIU_ACCOUNT67 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNT67.sql =========*** End *
PROMPT ===================================================================================== 
