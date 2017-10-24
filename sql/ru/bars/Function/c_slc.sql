
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/c_slc.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.C_SLC (
  nP1_ NUMBER,  --REF
  nP2_ NUMBER,  --S
  nP3_ INT)  --kv
 RETURN NUMBER IS
  COL_     NUMBER;
  VES_     NUMBER;
  DIG_     INT;
  val_kurs bank_slitky.kurs_p%type;
  kurs_K_  bank_slitky.kurs_p%type; 
  err      EXCEPTION;
  erm      VARCHAR2(80);
---  Функция для проверки правильности проведения операции BMK.
---  В сумму операции  BMK водиться количество слитков(монет) 
---   в доп. реквизит B_SLC вводится номинал слитка (монеты), 
---   в доп. реквизит B_SLK вводится вид слитка (монеты). 
--- Функция проверяет правильно ли указан номинал для выбранного количества слитков.

 BEGIN
   --bars_audit.trace('BMK:1 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );

    BEGIN
   SELECT dig
     INTO DIG_
     FROM tabval
    WHERE kv=nP3_;
   EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнений DIG'|| DIG_; RAISE err ;
  END;

  BEGIN
   SELECT TO_NUMBER(w.value,'99999990D999')
     INTO COL_
     FROM operw w
    WHERE w.ref=nP1_ AND w.tag='B_SLC';
   EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнений дод. реквізит B_SLC!'; RAISE err ;
  END;
   ---bars_audit.trace('BMK:2 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );


    BEGIN
      SELECT TO_NUMBER(w.value)--,'99999990D99')
        INTO KURS_K_
        FROM operw w
       WHERE w.ref=nP1_ AND w.tag='KUR_K';
      EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнений дод. реквізит "Курс купівлі-продажу"'; RAISE err ;
    END;
    
   --bars_audit.trace('BMK:3 nP1_= '||to_char(nP1_)||'  KURS_K_='||to_char( KURS_K_) );


  BEGIN
   SELECT decode(nvl(s.ves_un,0),0, s.ves,s.ves_un), s.kurs_k
     INTO VES_ , val_kurs
     FROM operw w,bank_slitky s
    WHERE w.ref=nP1_ AND w.tag = 'B_SLK' AND N_SLK( s.kod ) = w.value and s.branch= NVL(tobopack.GetTOBO,0 );
   EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнене значення  дод. реквізиту B_SLI, B_SLK'; RAISE err ;
  END;

   --bars_audit.trace('BMK:4 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );

   --bars_audit.trace('BMK:5 nP1_= '||to_char(nP1_)||' val_kurs/100-KURS_K_ '||to_char(val_kurs/100-KURS_K_));
    
  IF nP2_/power(10,DIG_)*VES_ <> COL_
         THEN erm:= 'Кількість зливків та номінал зливків не відповідають вибраному виду зливка!'; RAISE err ;
         
   ELSIF val_kurs/100<>KURS_K_
         THEN erm:= 'Курс зливку (монети) не висповідає  вибраному виду зливку (монети)!'; RAISE err ;
   ELSE RETURN 0;
  END IF;




  /*exception
  WHEN err THEN raise_application_error(-(20000),erm,TRUE);
  when others then RETURN 0;*/

 END C_SLC; 
/
 show err;
 
PROMPT *** Create  grants  C_SLC ***
grant EXECUTE                                                                on C_SLC           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on C_SLC           to PYOD001;
grant EXECUTE                                                                on C_SLC           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/c_slc.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 