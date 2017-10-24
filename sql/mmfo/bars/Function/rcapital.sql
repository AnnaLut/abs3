
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rcapital.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RCAPITAL (dat_ DATE)
RETURN NUMBER IS
sum_k	Number;
dat1_   Date;
sump1_  Number;
sump11_ Number;
sump2_  Number;
sump3_  Number;
sum6a_  Number;
sum6p_  Number;

BEGIN
   BEGIN
      SELECT s.datf, sum(to_number(s.znap))
      INTO dat1_, sump1_
      FROM   v_banks_report1 s, ek3_ok a
      WHERE  s.znap is not NULL         and
             s.kodp is not NULL         and
             substr(s.kodp,3,4)=a.nbs   and
             substr(s.kodp,1,2)='20'    and
             s.kodf='01'                and
             s.datf=(select max(fdat) from fdat where
                     fdat<=Dat_-1)
      GROUP BY s.datf ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dat1_:=Dat_;
      sump1_:=0 ;
   END ;

   BEGIN
      SELECT s.datf, sum(to_number(s.znap))
      INTO dat1_, sump11_
      FROM   v_banks_report1 s, ek3_ok a
      WHERE  s.znap is not NULL         and
             s.kodp is not NULL         and
             substr(s.kodp,3,4)=a.nbs   and
             substr(s.kodp,1,2)='10'    and
             s.kodf='01'                and
             s.datf=(select max(fdat) from fdat where
                     fdat<=Dat_-1)
      GROUP BY s.datf ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dat1_:=Dat_;
      sump11_:=0 ;
   END ;

   BEGIN
      SELECT datf, sum(to_number(znap))
      INTO dat1_, sump2_
      FROM   v_banks_report1
      WHERE  znap is not NULL         and
             kodp is not NULL         and
             substr(kodp,3,4) in ('1591','2401','5100')   and
             substr(kodp,2,1)='0'     and
             kodf='01'                and
             datf=(select max(fdat) from fdat where
                   fdat<=Dat_-1)
      GROUP BY datf ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dat1_:=dat_ ;
      sump2_:=0 ;
   END ;

   BEGIN
      SELECT datf, sum(to_number(znap))
      INTO dat1_, sum6a_
      FROM   v_banks_report1
      WHERE  znap is not NULL         and
             kodp is not NULL         and
             substr(kodp,3,1) in ('6','7')   and
             substr(kodp,1,2)='10'    and
             kodf='01'                and
             datf=(select max(fdat) from fdat where
                   fdat<=Dat_-1)
      GROUP BY datf ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dat1_:=dat_;
      sum6a_:=0 ;
   END ;

   BEGIN
      SELECT datf, sum(to_number(znap))
      INTO dat1_, sum6p_
      FROM   v_banks_report1
      WHERE  znap is not NULL         and
             kodp is not NULL         and
             substr(kodp,3,1) in ('6','7')   and
             substr(kodp,1,2)='20'    and
             kodf='01'                and
             datf=(select max(fdat) from fdat where
                   fdat<=Dat_-1)
      GROUP BY datf ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dat1_:=dat_;
      sum6p_:=0 ;
   END ;

   IF sum6p_-sum6a_ > 0 THEN
      sump2_:=sump2_+(sum6p_-sum6a_) ;
   END IF ;

   BEGIN
      SELECT s.datf, sum(to_number(s.znap))
      INTO dat1_, sump3_
      FROM   v_banks_report1 s, ek2_v a
      WHERE  s.znap is not NULL         and
             s.kodp is not NULL         and
             substr(s.kodp,3,4)=a.nbs   and
             substr(s.kodp,2,1)='0'     and
             s.kodf='01'                and
             s.datf=(select max(fdat) from fdat where
                     fdat<=Dat_-1)
      GROUP BY s.datf ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      dat1_:=dat_;
      sump3_:=0 ;
   END ;

   IF (sum6a_-sum6p_) > 0 THEN
      sump1_:=sump1_-(sum6a_-sum6p_) ;
   END IF ;

   sum_k:=sump1_-sump11_+sump2_-sump3_ ;

RETURN sum_k;

END Rcapital;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rcapital.sql =========*** End *** =
 PROMPT ===================================================================================== 
 