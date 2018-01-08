

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PEREKRB_FORMULA.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PEREKRB_FORMULA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PEREKRB_FORMULA ("IDS", "KV", "NMS", "FORMULA") AS 
  SELECT distinct p.ids,
          p.kv,
          a.nms,
          p.formula
     FROM perekr_b p, accounts a, specparam s
    WHERE p.ids = a.nls AND a.acc = s.acc AND s.sps = '6' AND p.kv = a.kv;

PROMPT *** Create  grants  V_PEREKRB_FORMULA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_PEREKRB_FORMULA to ABS_ADMIN;
grant SELECT,UPDATE                                                          on V_PEREKRB_FORMULA to BARS015;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PEREKRB_FORMULA to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on V_PEREKRB_FORMULA to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PEREKRB_FORMULA.sql =========*** End 
PROMPT ===================================================================================== 
