
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kurs_sl.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KURS_SL (
  nP1_ NUMBER,  --REF
  nP2_ VARCHAR2  --TAG
  )
 RETURN NUMBER IS
  kurs_p_  bank_slitky.kurs_p%type; 
  kurs_k_  bank_slitky.kurs_k%type;
  err      EXCEPTION;
  erm      VARCHAR2(80);
---  Функция для проверки правильности проведения операции BMP.
---  В сумму операции  BMK водиться количество слитков(монет) 
---   в доп. реквизит B_SLC вводится номинал слитка (монеты), 
---   в доп. реквизит B_SLI вводится вид слитка (монеты). 
--- Функция проверяет правильно ли указан номинал для выбранного количества слитков.

 BEGIN
   bars_audit.trace('KURS_SL:1 nP1_= '||to_char(nP1_)||'  nP2_= '||nP2_);

  
  BEGIN
   SELECT kurs_p,  kurs_k 
     INTO kurs_p_,  kurs_k_ 
     FROM operw w,bank_slitky s
    WHERE w.ref=nP1_ AND w.tag = 'B_SLI' AND N_SLI( s.kod ) = w.value and s.branch= NVL(tobopack.GetTOBO,0 );
   EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не встановлений курс покупки / продажу злитку '; RAISE err ;
  END;

  bars_audit.trace('KURS_SL:2 kurs_p_= '||to_char(kurs_p_)||' kurs_k_= '||to_char(kurs_k_));

  IF    nP2_='B_SLI' THEN RETURN kurs_p_;
  ELSIF nP2_='B_SLK' THEN RETURN kurs_k_;
  END IF;




  exception
  WHEN err THEN raise_application_error(-(20000),erm,TRUE);
  when others then RETURN 0;

 END KURS_SL; 
/
 show err;
 
PROMPT *** Create  grants  KURS_SL ***
grant EXECUTE                                                                on KURS_SL         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KURS_SL         to PYOD001;
grant EXECUTE                                                                on KURS_SL         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kurs_sl.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 