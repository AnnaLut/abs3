

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTS_DESTRUCT_PASSP.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACCOUNTS_DESTRUCT_PASSP ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOUNTS_DESTRUCT_PASSP 
   BEFORE INSERT OR UPDATE
   ON BARS.ACCOUNTS
   FOR EACH ROW
DECLARE
   l_ser   VARCHAR2 (10);
   l_num   VARCHAR2 (20);
   l_p     NUMBER;
BEGIN
   BEGIN
      SELECT ser, numdoc
        INTO l_ser, l_num
        FROM person
       WHERE rnk = :new.rnk;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         l_ser := '';
         l_num := '';
   END;

   SELECT check_destruct_passp (l_ser, l_num) INTO l_p FROM DUAL;

   IF l_p = 1
   THEN
      raise_application_error (
         -20001,
         'ѕаспорт кл≥Їнта п≥дл€гаЇ вилученню та знищенню зг≥дно листа ЌЅ” в≥д 15.04.2015 р. є47-411/25195');
   END IF;
END;
/
ALTER TRIGGER BARS.TBIU_ACCOUNTS_DESTRUCT_PASSP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTS_DESTRUCT_PASSP.sql ===
PROMPT ===================================================================================== 
