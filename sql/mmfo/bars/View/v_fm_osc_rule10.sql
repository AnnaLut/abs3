

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE10.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE10 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE10 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o, opldok p, accounts a
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          -- Ê 2600, 2620, 2625, 2650, 2655, 2909, 3720
          AND p.dk = 1
          AND a.nbs IN ('2600',
                        '2620',
                        '2625',
                        '2650',
                        '2655',
                        '2909',
                        '3720')
          AND (
                regexp_like(upper(o.nazn), '(^|.)(ÑÒÐÀÕ|ÏÅÐÅÑÒÐÀÕ)')
               )
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=
                 15000000
;

PROMPT *** Create  grants  V_FM_OSC_RULE10 ***
grant SELECT                                                                 on V_FM_OSC_RULE10 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE10 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE10 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE10 to START1;
grant SELECT                                                                 on V_FM_OSC_RULE10 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE10.sql =========*** End **
PROMPT ===================================================================================== 
