

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE18.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE18 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE18 ("REF", "VDAT") AS 
  select R.ref, R.vdat from
(
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
          AND k.k042 = '1'
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=  15000000
    union
    select
    o.ref, o.vdat
    from bars.oper o
    left join bars.accounts accA on o.kf = accA.kf and o.nlsa = accA.nls and o.kv = accA.kv
    left join bars.accounts accB on o.kf = accB.kf and o.nlsb = accB.nls and nvl(o.kv2, o.kv) = accB.kv
    left join bars.customer custA on accA.rnk = custA.rnk
    left join bars.customer custB on accB.rnk = custB.rnk
    left join bars.kl_k040 klA on custA.country = klA.k040
    left join bars.kl_k040 klB on custB.country = klB.k040
    where (klA.k042 = 1
    or    klB.k042 = 1)
    and bars.gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000
) R;

PROMPT *** Create  grants  V_FM_OSC_RULE18 ***
grant SELECT                                                                 on V_FM_OSC_RULE18 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE18 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE18 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE18 to START1;
grant SELECT                                                                 on V_FM_OSC_RULE18 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE18.sql =========*** End **
PROMPT ===================================================================================== 
