

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ASP_CREDIT_LIST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ASP_CREDIT_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ASP_CREDIT_LIST ("DPLAN", "FDAT", "NPP", "ACC", "TIP", "KV", "NLS", "NMS", "OSTB", "OSTC", "ND") AS 
  SELECT DPLAN,FDAT,NPP,ACC,TIP,KV,NLS,NMS, OSTB , OSTC,ND
  FROM (SELECT to_date(null) dplan,
                to_date(null) FDAT,
                to_number(null) npp,
                a.acc,
                a.tip,
                a.kv,
                a.nls,
                a.nms,
                a.ostb / 100 ostb,
                a.ostc / 100 ostc,
                d.nd
           FROM accounts a, nd_acc n, cc_deal d
          WHERE /*n.nd = :nd
                               and */
          a.acc = n.acc
       and d.nd = n.nd
       and d.rnk = a.rnk
       and (a.nbs < '4' and a.ostb < 0 or a.tip in ('ISG', 'SDI', 'SN8'))
       and not exists (select 1 from cc_trans where acc = a.acc)
         union all
         SELECT t.d_plan,
                t.FDAT,
                to_number(null) npp,
                a.acc,
                a.tip,
                a.kv,
                a.nls,
                a.nms,
                a.ostb / 100 ostb,
                - (t.sv - t.sz) / 100 ostc,
                d.nd
           FROM accounts a, nd_acc n, cc_trans t, cc_deal d
          WHERE /*n.nd = :nd
                               and */
          a.acc = n.acc
       and d.nd = n.nd
       and d.rnk = a.rnk
       and (a.nbs < '4' and a.ostb < 0)
       and a.acc = t.acc
       and t.d_fakt is null
         union all
         SELECT to_date(null),
                to_date(null),
                to_number(null) npp,
                a.acc,
                a.tip,
                a.kv,
                a.nls,
                a.nms,
                a.ostb / 100 ostb,
                (a.ostc / 100 + ct.ss / 100) ostc,
                d.nd
           FROM accounts a,
                nd_acc n,
                cc_deal d,
                (select acc, sum(sv - sz) ss
                   from cc_trans
                  where d_fakt is null
                  group by acc) ct
          WHERE /*n.nd = :nd
                               and*/
          a.acc = n.acc
       and d.nd = n.nd
       and d.rnk = a.rnk
       and exists (select 1 from cc_trans where acc = a.acc)
       and a.acc = ct.acc
       and (a.ostc / 100 + ct.ss / 100) > 0)
;

PROMPT *** Create  grants  VW_ASP_CREDIT_LIST ***
grant SELECT                                                                 on VW_ASP_CREDIT_LIST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ASP_CREDIT_LIST.sql =========*** End
PROMPT ===================================================================================== 
