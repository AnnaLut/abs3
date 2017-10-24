
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pereock.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PEREOCK (kv_ int, acc_ int, fdat_ date)
 return number is
  nOD_ number;  nOK_ number;   nBD_ number;  nBK_ number;
  nAD_ number;  nAK_ number;   nR_  number;
 begin
   if kv_=980 then      nR_:=0;
   else
--      select NVL(sum(gl.p_icurval(kv_, kos,fdat_)),0) into nAK_
--      from saldoa where acc=acc_ and fdat= fdat_ ;
--      select NVL( sum(gl.p_icurval(kv_,s, fdat_)), 0)   into nOD_
--      from opldok
--      where acc=acc_ and dk=0 and fdat=fdat_ and sos=5;
      select NVL( sum(gl.p_icurval(kv_,s, fdat_)), 0)   into nOK_
      from opldok
      where acc=acc_ and dk=1 and fdat=fdat_ and sos=5;
      select NVL(SUM(kos),0) into nBK_
      from saldob where acc=acc_ and fdat= fdat_ ;
     nR_:= NBK_ - nOK_ ;
   end if;
   return nR_;
 end f_pereocK;
/
 show err;
 
PROMPT *** Create  grants  F_PEREOCK ***
grant EXECUTE                                                                on F_PEREOCK       to ABS_ADMIN;
grant EXECUTE                                                                on F_PEREOCK       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PEREOCK       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pereock.sql =========*** End *** 
 PROMPT ===================================================================================== 
 