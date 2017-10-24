
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/eqv_obs.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EQV_OBS 
 (kv_  NUMBER,
  sum_ NUMBER,
  dat_ DATE,
  obs_ NUMBER DEFAULT 0 )
RETURN NUMBER IS
---------------------------------------------------------------------------
-- Расчет эквивалента заданной суммы S_ в указанной валюте KV_ на дату DAT_
-- по официальному курсу OBS_ = 0
-- по курсу покупки      OBS_ = 1            С УЧЕТОМ ТОБО!!!!
-- по курсу продажу      OBS_ = 2
---------------------------------------------------------------------------
  DigMain_ NUMBER;
  Dig_     NUMBER;
  vdate_   DATE;
  rate_    NUMBER;
  tobo_    tobo.tobo%type;
  ern      CONSTANT POSITIVE := 207;
  err      EXCEPTION;
  erm      VARCHAR2(80);
---------------------------------------------------------------------------
BEGIN

  IF kv_ = gl.baseval OR sum_ = 0 THEN
     RETURN sum_;
  END IF;

  BEGIN
     SELECT NVL(dig,2) INTO Dig_ FROM tabval WHERE kv = kv_;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
       erm := '9313 - No Currency defined #('||TO_CHAR(kv_)||')';
       RAISE err;
  END;

  BEGIN
     SELECT NVL(dig,2) INTO DigMain_ FROM tabval WHERE kv = Gl.baseval;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
       erm := '9313 - No Currency defined #('||TO_CHAR(Gl.baseval)||')';
       RAISE err;
  END;

  BEGIN
    tobo_ := tobopack.GetTobo();
  EXCEPTION
    WHEN OTHERS THEN
      erm := '9001 - Невозможно получить код ТОБО';
      RAISE err;
  END;

  bars_audit.trace( 'EQV_OBS: (p_kv = %s, p_sum = %s, p_dat = %s, p_obs = %s, l_Dig = %s, l_DigMain = %s, l_tobo = %s)',
                    to_char(kv_ ), to_char(sum_),     to_char(dat_), to_char(obs_),
                    to_char(Dig_), to_char(DigMain_), tobo_ );

  IF   (nvl(tobo_,'0')='0') -- мы в Головном банке в одно-мфо схеме
    OR (tobo_ IS NOT NULL AND obs_ = 0)  -- мы в ТОБО, но просят официальный курс
  THEN
     BEGIN
       SELECT vdate, decode(obs_,1,rate_b,2,rate_s,rate_o)/bsum
         INTO vdate_, rate_
         FROM cur_rates
        WHERE (kv,vdate) =
              (SELECT kv, MAX(vdate) FROM cur_rates
                WHERE vdate <= dat_ AND kv = kv_
                GROUP BY kv );
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
          erm := '9314 - No rate was set for curency #'||TO_CHAR(kv_);
          RAISE err;
     END;
  ELSE -- tobo_ IS NOT NULL
     BEGIN
       SELECT vdate, decode(obs_,1,rate_b,2,rate_s)/bsum
         INTO vdate_, rate_
         FROM cur_rates_tobo
        WHERE tobo = tobo_ AND (kv,vdate) =
              (SELECT kv, MAX(vdate) FROM cur_rates_tobo
                WHERE vdate <= dat_ AND kv = kv_
                GROUP BY kv );
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
          erm := '9314 - No rate was set for curency #'||TO_CHAR(kv_)||
                 ' tobo #'||TO_CHAR(tobo_);
          RAISE err;
     END;
  END IF;

  IF nvl(rate_,0) = 0 THEN
     erm := '9314 - Zero rate was set for curency #'||TO_CHAR(kv_);
     RAISE err;
  END IF;

  rate_ := ROUND(rate_*sum_*POWER(10,(DigMain_-Dig_)),0);

  bars_audit.trace( 'EQV_OBS (eqv = %s)',  to_char(rate_) );

  IF nvl(rate_,0) =  0 THEN
     RETURN SIGN(sum_);
  ELSE
     RETURN rate_;
  END IF;

EXCEPTION
 WHEN err    THEN
     raise_application_error(-(20000+ern),'\'||erm,TRUE);
 WHEN OTHERS THEN
     raise_application_error(-(20000+ern),SQLERRM,TRUE);
END eqv_obs;
/
 show err;
 
PROMPT *** Create  grants  EQV_OBS ***
grant EXECUTE                                                                on EQV_OBS         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on EQV_OBS         to PYOD001;
grant EXECUTE                                                                on EQV_OBS         to START1;
grant EXECUTE                                                                on EQV_OBS         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/eqv_obs.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 