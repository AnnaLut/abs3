
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/calp_nr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CALP_NR 
( s_   NUMBER, -- сумма капитала
  int_ NUMBER, -- Ном.проц.ставка
  dat1_ date , -- дата "С" вклбчительно
  dat2_ date , -- дата "ПО" вклбчительно
  basey_ int   -- код базы начисления
  )
  RETURN NUMBER as  -- 05.03.2014 Sta без ОКРУГЛЕНИЯ
  b_yea     int ;  curdate_    date ;  nextdate_ date;  sum_ number := 0;
BEGIN              curdate_ := dat1_;
   while curdate_<=dat2_
   loop
      nextdate_:= to_date('3112'||TO_CHAR(curdate_,'YYYY'),'DDMMYYYY');
      if (dat2_ < nextdate_)  then  nextdate_ := dat2_;   end if;
      b_yea    := case basey_ when 0 then TO_DATE('3112'||TO_CHAR(curdate_,'YYYY'),'DDMMYYYY') - TRUNC(curdate_,'YEAR')+1
                              when 1 then 365
                              else        360
                  end  ;
      sum_     := sum_ + int_ * s_ * acrn.dlta(basey_,curdate_,nextdate_+1) / b_yea/100;
      curdate_ := nextdate_ + 1;
   end loop;
   return sum_ ;
END calp_NR    ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/calp_nr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 