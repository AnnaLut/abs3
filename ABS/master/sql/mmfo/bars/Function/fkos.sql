
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fkos.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FKOS (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT sum(kos)
   INTO nn_
   FROM  saldoa
   WHERE acc  =  acc_   AND
         fdat >= fdat1_ AND
         fdat <= fdat2_ ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FKOS;
 
/
 show err;
 
PROMPT *** Create  grants  FKOS ***
grant EXECUTE                                                                on FKOS            to ABS_ADMIN;
grant EXECUTE                                                                on FKOS            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FKOS            to DPT;
grant EXECUTE                                                                on FKOS            to NALOG;
grant EXECUTE                                                                on FKOS            to RCC_DEAL;
grant EXECUTE                                                                on FKOS            to RPBN001;
grant EXECUTE                                                                on FKOS            to RPBN002;
grant EXECUTE                                                                on FKOS            to START1;
grant EXECUTE                                                                on FKOS            to WR_ALL_RIGHTS;
grant EXECUTE                                                                on FKOS            to WR_CUSTLIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fkos.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 