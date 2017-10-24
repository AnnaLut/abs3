
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zaypay.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAYPAY (dat_ DATE, sos_ INTEGER, kv_ NUMBER)
RETURN NUMBER
IS
  netto_  NUMBER;
  delta_  NUMBER;  S980_  NUMBER;
  Kmax_   NUMBER;  Kmin_  NUMBER;
  K_      NUMBER;  S_     NUMBER;
  --------------------------------
  ern  CONSTANT POSITIVE := 208;
  err  EXCEPTION;
  erm VARCHAR2(80);
BEGIN
---------------- находим нетто валюты --------------------
 BEGIN
   SELECT sum(decode(dk,1,s2,-s2)) INTO netto_
   FROM v_zay
   WHERE sos=sos_ AND vdate=dat_ AND kv2=kv_
   HAVING sum(decode(dk,1,s2,-s2))<>0;
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
 END;
 IF netto_ > 0 THEN  -- ГОУ покупает валюту
    BEGIN
      Kmin_:=0;     delta_:=netto_;    S980_:=0;
      WHILE delta_>0 LOOP
            SELECT kurs_f, sum(s2) INTO K_, S_
            FROM v_zay
            WHERE sos=sos_ AND dk=1 AND vdate=dat_ AND
                  kv2=kv_  AND kurs_f>Kmin_ AND
                  kurs_f=(SELECT min(kurs_f) FROM v_zay
                          WHERE sos=sos_  AND dk=1 AND vdate=dat_   AND
                                kv2=kv_   AND kurs_f>Kmin_)
            GROUP BY kurs_f;
            IF delta_- S_<=0 THEN
                S980_:=S980_+abs(delta_)*K_;
                delta_:=delta_- S_;
            ELSE
                S980_:=S980_+S_*K_;
                delta_:=delta_- S_;
            END IF;
            Kmin_:=K_;
      END LOOP;
return -S980_;
   END;
 ELSE   -- ГОУ продает валюту
     BEGIN
      Kmax_:=9999999999;     delta_:=-netto_;    S980_:=0;
      WHILE delta_>0 LOOP
            SELECT kurs_f, sum(s2) INTO K_, S_
            FROM v_zay
            WHERE sos=sos_  AND dk=2         AND
                  kv2=kv_  AND kurs_f<Kmax_ AND vdate=dat_ AND
                  kurs_f=(SELECT max(kurs_f) FROM v_zay
                          WHERE sos=sos_ AND dk=2   AND vdate=dat_ AND
                                kv2=kv_   AND kurs_f<Kmax_)
            GROUP BY kurs_f;
            IF delta_- S_<=0 THEN
                S980_:=S980_+abs(delta_)*K_;
                delta_:=delta_- S_;
            ELSE
                S980_:=S980_+S_*K_;
                delta_:=delta_- S_;
            END IF;
            Kmax_:=K_;
      END LOOP;
return S980_;
   END;
  END IF;
END;
/
 show err;
 
PROMPT *** Create  grants  F_ZAYPAY ***
grant EXECUTE                                                                on F_ZAYPAY        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ZAYPAY        to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_ZAYPAY        to ZAY;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_zaypay.sql =========*** End *** =
 PROMPT ===================================================================================== 
 