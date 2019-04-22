
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/vw_asp_debit_list.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.VW_ASP_DEBIT_LIST ("ACC", "TIP", "KV", "NLS", "NMS", "OSTB", "OSTC", "ND") AS 
  select ACC, TIP, KV, NLS, NMS, OSTB, OSTC,nd
  from (SELECT a.acc,
               a.tip,
               a.kv,
               a.nls,
               a.nms,
               (decode(substr(a.tip,1,2),'W4',0,a.lim) + a.ostb) / 100 as ostb,
               (decode(substr(a.tip,1,2),'W4',0,a.lim) + a.ostc) / 100 as ostc,
               n.nd
          FROM accounts a, nd_acc n
         WHERE a.nbs < '4'
           AND (a.tip IN ('SG', 'ISG', 'DEP') or (a.tip like 'W4%'))
           and a.acc = n.acc
           and ((a.lim + a.ostb)>0 or  (a.lim + a.ostc) >0))
;
 show err;
 
PROMPT *** Create  grants  VW_ASP_DEBIT_LIST ***
grant SELECT                                                                 on VW_ASP_DEBIT_LIST to UPLD;
grant SELECT                                                                 on VW_ASP_DEBIT_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ASP_DEBIT_LIST to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/vw_asp_debit_list.sql =========*** End 
 PROMPT ===================================================================================== 
 