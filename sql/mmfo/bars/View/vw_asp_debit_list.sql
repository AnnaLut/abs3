

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ASP_DEBIT_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ASP_DEBIT_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ASP_DEBIT_LIST ("ACC", "TIP", "KV", "NLS", "NMS", "OSTB", "OSTC", "ND") AS 
  select ACC, TIP, KV, NLS, NMS, OSTB, OSTC,nd
  from (SELECT a.acc,
               a.tip,
               a.kv,
               a.nls,
               a.nms,
               (a.lim + a.ostb) / 100 as ostb,
               (a.lim + a.ostc) / 100 as ostc,
               n.nd
          FROM accounts a, nd_acc n
         WHERE a.nbs < '4'
           AND a.tip IN ('SG', 'ISG', 'DEP')
           and a.acc = n.acc
           and ((a.lim + a.ostb)>0 or  (a.lim + a.ostc) >0))
;

PROMPT *** Create  grants  VW_ASP_DEBIT_LIST ***
grant SELECT                                                                 on VW_ASP_DEBIT_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ASP_DEBIT_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ASP_DEBIT_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ASP_DEBIT_LIST.sql =========*** End 
PROMPT ===================================================================================== 
