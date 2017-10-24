

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CCK_PROBL_ON_DATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CCK_PROBL_ON_DATE ***

  CREATE OR REPLACE PROCEDURE BARS.P_CCK_PROBL_ON_DATE (
  P_SPAR date,
  P_KV varchar2 default '0',
  P_BRANCH varchar2 default '%',
  P_VIDD varchar2 default '1'
)
is
begin
  BARS.PUL.SET_MAS_INI('SPAR', to_char(P_SPAR,'dd-mm-yyyy'), 'P_SPAR');
  BARS.PUL.SET_MAS_INI('KV', P_KV, 'P_KV');
  BARS.PUL.SET_MAS_INI('BRANCH', P_BRANCH, 'P_BRANCH');
  BARS.PUL.SET_MAS_INI('VIDD', P_VIDD, 'P_VIDD');
end;
/
show err;

PROMPT *** Create  grants  P_CCK_PROBL_ON_DATE ***
grant EXECUTE                                                                on P_CCK_PROBL_ON_DATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CCK_PROBL_ON_DATE.sql =========*
PROMPT ===================================================================================== 
