
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_bmp.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BMP (
  nP1_ NUMBER,  --REF
  nP2_ NUMBER,  --S
  nP3_ INT)  --kv
 RETURN NUMBER IS
  COL_     NUMBER;
  VES_     NUMBER;
  DIG_     INT;
  val_kurs bank_slitky.kurs_p%type;
  kurs_p_  bank_slitky.kurs_p%type; 
  err      EXCEPTION;
  erm      VARCHAR2(80);
---  Функция для проверки правильности проведения операции TMP.
---  В сумму операции  BMK водиться количество слитков(монет) 
---   в доп. реквизит B_SLC вводится номинал слитка (монеты), 
---   в доп. реквизит N_BMP вводится вид слитка (монеты). 
--- Функция проверяет правильно ли указан номинал для выбранного количества слитков.

 BEGIN
  --- bars_audit.trace('F_BMP:1 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );

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
     EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнений дод. реквізит B_SLC'; RAISE err ;
    END;
   
  --- bars_audit.trace('F_BMP:2 nP1_= '||to_char(nP1_)||'  nP2_= '||to_char(nP2_)||' VES_= '||to_char(VES_)||' COL_='||to_char(COL_) );

    BEGIN
      SELECT TO_NUMBER(w.value)--,'99999990D99')
        INTO KURS_P_
        FROM operw w
       WHERE w.ref=nP1_ AND w.tag='KBM_P';
      EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнений дод. реквізит "Курс купівлі-продажу"'; RAISE err ;
    END;
    
---    bars_audit.trace('F_BMP:3 nP1_= '||to_char(nP1_)||'  KURS_P_='||to_char( KURS_P_) );

    BEGIN
     SELECT decode(nvl(s.ves_un,0),0, s.ves,s.ves_un), s.cena/decode(nvl(s.ves_un,0),0, s.ves,s.ves_un)
       INTO VES_ , val_kurs
       FROM operw w,v_bank_metals_branch s
      WHERE w.ref=nP1_ AND w.tag = 'N_BMP' AND N_BMP( s.kod ) = w.value ;
     EXCEPTION WHEN NO_DATA_FOUND THEN erm:= 'Не коректно заповнене значення  дод. реквізиту  N_BMP'; RAISE err ;
    END;

   --- bars_audit.trace('F_BMP:4 nP1_= '||to_char(nP1_)||' VES_= '||to_char(VES_)||' val_kurs='||to_char(val_kurs) );
    
---  bars_audit.trace('F_BMP:5 nP1_= '||to_char(nP1_)||' val_kurs/100-KURS_P_ '||to_char(val_kurs/100-KURS_P_));
    
    IF nP2_/power(10,DIG_)*VES_ <> COL_
        THEN erm:= 'Кількість зливків та номінал зливків не відповідають вибраному виду зливка!'; RAISE err ;
        
     ELSIF val_kurs/100<>KURS_P_
         THEN erm:= 'Курс зливку (монети) не висповідає  вибраному виду зливку (монети)!'; RAISE err ;
     ELSE RETURN 0;
    END IF;

    
  exception
  WHEN err THEN raise_application_error(-(20000),erm,TRUE);
  when others then RETURN 0;

END F_BMP; 
/
 show err;
 
PROMPT *** Create  grants  F_BMP ***
grant EXECUTE                                                                on F_BMP           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BMP           to PYOD001;
grant EXECUTE                                                                on F_BMP           to START1;
grant EXECUTE                                                                on F_BMP           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_bmp.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 