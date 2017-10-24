
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostdn.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTDN (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT  0 - gl.p_icurval(kv,ost,fdat2_)
   INTO nn_
   FROM  sal
   WHERE acc  = acc_   AND
         fdat = fdat1_ AND ost <0 ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FOSTDN;
/
 show err;
 
PROMPT *** Create  grants  FOSTDN ***
grant EXECUTE                                                                on FOSTDN          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTDN          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostdn.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 