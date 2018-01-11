

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_OPER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_FUNC_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_FUNC_OPER ("REF") AS 
  SELECT REF
     FROM oper
    WHERE userid = user_id
   and pdat > bankdate - 14
   UNION ALL
   SELECT op.REF
     FROM oper op, oper_visa v
    WHERE op.REF = v.REF AND v.userid = user_id
   and op.pdat > bankdate - 14
   UNION ALL
   SELECT o.REF
     FROM oper o, accounts a
    WHERE     o.mfoa <> f_ourmfo
          AND o.nlsa = a.nls
          AND o.kv2 = a.kv
          AND a.isp = user_id
  and o.pdat > bankdate - 14
;

PROMPT *** Create  grants  V_FM_FUNC_OPER ***
grant SELECT                                                                 on V_FM_FUNC_OPER  to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_FUNC_OPER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_FUNC_OPER  to FINMON01;
grant SELECT                                                                 on V_FM_FUNC_OPER  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_OPER.sql =========*** End ***
PROMPT ===================================================================================== 
