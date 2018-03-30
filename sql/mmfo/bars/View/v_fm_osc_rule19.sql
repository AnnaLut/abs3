

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE19.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE19 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE19 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, accounts a, customer c
 where decode(o.dk,1,o.nlsb,o.nlsa) like '37391192%' and decode(o.dk,1,nvl(o.kv2,o.kv),o.kv) <> 980
   and decode(o.dk,1,o.nlsa,o.nlsb) = a.nls
   and decode(o.dk,1,o.kv,nvl(o.kv2,o.kv)) = a.kv
   and a.rnk = c.rnk
   and ( c.custtype = 2 or c.custtype = 3 and nvl(trim(c.sed),'00') = '91' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE19 ***
grant SELECT                                                                 on V_FM_OSC_RULE19 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE19 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE19 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE19 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE19.sql =========*** End **
PROMPT ===================================================================================== 
