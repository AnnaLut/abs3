
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nazn_mon.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NAZN_MON (
  nP1_ NUMBER)    -- REF

 --- Назначение платежа для операций по покупке монет.
 RETURN VARCHAR2 IS
  NAZN_ VARCHAR2(160);
  TAG_  CHAR (5);    -- TAG доп.реквизита
  S_    NUMBER;

 BEGIN
   NAZN_ := '';
   TAG_  := '';
   S_    := 0;

  BEGIN
   SELECT trim(tag)
     INTO TAG_
     FROM OPERW
	WHERE REF= nP1_ AND tag like 'B_M%' ;
   EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
   END;

  BEGIN
   SELECT s
     INTO S_
     FROM OPER
	WHERE REF= nP1_;
   EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
   END;

   IF TAG_ = 'B_MZP' THEN
      BEGIN
        SELECT 'Оплата за придбання '|| Count_MON(nP1_,S_) ||' монет ' ||b.name_||' , номінал '||To_Char(FORM_MON( nP1_,'NOM',TAG_)/100)||' грн.'
	      INTO NAZN_
          FROM operw w, bank_mon b
         WHERE w.ref=nP1_
	       AND w.tag=TAG_
           AND SUBSTR(DR_B_MON_NZP( kod ),1,4) = SUBSTR(w.value,1,4);
	     EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
      END;
   ELSIF TAG_ = 'B_MNZ' THEN
      BEGIN
        SELECT 'Оплата за придбання '|| Count_MON(nP1_,S_) ||' монет ' ||b.name_
	      INTO NAZN_
          FROM operw w, bank_mon b
         WHERE w.ref=nP1_
	       AND w.tag=TAG_
           AND SUBSTR(DR_B_MON_NZP( kod ),1,4) = SUBSTR(w.value,1,4);
	     EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
      END;
   ELSIF TAG_ = 'B_MFK' THEN
      BEGIN
        SELECT 'Оплата за придбання '|| Count_MON(nP1_,S_) ||' футляров/капсул для ювілейних монет'
	      INTO NAZN_
          FROM dual;
	     EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
      END;
   END IF;

  RETURN NAZN_;

 END NAZN_MON;
/
 show err;
 
PROMPT *** Create  grants  NAZN_MON ***
grant EXECUTE                                                                on NAZN_MON        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAZN_MON        to PYOD001;
grant EXECUTE                                                                on NAZN_MON        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nazn_mon.sql =========*** End *** =
 PROMPT ===================================================================================== 
 