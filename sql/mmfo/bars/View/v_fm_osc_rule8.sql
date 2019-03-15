

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE8.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE8 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE8 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o,
          opldok p,
          accounts a,
          customer c
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND a.rnk = c.rnk
          AND c.custtype = 2
          AND a.nbs IN ('2650', '2655')
          AND (   NVL (TRIM (c.ved), '00000') IN ('66010', '66020', '66030')
               OR regexp_like(upper(o.nazn), '(^|.)(ÑÒÐÀÕ|ÏÅÐÅÑÒÐÀÕ)')
    )
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=
                 15000000
;

PROMPT *** Create  grants  V_FM_OSC_RULE8 ***
grant SELECT                                                                 on V_FM_OSC_RULE8  to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE8  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE8  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE8  to START1;
grant SELECT                                                                 on V_FM_OSC_RULE8  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE8.sql =========*** End ***
PROMPT ===================================================================================== 
