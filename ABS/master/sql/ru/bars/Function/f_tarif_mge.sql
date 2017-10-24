
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_mge.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_MGE 
-- тариф комиссии за перевод по Money Gram в валюте
(  S_   NUMERIC)      -- сумма в копейках
RETURN NUMERIC IS
 SK_ NUMERIC;
BEGIN
 SK_:=0;
 BEGIN

     IF 0<S_ AND S_<=10000 THEN SK_:=600;
   ELSE
     IF 10000<S_ AND S_<=15000 THEN SK_:=600;
   ELSE
     IF 15000<S_ AND S_<=25000 THEN SK_:=1000;
   ELSE
     IF 25000<S_ AND S_<=30000 THEN SK_:=1300;
   ELSE
     IF 30000<S_ AND S_<=40000 THEN SK_:=1700;
   ELSE
     IF 40000<S_ AND S_<=60000 THEN SK_:=2100;
   ELSE
     IF 60000<S_ AND S_<=90000 THEN SK_:=2700;
   ELSE
     IF 90000<S_ AND S_<=125000 THEN SK_:=3700;
   ELSE
     IF 125000<S_ AND S_<=150000 THEN SK_:=5000;
   ELSE
     IF 150000<S_ AND S_<=200000 THEN SK_:=6500;
   ELSE
     IF 200000<S_ AND S_<=250000 THEN SK_:=7000;
   ELSE
     IF 250000<S_ AND S_<=300000 THEN SK_:=8000;
   ELSE
     IF 300000<S_ AND S_<=350000 THEN SK_:=8000;
   ELSE
     IF 350000<S_ AND S_<=400000 THEN SK_:=8000;
   ELSE
     IF 400000<S_ THEN SK_:=13000;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END IF;
   END;
RETURN SK_;
END F_Tarif_Mge;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_MGE ***
grant EXECUTE                                                                on F_TARIF_MGE     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_MGE     to PYOD001;
grant EXECUTE                                                                on F_TARIF_MGE     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_mge.sql =========*** End **
 PROMPT ===================================================================================== 
 