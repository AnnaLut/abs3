

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE17.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE17 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE17 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o,
          opldok p,
          accounts a,
          customer c,
          country r,
          customer_address d,
          country r2,
          (SELECT w.REF, k.k040 country
             FROM operw w, kl_k040 k
            WHERE     (   w.tag = '59'   AND SUBSTR (w.VALUE, 1, 1) = '/'
                       OR w.tag = '57A'  AND LENGTH (w.VALUE) = 6
                       OR w.tag = '50F'  AND w.VALUE LIKE '%' || CHR (13) || CHR (10) || '3/%'
                       OR w.tag = 'KOD_G'
                       OR w.tag = 'D6#70' AND w.tag is not null
                       OR w.tag = 'n'     AND w.tag is not null)
                    AND DECODE (
                         TRIM (w.tag),
                         '59',  SUBSTR (w.VALUE, 2, 2),
                         '57A', SUBSTR (w.VALUE, 5, 2),
                         '50F', SUBSTR (w.VALUE, INSTR (w.VALUE, CHR (13) || CHR (10) || '3/') + 4, 2),
                         'KOD_G', w.VALUE,
                         'D6#70', SUBSTR (TRIM (w.VALUE), -3, 3),
                         'n',     SUBSTR (TRIM (w.VALUE), -3, 3)) =
                                                                DECODE (TRIM (w.tag),
                                                                         '59', k.a2,
                                                                         '57A', k.a2,
                                                                         '50F', k.a2,
                                                                         'KOD_G', k.k040,
                                                                         'D6#70', k.k040,
                                                                          'n',   k.k040)) w,
          country r3
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND a.rnk = c.rnk
          AND c.country = r.country
          AND c.rnk = d.rnk(+)
          AND d.country = r2.country(+)
          AND o.REF = w.REF(+)
          AND w.country = r3.country(+)
          AND (r.fatf = 1 OR r2.fatf = 1 OR r3.fatf = 1)
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=  15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE17 ***
grant SELECT                                                                 on V_FM_OSC_RULE17 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE17 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE17.sql =========*** End **
PROMPT ===================================================================================== 
