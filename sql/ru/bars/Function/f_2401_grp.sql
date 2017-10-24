
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_2401_grp.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_2401_GRP (p_nbs accounts.nbs%type, p_ob22 accounts.ob22%type) RETURN VARCHAR2 is
/* Версия 1.0 17-02-2017
   Определение Группы портфельного метода
   -------------------------------------
*/

 l_grp integer;

begin
   begin
      SELECT grp into l_grp FROM tmp_nbs_2401 WHERE  nbs = p_nbs and ob22 = p_ob22;
   EXCEPTION WHEN NO_DATA_FOUND THEN  l_grp := NULL;
   END;
   return(l_grp);
end;
/
 show err;
 
PROMPT *** Create  grants  F_2401_GRP ***
grant EXECUTE                                                                on F_2401_GRP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_2401_GRP      to RCC_DEAL;
grant EXECUTE                                                                on F_2401_GRP      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_2401_grp.sql =========*** End ***
 PROMPT ===================================================================================== 
 