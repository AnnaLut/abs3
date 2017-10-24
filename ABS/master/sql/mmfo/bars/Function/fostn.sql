
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostn.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTN ( acc_ INTEGER, fdat1_ DATE, fdat2_ DATE )
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT gl.p_icurval(kv,ost,fdat2_)
   INTO nn_
   FROM  sal
   WHERE acc  = acc_  AND
         fdat = fdat1_ ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FOSTN;

 
/
 show err;
 
PROMPT *** Create  grants  FOSTN ***
grant EXECUTE                                                                on FOSTN           to ABS_ADMIN;
grant EXECUTE                                                                on FOSTN           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTN           to RPBN001;
grant EXECUTE                                                                on FOSTN           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostn.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 