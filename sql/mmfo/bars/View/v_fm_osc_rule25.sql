

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE25.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE25 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE25 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o,
          opldok p,
          accounts a,
          customer c,
          customer_risk r
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND (   a.nbs IN ('2620','2522','2625','2630','2635', '2638')
               OR a.nbs LIKE '22%')
          AND a.rnk = c.rnk
          AND c.rnk = r.rnk
          AND r.risk_id = 2
          AND r.dat_end IS NULL
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >= 15000000
;

PROMPT *** Create  grants  V_FM_OSC_RULE25 ***
grant SELECT                                                                 on V_FM_OSC_RULE25 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE25 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE25.sql =========*** End **
PROMPT ===================================================================================== 
