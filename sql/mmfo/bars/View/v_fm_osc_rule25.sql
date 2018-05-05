

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE25.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE25 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE25 ("REF", "VDAT") AS 
  SELECT o.REF, o.vdat
     FROM oper o,
          opldok p,
          accounts a,
          customer c,
          customer_risk r
    WHERE     o.REF = p.REF
          AND p.acc = a.acc
          AND (   a.nbs IN ('2620','2522','2625','2630','2635', '2638')
               OR a.nbs LIKE '22%'
			   OR (a.nbs = '2600' 
				   and c.custtype = 3 
				   and C.ise in ('14100', '14200', '14101','14201') 
				   and C.sed ='91'))
          AND a.rnk = c.rnk
          AND c.rnk = r.rnk
          AND r.risk_id = 2
          AND r.dat_end IS NULL
          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >= 15000000
  union
  select o.ref, o.vdat
    from oper o
    join operw ow on o.ref = ow.ref and o.kf = ow.kf and ow.tag = 'POKPO'
    join customer c on ow.value = c.okpo and c.kf = ow.kf
    join customer_risk r on r.rnk = c.rnk and r.dat_end is null
   where gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 
     and substr(o.nlsa,1,4) = '2902'
     and r.risk_id = 2
;

PROMPT *** Create  grants  V_FM_OSC_RULE25 ***
grant SELECT                                                                 on V_FM_OSC_RULE25 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE25 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE25.sql =========*** End **
PROMPT ===================================================================================== 
