

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_BRANCH.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FIN_REZ_BRANCH ***

  CREATE OR REPLACE PROCEDURE BARS.P_FIN_REZ_BRANCH 
(p_kor  int , -- =10 - кол-во дней корр.пров.
 p_DAT1 varchar2, -- дата "С"
 p_DAT2 varchar2  -- дата "По"
 ) Is
begin
   p_fin_rez_ext (p_kor, p_DAT1, p_DAT2, 1 );
end p_FIN_REZ_branch;
/
show err;

PROMPT *** Create  grants  P_FIN_REZ_BRANCH ***
grant EXECUTE                                                                on P_FIN_REZ_BRANCH to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FIN_REZ_BRANCH to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_BRANCH.sql =========*** 
PROMPT ===================================================================================== 
