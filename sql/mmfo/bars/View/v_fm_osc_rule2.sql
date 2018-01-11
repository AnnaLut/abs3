

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE2 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o
    WHERE     (       SUBSTR (o.nlsa, 1, 4) IN ('1001', '1002', '1005') AND o.mfoa = f_ourmfo
                  AND SUBSTR (o.nlsb, 1, 2) IN ('20','21','22','25','26','28','29','37')
               OR     SUBSTR (o.nlsb, 1, 4) IN ('1001', '1002', '1005') AND o.mfob = f_ourmfo
                  AND SUBSTR (o.nlsa, 1, 2) IN ('20','21','22','25','26','28','29','37')
               OR     SUBSTR (o.nlsa, 1, 4) IN ('2902', '2909') AND o.dk = 1 AND o.mfoa = f_ourmfo
                  AND SUBSTR (o.nlsb, 1, 2) IN ('20','21','22','25','26','28','29','37')
               OR     SUBSTR (o.nlsb, 1, 4) IN ('2902', '2909') AND o.dk = 0 AND o.mfob = f_ourmfo
                  AND SUBSTR (o.nlsa, 1, 2) IN ('20','21','22','25','26','28','29','37')

               OR     SUBSTR (o.nlsa, 1, 4) IN ('2924')
                  AND SUBSTR (o.nlsb, 1, 4) IN ('2924')
                  AND (UPPER(TRIM(o.NAZN)) like '%ÏÎÏÎÂÍÅÍÍß%' OR UPPER(TRIM(o.NAZN)) like 'ÂÈÄÀ×À ÃÎÒ²ÂÊÈ:%' OR UPPER(TRIM(o.NAZN)) like '%ÇÀÐÀÕÓÂÀÍÍß%')

               OR     SUBSTR (o.nlsb, 1, 4) IN ('2924')
                  AND SUBSTR (o.nlsa, 1, 4) IN ('2625')
                  AND UPPER(TRIM(o.NAZN)) like '%ÂÈÄÀ×%'

               OR     SUBSTR (o.nlsa, 1, 4) IN ('2924')
                  AND SUBSTR (o.nlsb, 1, 4) IN ('2625')

               OR o.TT in ('040','041','042','043','044','045','AA1','AA2','AA3','AA4','AA5','AA6','AA7','AA8','AA9', 'PKK' ))

          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=
                 15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE2 ***
grant SELECT                                                                 on V_FM_OSC_RULE2  to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE2  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE2  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE2  to START1;
grant SELECT                                                                 on V_FM_OSC_RULE2  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE2.sql =========*** End ***
PROMPT ===================================================================================== 
