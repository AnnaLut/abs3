

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
grant EXECUTE                                                                on SUDA            to BARSUPL;
grant EXECUTE                                                                on SUDA            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SUDA            to BARS_DM;
grant EXECUTE                                                                on SUDA            to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SUDA.sql =========*** End *** ====
PROMPT ===================================================================================== 
