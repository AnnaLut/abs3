

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE24.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE24 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE24 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o, opldok p, accounts a
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND p.dk = 1
          AND a.nbs IN ('2600','2620','2625','2650')
          AND (   UPPER (o.nazn) LIKE '%ÂÈÊÓÏÍÀ%'
               OR UPPER (o.nazn) LIKE '%ÂÈÊÓÏÍÎ¯%')
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >= 15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE24 ***
grant SELECT                                                                 on V_FM_OSC_RULE24 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE24 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE24.sql =========*** End **
PROMPT ===================================================================================== 
