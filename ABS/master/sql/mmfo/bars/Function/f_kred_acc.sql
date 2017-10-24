
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_kred_acc.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KRED_ACC (acc_ INTEGER, mod_ INTEGER, fdat_ DATE)
RETURN NUMBER IS
nn_     DECIMAL;
mask_   	CHAR(9);
nbs_    CHAR(3);
kv_     NUMBER;
mfo_    VARCHAR2(12);
nls_    VARCHAR2(15);

BEGIN

   SELECT substr(f_ourmfo,1,5) INTO mfo_ FROM dual;

   BEGIN
     SELECT substr(nls,1,3), substr(nls,6,9), kv
     INTO nbs_, mask_, kv_
     FROM accounts a --, kl_r020 k
     WHERE acc=acc_ AND --a.nbs=k.r020 AND k.f_11=1     AND
           a.nbs in (select r020
                     from kod_r020
                     where a010='11' and
                        trim(prem)='สม' and
                        d_open<=fdat_ and
                        (d_close is null or d_close>fdat_)) and
           substr(a.nbs,4,1) NOT IN ('6','7','8','9') AND
           (a.dazs IS NULL OR a.dazs>fdat_);
     EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
   END;

   IF mask_ IS NOT NULL THEN
      SELECT ltrim(rtrim(to_char(nbs_||mod_||'0'||mask_)))
      INTO nls_ FROM dual;

      BEGIN
        SELECT s.ost INTO nn_
        FROM  sal s, accounts a
        WHERE s.acc=a.acc             AND
              s.fdat = fdat_          AND
           -- substr(a.nls,4,1)=mod_  AND
           -- rpad(substr(a.nls,6,9),9,' ')=mask_ AND
           -- substr(a.nls,1,3)=nbs_ AND
              vkrzn(ltrim(rtrim(mfo_)),nls_)=a.nls AND
              a.kv=kv_ ;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
      END;
   ELSE
      RETURN 0;
   END IF;
   RETURN nn_;
END F_KRED_ACC;
 
/
 show err;
 
PROMPT *** Create  grants  F_KRED_ACC ***
grant EXECUTE                                                                on F_KRED_ACC      to ABS_ADMIN;
grant EXECUTE                                                                on F_KRED_ACC      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_KRED_ACC      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_kred_acc.sql =========*** End ***
 PROMPT ===================================================================================== 
 