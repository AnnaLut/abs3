

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BR_SXO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BR_SXO ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BR_SXO (PP_BRANCH VARCHAR2, p_ob22 CHAR)
as
begin

 for  k in
  (
   select b.branch, CASH_SXO.GET_SXO(b.branch)
     from branch b
    where B.DATE_CLOSED is null
      and length(branch) >= 15
      and CASH_SXO.GET_SXO(b.branch) = PP_BRANCH
	  and branch in (select branch from accounts where regexp_like(nbs,'100[12]') and dazs is null)
    order by 2, 1
  )
  loop
   OP_BR_SX1 ( k.branch ,  p_ob22 );
  end loop;

end;
/
show err;

PROMPT *** Create  grants  OP_BR_SXO ***
grant EXECUTE                                                                on OP_BR_SXO       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BR_SXO.sql =========*** End ***
PROMPT ===================================================================================== 
