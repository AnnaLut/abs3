
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/irr.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IRR (r_ NUMBER) RETURN NUMBER IS
-- Внутренний уровень доходности
   npv_ NUMBER;    r    NUMBER;    r1   NUMBER;   r2   NUMBER;
   npv1 NUMBER:=0; npv2 NUMBER:=0; irr_ NUMBER;
   nTmp1_ number;  nTmp2_ number;
   cf_  CF := CF();
   cursor c0 is select s from tmp_irr order by n;
   ern  integer :=11;
   k number;
BEGIN
   open c0;
   loop
--    fetch c0 bulk collect into cf_ limit 1000;
      fetch c0 bulk collect into cf_ ;
      exit when c0%notfound;
      null;
   end loop;

   if cf_.count>0 then
      r :=greatest(r_,0.0001);
      k :=least(power(0.1,(length(trunc(1/r))+2)),0.0001);
      FOR i IN 1..1000000
      LOOP
         npv_:=NPV(r,cf_);
         IF    npv_>0 THEN r1 := r;  npv1 := npv_;  r:=r+k;
         ELSIF npv_<0 THEN r2 := r;  npv2 := npv_;  r:=r-k;
         else  Return (r);
         END IF;

         IF npv1 <>0 AND npv2 <> 0 THEN
            nTmp1_ :=NPV(r1,cf_);
            nTmp2_ :=NPV(r2,cf_);
            If nTmp1_<>nTmp2_ Then
               RETURN r1 +  nTmp1_ * (r2-r1) / (nTmp1_-nTmp2_) ;
            else
               RETURN r1;
            end if;

         END IF;
      END LOOP;
      raise_application_error(-(20000+ern),'\ Больше 1 000 000 итераций',TRUE);
   end if;
   return 0;
END IRR;
 
/
 show err;
 
PROMPT *** Create  grants  IRR ***
grant EXECUTE                                                                on IRR             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IRR             to RCC_DEAL;
grant EXECUTE                                                                on IRR             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/irr.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 