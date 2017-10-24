

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIESUM.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACCOUNTSW_LIESUM ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOUNTSW_LIESUM 
   BEFORE INSERT OR UPDATE
   ON ACCOUNTSW
   FOR EACH ROW
    WHEN (new.tag = 'LIE_SUM') DECLARE
   l_pr    NUMBER;
   l_sum   VARCHAR2 (254);
BEGIN
   SELECT DECODE (TRIM (TRANSLATE (:new.VALUE, '0123456789', ' ')),
                  NULL, 0,
                  1)
     INTO l_pr
     FROM DUAL;

   IF l_pr = 1
   THEN
      bars_error.raise_nerror ('CAC', 'ACCOUNTSW_LIESUM_ERROR');
   --  raise_application_error(-20001, 'Допустимий формат суми - в коп_йках');
   END IF;

   l_sum := REPLACE (:new.VALUE, ' ', '');
   :new.VALUE := l_sum;
END;
/
ALTER TRIGGER BARS.TBIU_ACCOUNTSW_LIESUM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIESUM.sql =========*
PROMPT ===================================================================================== 
