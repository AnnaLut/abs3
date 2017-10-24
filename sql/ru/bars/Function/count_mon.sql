
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/count_mon.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.COUNT_MON (
  sP1_ NUMBER,  -- REF документа
  sP2_ NUMBER   -- S сумма документа
   )
   -- Функция вычисляет количество монет
 RETURN NUMBER IS
  n1_ int;
 BEGIN
  n1_:= 1;

  BEGIN
   SELECT sP2_/b.cena_banka
     INTO n1_
     FROM v_bank_mon b, operw w
    WHERE w.ref = sP1_ and w.tag IN ('B_MNZ','B_MZP','B_MFK') and SUBSTR(w.value,1,4)= SUBSTR(DR_B_MON_NZP(b.kod),1,4);
    EXCEPTION WHEN NO_DATA_FOUND then RETURN 0;
  END;

 RETURN n1_;

 END Count_MON;
/
 show err;
 
PROMPT *** Create  grants  COUNT_MON ***
grant EXECUTE                                                                on COUNT_MON       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on COUNT_MON       to PYOD001;
grant EXECUTE                                                                on COUNT_MON       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/count_mon.sql =========*** End *** 
 PROMPT ===================================================================================== 
 