

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_XOZ_REZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_XOZ_REZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_XOZ_REZ (p_dat date) is

 l_dat VARCHAR2(10);

begin
   l_dat := to_char(p_dat,'dd-mm-yyyy');
   xoz.rez(l_dat,1);
end;
/
show err;

PROMPT *** Create  grants  P_XOZ_REZ ***
grant EXECUTE                                                                on P_XOZ_REZ       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_XOZ_REZ       to RCC_DEAL;
grant EXECUTE                                                                on P_XOZ_REZ       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_XOZ_REZ.sql =========*** End ***
PROMPT ===================================================================================== 
