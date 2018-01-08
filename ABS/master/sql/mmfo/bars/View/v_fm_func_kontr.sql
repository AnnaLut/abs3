

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_KONTR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_FUNC_KONTR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_FUNC_KONTR ("REF") AS 
  SELECT REF
     FROM oper
    WHERE branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
   and pdat > bankdate - 14
   UNION ALL
   SELECT o.REF
     FROM oper o, accounts a
    WHERE     o.mfoa <> f_ourmfo
          AND o.nlsa = a.nls
          AND o.kv2 = a.kv
          AND a.isp = user_id
  and o.pdat > bankdate - 14
;

PROMPT *** Create  grants  V_FM_FUNC_KONTR ***
grant SELECT                                                                 on V_FM_FUNC_KONTR to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_FUNC_KONTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_FUNC_KONTR to FINMON01;
grant SELECT                                                                 on V_FM_FUNC_KONTR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_FUNC_KONTR.sql =========*** End **
PROMPT ===================================================================================== 
