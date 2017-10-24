
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rez_f_deb.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.REZ_F_DEB (p_nbs VARCHAR2) RETURN number is

L_deb  number;

begin
   begin
      select deb into l_deb from rez_deb where deb in (1,2) and nbs = p_nbs;
   EXCEPTION  WHEN NO_DATA_FOUND   THEN l_deb := 0;
   end;
   return l_deb;
end;
/
 show err;
 
PROMPT *** Create  grants  REZ_F_DEB ***
grant EXECUTE                                                                on REZ_F_DEB       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_F_DEB       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rez_f_deb.sql =========*** End *** 
 PROMPT ===================================================================================== 
 