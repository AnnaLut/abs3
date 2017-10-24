
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pereocd.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PEREOCD (kv_ int, acc_ int, fdat_ date)
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
      where acc=acc_ and dk=0 and fdat=fdat_ and sos=5;

      select NVL(SUM(dos),0) into nBK_
      from saldob where acc=acc_ and fdat= fdat_ ;

     nR_:= NBK_ - nOK_ ;
   end if;
   return nR_;
 end f_pereocD;
/
 show err;
 
PROMPT *** Create  grants  F_PEREOCD ***
grant EXECUTE                                                                on F_PEREOCD       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PEREOCD       to RPBN001;
grant EXECUTE                                                                on F_PEREOCD       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pereocd.sql =========*** End *** 
 PROMPT ===================================================================================== 
 