
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_prev_u.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_PREV_U (datb_ DATE, prev_ INT)
RETURN DATE IS
DAT_ DATE;  DAT1_ DATE;  KOL_   INT;  i_ INT;
ern         CONSTANT POSITIVE := 208;
err         EXCEPTION;  erm         VARCHAR2(80);
BEGIN
 DAT_:=DATB_ - prev_;
 SELECT COUNT(*) INTO KOL_ FROM holiday
 WHERE kv=980 AND holiday>=DAT_ AND holiday<DATB_;
 IF KOL_=0 THEN  RETURN(DAT_); END IF;
 FOR i_ IN 1..10
 LOOP
 BEGIN
   DAT_:=DAT_ - 1;
   SELECT holiday INTO DAT1_ FROM holiday WHERE kv=980 AND holiday=DAT_;
   KOL_:=KOL_+1;
   EXCEPTION WHEN NO_DATA_FOUND THEN
   BEGIN --DAT_=5
    IF DATb_ - DAT_ = prev_ + kol_  THEN RETURN (DAT_);   END IF;
   END;
 END;
 END LOOP;
END Dat_Prev_U ;
/
 show err;
 
grant execute on BARS.DAT_PREV_U to BARS_ACCESS_DEFROLE;
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_prev_u.sql =========*** End ***
 PROMPT ===================================================================================== 
 