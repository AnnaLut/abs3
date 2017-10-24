
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/af1.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.AF1 
(TT_ char, US_ int, KV_ int, K2_ int, A4_ char, B4_ char, ma_ varchar2, mb_ varchar2)
return NUMBER IS
pr_ char(1);
BEGIN
-- отв провод
 if (tt_='R01' or tt_='D01') and ma_<>mb_ and mb_=300465  then return  0;
-- квитовка
 elsif tt_ in  ('D00','D01','DT1','DT2','DT3','R00',
                'R01','R02','RT0','RT1','RT2','RT3')  then return -1;
 elsif substr(A4_,1,2)='10' or substr(B4_,1,2)='10'   then return  1;
-- внебаланс
 elsif substr(A4_,1,1)='9'  or substr(B4_,1,1)='9'  then return  9;
------ elsif US_ in (84,73,104,110)                       then return  2;
------ elsif US_=80                                       then return  6;
 elsif tt_='KL1' or tt_='KL2'                       then return  71;
 end if;
 select substr(flags,1,1) into PR_ from tts where tt=tt_;
 if PR_='0'                                         then return  7;
 elsif substr(A4_,1,1)='8'  or substr(B4_,1,1)='8'  then return  8;
 elsif PR_='1' and substr(a4_,1,2)='26'             then return  72;
 elsif PR_='1'                                      then return  73;
 elsif KV_<>980 or K2_<>980                         then return  5;
 end if;                                            return  4;
END af1;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/af1.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 