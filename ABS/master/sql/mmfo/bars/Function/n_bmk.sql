
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/n_bmk.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.N_BMK ( kod_ int)  RETURN varchar2 IS
  s1_ varchar2(100);
 BEGIN
  begin
   select lpad(to_char(kod),4,'0')||' '||Substr(LTRIM(RTRIM(name)) ||
     ', Ком.цена = '||ltrim(rtrim(to_char(cena_k/100,'999999.99'))),1,100)
   into S1_ from v_bank_metals_branch where kod=KOD_ ;
  exception when others then
  RETURN null;
  end ;
  RETURN S1_;
 END N_BMK;
 
/
 show err;
 
PROMPT *** Create  grants  N_BMK ***
grant EXECUTE                                                                on N_BMK           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on N_BMK           to PYOD001;
grant EXECUTE                                                                on N_BMK           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/n_bmk.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 