

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIEDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACCOUNTSW_LIEDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOUNTSW_LIEDATE 
   BEFORE INSERT OR UPDATE
   ON ACCOUNTSW
   FOR EACH ROW
    WHEN (new.tag = 'LIE_DATE') DECLARE
   l_dat   VARCHAR2 (10);
BEGIN
   SELECT TO_CHAR (TO_DATE (REPLACE (:new.VALUE, '/', '.'), 'dd.mm.yyyy'),
                   'dd.mm.yyyy')
     INTO l_dat
     FROM DUAL;

   :new.VALUE := l_dat;
EXCEPTION
   WHEN OTHERS
   THEN
      IF SQLCODE = -01858
      THEN
         raise_application_error (-20001,
                                  'Невірний формат дати');
      ELSE
         RAISE;
      END IF;
END;
/
ALTER TRIGGER BARS.TBIU_ACCOUNTSW_LIEDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIEDATE.sql =========
PROMPT ===================================================================================== 
