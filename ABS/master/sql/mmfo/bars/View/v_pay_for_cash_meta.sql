

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_FOR_CASH_META.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_FOR_CASH_META ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_FOR_CASH_META ("KV", "NLS", "NMS", "OSTC", "OSTB", "ACC", "KOL", "S") AS 
  select a.kv,
          a.nls,
          a.nms,
          a.ostc / 100 ostc,
          a.ostb / 100 ostb,
          a.acc,
          b.kol,
          b.s
     from v_gl a,
          (  select r.acc, count (*) kol, sum (o.s) / 100 s
               from nlk_ref r, opldok o
              where     o.ref = r.ref1
                    and o.sos = 5
                    and o.dk = 1
                    and o.acc =
                           (case when r.ref2 is null then r.acc else null end)
           group by r.acc) b
    where     a.acc = b.acc
          and a.tip = 'NL$'
          and (a.ostc <> 0 or a.ostb <> 0 or b.s <> 0);

PROMPT *** Create  grants  V_PAY_FOR_CASH_META ***
grant SELECT                                                                 on V_PAY_FOR_CASH_META to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY_FOR_CASH_META to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_FOR_CASH_META to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_FOR_CASH_META.sql =========*** En
PROMPT ===================================================================================== 
