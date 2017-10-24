

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL_ACC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_DEAL_ACC ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_DEAL_ACC (
  p_nd     e_deal$base.nd%type,
  p_opt    int,
  p_acc26  e_deal$base.acc26%type
)
is
begin
  if p_opt = 1 then
    begin
     update e_deal$base d
     set d.ACC26 = p_acc26
     where d.nd = p_nd;
    end;
  end if;
end;
/
show err;

PROMPT *** Create  grants  P_ELT_DEAL_ACC ***
grant EXECUTE                                                                on P_ELT_DEAL_ACC  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL_ACC.sql =========*** En
PROMPT ===================================================================================== 
