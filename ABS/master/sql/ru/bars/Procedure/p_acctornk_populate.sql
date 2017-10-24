

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ACCTORNK_POPULATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ACCTORNK_POPULATE ***

  CREATE OR REPLACE PROCEDURE BARS.P_ACCTORNK_POPULATE (p_rnk number)
is
begin
  delete from tmp_acctornk;
  insert into tmp_acctornk (acc, branch, nls, kv, nms, daos, rnk, nmk, new_rnk )
  select a.acc, a.branch, a.nls, a.kv, a.nms, a.daos, a.rnk, c.nmk, null
    from accounts a, customer c
   where a.rnk = c.rnk
     and a.dazs is null
     and c.rnk = p_rnk;
end p_acctornk_populate;
/
show err;

PROMPT *** Create  grants  P_ACCTORNK_POPULATE ***
grant EXECUTE                                                                on P_ACCTORNK_POPULATE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ACCTORNK_POPULATE to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ACCTORNK_POPULATE.sql =========*
PROMPT ===================================================================================== 
