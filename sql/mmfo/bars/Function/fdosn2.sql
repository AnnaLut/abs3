
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fdosn2.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FDOSN2 (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
kv_     DECIMAL;
BEGIN
   SELECT sum(dos)
   INTO nn_
   FROM  saldoa
   WHERE acc  =  acc_   AND
         fdat >= fdat1_ AND
         fdat <= fdat2_ ;
   if nn_ is null THEN
      nn_:=0;
   else
      select kv into kv_ from accounts where acc=acc_;
      nn_:=gl.p_icurval(kv_,nn_,fdat2_);
   end if;
   RETURN nn_;
END FDOSN2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fdosn2.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 