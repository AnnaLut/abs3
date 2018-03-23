

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE6.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE6 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE6 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o, opldok p, accounts a
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND SUBSTR (DECODE (o.dk, 1, o.nlsb, o.nlsa), 1, 4) IN ('1001',
                                                                  '1002')
          AND p.dk = 0
          AND (   a.nls LIKE '20%'
               OR a.nls LIKE '21%'
               OR a.nls LIKE '22%'
               OR a.nls LIKE '25%'
               OR a.nls LIKE '26%'
               OR a.nls LIKE '28%'
               OR a.nls LIKE '29%'
               OR a.nls LIKE '37%'
			   OR DECODE (o.dk, 1, o.mfoa, o.mfob) <> f_ourmfo)
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE6 ***
grant SELECT                                                                 on V_FM_OSC_RULE6  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE6  to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE6.sql =========*** End ***
PROMPT ===================================================================================== 
