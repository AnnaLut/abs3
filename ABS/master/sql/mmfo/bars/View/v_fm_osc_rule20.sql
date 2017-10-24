

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE20.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE20 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE20 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a, customer c, customer_risk r
 where o.ref = p.ref
   and p.acc = a.acc
   and (   a.nbs in ('2520', '2560', '2570', '2600', '2604', '2605', '2610', '2615', '2650', '2651', '2652', '2655')
        or a.nbs like '264_'
        or a.nbs = '2603' and a.kv = 980 )
   and a.rnk = c.rnk and c.custtype = 2
   and c.rnk = r.rnk
   and r.risk_id = 11 and r.dat_end is null
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE20 ***
grant SELECT                                                                 on V_FM_OSC_RULE20 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE20 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE20.sql =========*** End **
PROMPT ===================================================================================== 
