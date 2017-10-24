

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE15.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE15 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE15 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o, opldok p, accounts a
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND a.nbs IN ('2512',
                        '2513',
                        '2520',
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
                        '2561',
                        '2562',
                        '2565',
                        '2570',
                        '2571',
                        '2572',
                        '2600',
                        '2604',
                        '2605',
                        '2610',
                        '2615',
                        '2620',
                        '2625',
                        '2630',
                        '2635',
                        '2650',
                        '2651',
                        '2652',
                        '2655',
                        '2801',
                        '3320',
                        '3330',
                        '3340',
                        '1600')
          AND (   UPPER (o.nazn) LIKE '%����%'
               OR UPPER (o.nazn) LIKE '%��%'
               OR UPPER (o.nazn) LIKE '%��%'
               OR UPPER (o.nazn) LIKE '%������%������%'
               OR UPPER (o.nazn) LIKE '%ֲ�Ͳ%������%'
               OR UPPER (o.nazn) LIKE '%�����%'
               OR UPPER (o.nazn) LIKE '%��ֲ�%'
               OR UPPER (o.nazn) LIKE '%��˲��ֲ�%'
               OR UPPER (o.nazn) LIKE '%���������%'
               OR UPPER (o.nazn) LIKE '%������%'
               OR UPPER (o.nazn) LIKE '%������%')
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=
                 15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE15 ***
grant SELECT                                                                 on V_FM_OSC_RULE15 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE15 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE15.sql =========*** End **
PROMPT ===================================================================================== 
