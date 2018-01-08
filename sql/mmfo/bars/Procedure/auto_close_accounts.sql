

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AUTO_CLOSE_ACCOUNTS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AUTO_CLOSE_ACCOUNTS ***

CREATE OR REPLACE PROCEDURE BARS.auto_close_accounts
( p_numb number
)
  is
  l_tip tips.tip%type;
  l_acc accounts.acc%type;
  l_ost accounts.ostc%type;
begin
  for c in (select a.acc from accounts a, auto_close_acc aca
             where a.tip = aca.tip
               and a.dazs is null
               and ( a.dapp  < gl.bdate or  a.dapp  is null)
               and a.ostc = a.ostb
               and a.ostc = 0
               and (
               ( select count(distinct(d.nd)) from cc_accp cp, cc_deal d
                where cp.acc = a.acc and cp.nd = d.nd and d.sos <> 15)=0
                and
                ( select count(distinct(d.nd)) from nd_acc nd, cc_deal d
                where nd.acc = a.acc and nd.nd = d.nd and d.sos <> 15)=0))
    loop
      update accounts
         set dazs = trunc(gl.bdate)
       where acc = c.acc;
    end loop;
end;
/
show err;

PROMPT *** Create  grants  AUTO_CLOSE_ACCOUNTS ***
grant EXECUTE                                                                on AUTO_CLOSE_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on AUTO_CLOSE_ACCOUNTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AUTO_CLOSE_ACCOUNTS.sql =========*
PROMPT ===================================================================================== 
