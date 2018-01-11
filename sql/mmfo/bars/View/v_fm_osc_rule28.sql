

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE28.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE28 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE28 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o,
          opldok p,
          accounts a,
          customer c,
          customer_risk r
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND (   a.nbs IN ('2520',
                            '2523',
                            '2525',
                            '2526',
                            '2530',
                            '2541',
                            '2542',
                            '2544',
                            '2545',
                            '2546',
                            '2554',
                            '2555',
                            '2560',
                            '2570',
                            '2600',
                            '2601',
                            '2602',
                            '2603',
                            '2604',
                            '2605',
                            '2606',
                            '2610',
                            '2611',
                            '2615',
                            '2620',
                            '2622',
                            '2625',
                            '2630',
                            '2635',
                            '2640',
                            '2641',
                            '2642',
                            '2643',
                            '2650',
                            '2651',
                            '2652',
                            '2655',
                            '3739')
               OR a.nbs LIKE '20%'
               OR a.nbs LIKE '22%')
          AND a.rnk = c.rnk
          AND c.rnk = r.rnk
          AND r.risk_id IN (3, 64)
          AND r.dat_end IS NULL
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=
                 15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE28 ***
grant SELECT                                                                 on V_FM_OSC_RULE28 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE28 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE28 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE28 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE28.sql =========*** End **
PROMPT ===================================================================================== 
