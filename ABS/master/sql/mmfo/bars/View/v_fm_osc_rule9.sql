

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE9.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE9 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE9 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
  FROM oper o
  WHERE     (       o.dk = 0                           -- Ä 2600, 2620, 2625
  AND SUBSTR (o.nlsb, 1, 4) IN ('2600', '2620', '2625') -- Ê 2650, 2655, 3739, 2902
  AND SUBSTR (o.nlsa, 1, 4) IN ('2650', '2655', '3739', '2902')
  OR     o.dk = 1                           -- Ä 2600, 2620, 2625, 2902
  AND SUBSTR (o.nlsa, 1, 4) IN ('2600', '2620', '2625', '2902') -- Ê 2650, 2655, 3739
  AND SUBSTR (o.nlsb, 1, 4) IN ('2650', '2655', '3739'))
  AND (
		regexp_like(upper(o.nazn), '(^|.)(ÑÒÐÀÕ|ÏÅÐÅÑÒÐÀÕ)')
		)
  AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=  15000000
  ;

PROMPT *** Create  grants  V_FM_OSC_RULE9 ***
grant SELECT                                                                 on V_FM_OSC_RULE9  to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE9  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE9  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE9  to START1;
grant SELECT                                                                 on V_FM_OSC_RULE9  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE9.sql =========*** End ***
PROMPT ===================================================================================== 
