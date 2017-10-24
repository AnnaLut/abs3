
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fdos.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FDOS (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
BEGIN
   SELECT NVL(sum(dos),0)
      INTO nn_
   FROM  saldoa
   WHERE acc  =  acc_
     AND fdat BETWEEN fdat1_ AND fdat2_ ;

   --if nn_ is null THEN
   --   nn_:=0;
   --end if;

   RETURN nn_;
END FDOS;
/
 show err;
 
PROMPT *** Create  grants  FDOS ***
grant EXECUTE                                                                on FDOS            to ABS_ADMIN;
grant EXECUTE                                                                on FDOS            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FDOS            to DPT;
grant EXECUTE                                                                on FDOS            to NALOG;
grant EXECUTE                                                                on FDOS            to RCC_DEAL;
grant EXECUTE                                                                on FDOS            to RPBN001;
grant EXECUTE                                                                on FDOS            to RPBN002;
grant EXECUTE                                                                on FDOS            to START1;
grant EXECUTE                                                                on FDOS            to WR_ALL_RIGHTS;
grant EXECUTE                                                                on FDOS            to WR_CUSTLIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fdos.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 