
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_o2.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_O2 (ref_ int) return NUMBER IS
TT_ char(3);
US_ int;
KV_ int;
K2_ int;
A4_ char(4);
B4_ char(4);
pr_ char(1);
ma_ varchar2(12);
mb_ varchar2(12);
BEGIN
 select o.tt,o.userid,o.kv,o.kv2,
        substr(o.nlsa,1,4),substr(o.nlsb,1,4),o.mfoa,o.mfob
 into   TT_, US_, KV_, K2_, A4_, B4_, ma_,mb_
 from   oper o, tts t
 where  o.ref=ref_ and o.tt=t.tt;
 if (tt_='R01' or tt_='D01') and ma_<>mb_ and mb_=300175  then return  0;
 elsif tt_ in
  ('D00','D01','DT1','DT2','DT3','R00','R01','R02','RT0','RT1','RT2','RT3')
                                                          then return -1;
 elsif substr(A4_,1,2)='10' or substr(B4_,1,2)='10'       then return  1;
 elsif substr(A4_,1,1)='8'  or substr(B4_,1,1)='8'  then return  8;
 elsif substr(A4_,1,1)='9'  or substr(B4_,1,1)='9'  then return  9;
 elsif US_ in (84,73,104,110)                       then return  2;
 elsif US_=80                                       then return  6;
 elsif tt_='KL1' or tt_='KL2'                       then return  71;
 end if;
 select substr(flags,1,1) into PR_ from tts where tt=tt_;
 if PR_='0'                                         then return  7;
 elsif PR_='1' and substr(a4_,1,2)='26'             then return  72;
 elsif PR_='1'                                      then return  73;
 elsif KV_<>980 or K2_<>980                         then return  5;
 end if;                                            return  4;
END f_o2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_o2.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 