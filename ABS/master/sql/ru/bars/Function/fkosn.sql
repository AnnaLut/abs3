
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fkosn.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FKOSN (kv_ INTEGER, acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT sum(gl.p_icurval(kv_,kos,fdat))
   INTO nn_
   FROM  saldoa
   WHERE acc  =  acc_   AND
         fdat >= fdat1_ AND
         fdat <= fdat2_ ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FKOSN;
/
 show err;
 
PROMPT *** Create  grants  FKOSN ***
grant EXECUTE                                                                on FKOSN           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FKOSN           to START1;
grant EXECUTE                                                                on FKOSN           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fkosn.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 