

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TUDA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TUDA ***

  CREATE OR REPLACE PROCEDURE BARS.TUDA is
begin
--  bc.subst_mfo(f_ourmfo_g);
    RETURN;
end tuda;
/
show err;

PROMPT *** Create  grants  TUDA ***
grant EXECUTE                                                                on TUDA            to BARSUPL;
grant EXECUTE                                                                on TUDA            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TUDA            to BARS_DM;
grant EXECUTE                                                                on TUDA            to FINMON01;
grant EXECUTE                                                                on TUDA            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TUDA.sql =========*** End *** ====
PROMPT ===================================================================================== 
