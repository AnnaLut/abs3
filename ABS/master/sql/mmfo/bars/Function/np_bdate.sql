
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/np_bdate.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NP_BDATE (P_Dat date, SHAG_  int default 1 )
  return date is

  DAT_ date;   nTmp_ int;
  -- поиск ближайщей раб.даты с заданным шагом и направлением (знак)
BEGIN

 DAT_:= P_DAT;

 <<AAA>> null;
   DAT_:= DAT_ + SHAG_;
   begin
     select 1 into nTmp_ from holiday where kv=980 and holiday=DAT_ ;
     GOTO AAA;
   exception when no_data_found then RETURN DAT_;
   end;

end NP_BDATE;
 
/
 show err;
 
PROMPT *** Create  grants  NP_BDATE ***
grant EXECUTE                                                                on NP_BDATE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NP_BDATE        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/np_bdate.sql =========*** End *** =
 PROMPT ===================================================================================== 
 