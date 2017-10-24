

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_KONTR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_FUNC_KONTR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_FUNC_KONTR ("REF") AS 
  select ref
  from oper
 where branch like sys_context('bars_context', 'user_branch_mask')
   and pdat > sysdate - 30
 union all
select o.ref
  from oper o, accounts a
 where o.mfoa <> f_ourmfo
   and o.nlsa = a.nls and o.kv2 = a.kv
   and a.isp = user_id
   and o.pdat > sysdate - 30;

PROMPT *** Create  grants  V_FM_FUNC_KONTR ***
grant SELECT                                                                 on V_FM_FUNC_KONTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_FUNC_KONTR to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_KONTR.sql =========*** End **
PROMPT ===================================================================================== 
