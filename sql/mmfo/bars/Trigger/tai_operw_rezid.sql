

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_REZID.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_REZID ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_REZID 
   AFTER INSERT OR UPDATE
   ON BARS.OPERW
   FOR EACH ROW
         WHEN (new.tag = 'REZID') DECLARE
   l_nlsa    accounts.nls%TYPE;
   l_kv      accounts.kv%TYPE;
   l_rnk     customer.rnk%TYPE;
   l_rezid   codcagent.rezid%TYPE;
BEGIN
   -- 22/07/2015 Pavlenko http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3648
   -- Триггер проверки допреквизита операции "резидентность" (1,2) к реальной резидентности клиента по счету
   --
   BEGIN
      SELECT nlsa, kv
        INTO l_nlsa, l_kv
        FROM oper
       WHERE REF = :new.REF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   BEGIN
      SELECT ca.rezid
        INTO l_rezid
        FROM accounts a, customer c, codcagent ca
       WHERE     c.rnk = a.rnk
             AND a.nls = l_nlsa
             AND a.kv = l_kv
             AND ca.codcagent = c.codcagent
             AND c.custtype = 3;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   IF (:new.VALUE != l_rezid AND l_rezid IS NOT NULL)
   THEN
      bars_error.raise_nerror ('DOC',
                               'CHECK_REZID_DOC_FAILED',
                               '''' || TO_CHAR (:new.REF) || '''',
                               '''' || TO_CHAR (:new.VALUE) || '''',
                               '''' || TO_CHAR (l_rnk) || '''',
                               '''' || TO_CHAR (l_rezid) || '''');
   END IF;
END tai_operw_rezid;


/
ALTER TRIGGER BARS.TAI_OPERW_REZID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_REZID.sql =========*** End
PROMPT ===================================================================================== 
