

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SUDA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SUDA ***

  CREATE OR REPLACE PROCEDURE BARS.SUDA 
is
begin
  bc.go('/');
end suda;
/
show err;

PROMPT *** Create  grants  SUDA ***
grant EXECUTE                                                                on SUDA            to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on SUDA            to BARSUPL;
grant EXECUTE                                                                on SUDA            to BARS_DM;
grant EXECUTE                                                                on SUDA            to BARS_SUP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SUDA.sql =========*** End *** ====
PROMPT ===================================================================================== 
