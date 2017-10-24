

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_KLBAD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_KLBAD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_KLBAD ("REF", "DK", "PKK_SOS", "ACC", "NLS", "KV", "NMS", "RNK", "TT", "S", "VDAT", "NAZN", "BRANCH", "OPER_SOS", "FLAG_AD") AS 
  select q.ref, q.dk, q.sos,
       q.acc, a.nls, a.kv, a.nms, a.rnk,
       o.tt, decode(q.dk,o.dk,nvl(o.s2,o.s),o.s)/100 s, o.vdat, o.nazn, o.branch, o.sos,
       decode(w.value,'PAYACCAD',1,0) flag_ad
  from ow_pkk_que q, accounts a, oper o, operw w
 where q.acc = a.acc
   and q.ref = o.ref and o.tt like 'KL%'
   and o.sos > 0
   and o.ref = w.ref(+) and w.tag(+) = 'W4MSG'
   and q.sos = 0 and q.f_n is null;

PROMPT *** Create  grants  V_OW_KLBAD ***
grant SELECT                                                                 on V_OW_KLBAD      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_KLBAD      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_KLBAD.sql =========*** End *** ===
PROMPT ===================================================================================== 
