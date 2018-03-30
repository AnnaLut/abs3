

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE5.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE5 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE5 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o, opldok p, accounts a
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND SUBSTR (DECODE (o.dk, 0, o.nlsb, o.nlsa), 1, 4) IN ('1001',
                                                                  '1002',
                                                                  '1005')
          AND o.mfoa = gl.kf
           AND p.dk = 1
          AND (   a.nls LIKE '20%'
               OR a.nls LIKE '21%'
               OR a.nls LIKE '22%'
               OR a.nls LIKE '25%'
               OR a.nls LIKE '26%'
               OR a.nls LIKE '28%'
               OR a.nls LIKE '29%'
               OR a.nls LIKE '37%'
			   or DECODE (o.dk, 0, o.mfoa, o.mfob) <> f_ourmfo)
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE5 ***
grant SELECT                                                                 on BARS.V_FM_OSC_RULE5  to BARSREADER_ROLE;
grant SELECT                                                                 on BARS.V_FM_OSC_RULE5  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARS.V_FM_OSC_RULE5  to FINMON01;
grant SELECT                                                                 on BARS.V_FM_OSC_RULE5  to START1;
grant SELECT                                                                 on BARS.V_FM_OSC_RULE5  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE5.sql =========*** End ***
PROMPT ===================================================================================== 
