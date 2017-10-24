

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_OPER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_FUNC_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_FUNC_OPER ("REF") AS 
  select ref
  from oper
 where userid = user_id
   and pdat > sysdate - 30
 union all
select o.ref
  from oper o, oper_visa v
 where o.ref = v.ref
   and v.userid = user_id
   and o.pdat > sysdate - 30
 union all
select o.ref
  from oper o, accounts a
 where o.mfoa <> f_ourmfo
   and o.nlsa = a.nls and o.kv2 = a.kv
   and a.isp = user_id
   and o.pdat > sysdate - 30;

PROMPT *** Create  grants  V_FM_FUNC_OPER ***
grant SELECT                                                                 on V_FM_FUNC_OPER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_FUNC_OPER  to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_OPER.sql =========*** End ***
PROMPT ===================================================================================== 
