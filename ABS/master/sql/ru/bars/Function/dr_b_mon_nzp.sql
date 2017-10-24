
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dr_b_mon_nzp.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DR_B_MON_NZP ( kod_ int)  RETURN varchar2 IS
  s1_ varchar2(100);
 BEGIN
  begin
   select LPAD(TO_CHAR(kod),4,'0')||' '||Substr(LTRIM(RTRIM(name_mon)) ||
     ', цена = '||ltrim(rtrim(to_char(cena_banka,'999999.99'))),1,100)
   into S1_ from v_bank_mon where kod=KOD_;
  exception when others then RETURN null;
  end ;
  RETURN S1_;
 END DR_B_MON_NZP;
/
 show err;
 
PROMPT *** Create  grants  DR_B_MON_NZP ***
grant EXECUTE                                                                on DR_B_MON_NZP    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DR_B_MON_NZP    to PYOD001;
grant EXECUTE                                                                on DR_B_MON_NZP    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dr_b_mon_nzp.sql =========*** End *
 PROMPT ===================================================================================== 
 