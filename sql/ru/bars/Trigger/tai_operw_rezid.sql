

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_REZID.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_REZID ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_REZID 
   AFTER INSERT OR UPDATE
   ON BARS.OPERW
   FOR EACH ROW
 WHEN (
new.tag = 'REZID' or new.tag = 'POKPO'
      ) DECLARE
   l_nlsa    accounts.nls%TYPE;
   l_kv      accounts.kv%TYPE;
   l_rnk     customer.rnk%TYPE;
   l_okpo    customer.okpo%TYPE;
   l_rezid   codcagent.rezid%TYPE;
   l_dop_okpo operw.value%type;

BEGIN
   -- 22/07/2015 Pavlenko http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3648
   -- Триггер проверки допреквизита операции "резидентность" (1,2) к реальной резидентности клиента по счету
   --18/10.2016 NVV http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4879
   -- немножко волшебства для виплаты не владельцу депозита
   case :new.tag
         when 'POKPO' then

               insert into TMP_OPERW (tag, "VALUE", browser)
               values (:new.tag, :new.value, gl.aRef);

         when 'REZID' then



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
           select value
             into l_dop_okpo
             from TMP_OPERW
            where tag = 'POKPO'
              and browser = gl.aRef ;
           EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
          END;


           BEGIN
              SELECT ca.rezid, c.okpo
                INTO l_rezid, l_okpo
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

           IF (:new.VALUE != l_rezid AND l_rezid IS NOT NULL and (l_okpo = l_dop_okpo or l_dop_okpo is null ))
           THEN
              bars_error.raise_nerror ('DOC',
                                       'CHECK_REZID_DOC_FAILED',
                                       '''' || TO_CHAR (:new.REF) || '''',
                                       '''' || TO_CHAR (:new.VALUE) || '''',
                                       '''' || TO_CHAR (l_rnk) || '''',
                                       '''' || TO_CHAR (l_rezid) || '''');
           END IF;
     end case;

END tai_operw_rezid;
/
ALTER TRIGGER BARS.TAI_OPERW_REZID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_REZID.sql =========*** End
PROMPT ===================================================================================== 
