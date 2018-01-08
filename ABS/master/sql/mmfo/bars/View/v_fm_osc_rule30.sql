

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE30.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE30 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE30 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o, operw w, kl_k040 k
    WHERE     o.REF = w.REF
          AND (   w.tag = '59' AND SUBSTR (w.VALUE, 1, 1) = '/'
               OR w.tag = '57A' AND LENGTH (w.VALUE) = 6
               OR     w.tag = '50F'
                AND w.VALUE LIKE '%' || CHR (13) || CHR (10) || '3/%'
                OR w.tag = 'KOD_G'
                OR w.tag = 'D6#70' AND w.tag is not null
                OR w.tag = 'n'     AND w.tag is not null)
          AND DECODE (
                 TRIM (w.tag),
                 '59', SUBSTR (w.VALUE, 2, 2),
                 '57A', SUBSTR (w.VALUE, 5, 2),
                 '50F', SUBSTR ( w.VALUE, INSTR (w.VALUE, CHR (13) || CHR (10) || '3/') + 4, 2),
                 'KOD_G', w.VALUE,
                 'D6#70', SUBSTR (TRIM (w.VALUE), -3, 3),
                 'n',     SUBSTR (TRIM (w.VALUE), -3, 3)
                                                         ) =
                                                            DECODE (TRIM (w.tag),
                                                                         '59', k.a2,
                                                                         '57A', k.a2,
                                                                         '50F', k.a2,
                                                                         'KOD_G',k.k040,
                                                                         'D6#70', k.k040,
                                                                          'n',   k.k040)
          AND (
	      SUBSTR (o.nlsa, 1, 4) IN (2560, 2570, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2610, 2611, 2615, 2620, 2622, 2625, 2630, 2635, 2640, 2641, 2642, 2643, 2650, 2651, 2652, 2655)
          OR SUBSTR (o.nlsb, 1, 4) IN (2560, 2570, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2610, 2611, 2615, 2620, 2622, 2625, 2630, 2635, 2640, 2641, 2642, 2643, 2650, 2651, 2652, 2655)
		)
          AND k.k042 = '1'
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=  2000000;

PROMPT *** Create  grants  V_FM_OSC_RULE30 ***
grant SELECT                                                                 on V_FM_OSC_RULE30 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE30 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE30 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE30.sql =========*** End **
PROMPT ===================================================================================== 
