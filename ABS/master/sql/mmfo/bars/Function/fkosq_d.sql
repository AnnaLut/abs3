
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fkosq_d.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FKOSQ_D (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
/*lypskykh 22.03.2017 Summs kos eqv. on account on period*/
nn_     DECIMAL;
l_kv number(3);
BEGIN
   select kv into l_kv from accounts a where a.acc = acc_;
   SELECT sum(gl.p_icurval(l_kv, kos, fdat))
   INTO nn_
   FROM  saldoa
   WHERE acc  =  acc_   AND
         fdat >= fdat1_ AND
         fdat <= fdat2_ ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FKOSQ_D;
/
 show err;
 
PROMPT *** Create  grants  FKOSQ_D ***
grant EXECUTE                                                                on FKOSQ_D         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fkosq_d.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 