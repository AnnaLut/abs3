
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fdosn.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FDOSN (kv_ INTEGER, acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT sum(gl.p_icurval(kv_,dos,fdat))
   INTO nn_
   FROM  saldoa
   WHERE acc  =  acc_   AND
         fdat >= fdat1_ AND
         fdat <= fdat2_ ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FDOSN;
/
 show err;
 
PROMPT *** Create  grants  FDOSN ***
grant EXECUTE                                                                on FDOSN           to ABS_ADMIN;
grant EXECUTE                                                                on FDOSN           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FDOSN           to DPT;
grant EXECUTE                                                                on FDOSN           to START1;
grant EXECUTE                                                                on FDOSN           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fdosn.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 