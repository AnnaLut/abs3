

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RUN_BANK_PF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RUN_BANK_PF ***

  CREATE OR REPLACE PROCEDURE BARS.RUN_BANK_PF (p_dat1 date)  is
begin
Bank_PF(4,DAT_NEXT_U(p_dat1,-1), DAT_NEXT_U(p_dat1,-1));
end;
/
show err;

PROMPT *** Create  grants  RUN_BANK_PF ***
grant EXECUTE                                                                on RUN_BANK_PF     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RUN_BANK_PF.sql =========*** End *
PROMPT ===================================================================================== 
