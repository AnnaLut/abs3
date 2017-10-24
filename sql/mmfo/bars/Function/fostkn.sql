
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostkn.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTKN (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT   gl.p_icurval(kv,ost,fdat2_)
   INTO nn_
   FROM  sal
   WHERE acc  = acc_   AND
         fdat = fdat1_ AND ost >0 ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FOSTKN;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostkn.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 