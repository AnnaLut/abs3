
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/n_slk.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.N_SLK ( kod_ int)  RETURN varchar2 IS
  s1_ varchar2(100);
 BEGIN
  begin
   select Substr(LTRIM(RTRIM(name)) ||
     ', Ком.цена = '||ltrim(rtrim(to_char(cena_k/100,'999999.99'))),1,100)
   into S1_ from bank_slitky where kod=KOD_ and branch= NVL(tobopack.GetTOBO,0);
  exception when others then 
  RETURN null;
  end ;
  RETURN S1_;
 END N_SLK; 
 
/
 show err;
 
PROMPT *** Create  grants  N_SLK ***
grant EXECUTE                                                                on N_SLK           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on N_SLK           to PYOD001;
grant EXECUTE                                                                on N_SLK           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/n_slk.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 