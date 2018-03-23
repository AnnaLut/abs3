

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE22.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE22 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE22 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o
 where ( (substr(o.nlsa,1,4) in ('1001', '1002', '1005') and o.mfoa = f_ourmfo
     and (substr(o.nlsb,1,2) in ('20', '21', '22', '25', '26', '28', '29', '37') or o.mfob <> f_ourmfo))
      or (substr(o.nlsb,1,4) in ('1001', '1002', '1005') and o.mfob = f_ourmfo
     and (substr(o.nlsa,1,2) in ('20', '21', '22', '25', '26', '28', '29', '37') or o.mfoa <> f_ourmfo))
      or (substr(o.nlsa,1,4) in ('2902', '2909') and o.dk = 1 and o.mfoa = f_ourmfo
     and (substr(o.nlsb,1,2) in ('20', '21', '22', '25', '26', '28', '29', '37') or o.mfob <> f_ourmfo))
      or (substr(o.nlsb,1,4) in ('2902', '2909') and o.dk = 0 and o.mfob = f_ourmfo
     and (substr(o.nlsa,1,2) in ('20', '21', '22', '25', '26', '28', '29', '37') or o.mfoa <> f_ourmfo)))
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 10000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE22 ***
grant SELECT                                                                 on V_FM_OSC_RULE22 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE22.sql =========*** End **
PROMPT ===================================================================================== 
