
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbs_tip.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBS_TIP (p_nbs VARCHAR2) RETURN number is

L_TIP  number;

begin
   begin
      select pr INTO L_TIP from rez_deb where nbs=p_nbs;
   EXCEPTION  WHEN NO_DATA_FOUND   THEN l_TIP := NULL;
   end;
   return l_TIP;
end;
/
 show err;
 
PROMPT *** Create  grants  F_NBS_TIP ***
grant EXECUTE                                                                on F_NBS_TIP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_NBS_TIP       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbs_tip.sql =========*** End *** 
 PROMPT ===================================================================================== 
 