
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/n_sli.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.N_SLI ( kod_ int)  RETURN varchar2 IS
  s1_ varchar2(100);
 BEGIN
  begin
   select Substr(LTRIM(RTRIM(name)) ||
     ', Ком.цена = '||ltrim(rtrim(to_char(cena/100,'999999.99'))),1,100)
   into S1_ from bank_slitky where kod=KOD_ and branch= NVL(tobopack.GetTOBO,0);
  exception when others then RETURN null;
  end ;
  RETURN S1_;
 END N_SLI; 
/
 show err;
 
PROMPT *** Create  grants  N_SLI ***
grant EXECUTE                                                                on N_SLI           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on N_SLI           to PYOD001;
grant EXECUTE                                                                on N_SLI           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/n_sli.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 