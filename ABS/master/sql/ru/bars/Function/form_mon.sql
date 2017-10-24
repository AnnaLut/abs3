
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/form_mon.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FORM_MON (
  nP1_ NUMBER,  --REF документа
  sP2_ CHAR,    -- КОД формулы для операции по покупке монет
  sP3_ CHAR    -- код доп.реквизита
                -- NOM - номинал
				-- BAN - цена банка
				-- NBU - цена НБУ
	)
  -- функция  находит значения в таблице по REF

 RETURN NUMBER IS
  n1_ NUMBER;
 BEGIN
  n1_:= 0;

   IF sP2_='NOM'  THEN
                   BEGIN
                     SELECT b.nom_mon
                       INTO n1_
                       FROM v_bank_mon b, operw w
                      WHERE w.ref = nP1_ and w.tag =sP3_ and SUBSTR(w.value,1,4)= SUBSTR(DR_B_MON_NZP(b.kod),1,4);
                      EXCEPTION WHEN NO_DATA_FOUND then RETURN 0;
					END;
   ELSIF sP2_='BAN' THEN
                   BEGIN
                     SELECT b.cena_banka
                       INTO n1_
                       FROM v_bank_mon b, operw w
                      WHERE w.ref = nP1_ and w.tag =sP3_ and SUBSTR(w.value,1,4)= SUBSTR(DR_B_MON_NZP(b.kod),1,4);
                      EXCEPTION WHEN NO_DATA_FOUND then RETURN 0;
                   END;
   ELSIF sP2_='NBU' THEN
                   BEGIN
                     SELECT b.cena_nbu
                       INTO n1_
                       FROM v_bank_mon b, operw w
                      WHERE w.ref = nP1_ and w.tag =sP3_ and SUBSTR(w.value,1,4)= SUBSTR(DR_B_MON_NZP(b.kod),1,4);
                      EXCEPTION WHEN NO_DATA_FOUND then RETURN 0;
                   END;
   END IF;


 RETURN n1_;

 END FORM_MON;
/
 show err;
 
PROMPT *** Create  grants  FORM_MON ***
grant EXECUTE                                                                on FORM_MON        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FORM_MON        to PYOD001;
grant EXECUTE                                                                on FORM_MON        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/form_mon.sql =========*** End *** =
 PROMPT ===================================================================================== 
 