

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_PKKQUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_PKKQUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_PKKQUE ("DOC_TYPE", "STATUS", "CARD_ACCT", "F_N", "F_D", "REF", "TT", "VDAT", "DATD", "DK", "CARD_NLS", "S", "KV", "LCV", "CARD_NMS", "NLSB", "NAMB", "NAZN", "USERID", "SOS") AS 
  select 1, decode(q.sos, 0, 'Í', 1, 'Î', '') status, w.value, q.f_n, q.f_d,
       o.ref, o.tt, o.vdat, o.datd, q.dk,
       a.nls, o.s, a.kv, decode(a.kv,980,'UAH',840,'USD',null) lcv, a.nms,
       decode(o.nlsa, a.nls, o.nlsb, o.nlsa),
       decode(o.nlsa, a.nls, o.nam_b, o.nam_a),
       o.nazn, o.userid, o.sos
  from pkk_que q, oper o, operw w, accounts a
 where q.ref = o.ref
   and q.dk = 1
   and o.ref = w.ref(+) and w.tag(+) = 'CDAC'
   and q.acc = a.acc
   union all
select 1, decode(q.sos, 0, 'Í', 1, 'Î', '') status, w.value, q.f_n, q.f_d,
       o.ref, o.tt, o.vdat, o.datd, q.dk,
       a.nls, o.s, a.kv, decode(a.kv,980,'UAH',840,'USD',null) lcv, a.nms,
       decode(o.nlsa, a.nls, o.nlsb, o.nlsa),
       decode(o.nlsa, a.nls, o.nam_b, o.nam_a),
       o.nazn, o.userid, o.sos
  from pkk_que q, oper o, operw w, accounts a
 where q.ref = o.ref
   and q.dk = 0
   and o.ref = w.ref(+) and w.tag(+) = 'CDAC2'
   and q.acc = a.acc
 union all
select 2, 'Í' status, null, null, null,
       o.rec, null tt, o.datp, o.datd, o.dk,
       q.nls, o.s, o.kv, decode(o.kv,980,'UAH',840,'USD',null), o.nam_b nms,
       o.nlsb, o.nlsa, o.nazn, null, o.sos
  from pkk_inf q, arc_rrp o
 where q.rec = o.rec
 union all
select 2, 'Î' status, q.card_acct, q.f_n, q.f_d,
       o.rec, null tt, o.datp, o.datd, o.dk,
       q.nls, o.s, o.kv, decode(o.kv,980,'UAH',840,'USD',null), o.nam_b nms,
       o.nlsb, o.nlsa, o.nazn, null, o.sos
  from pkk_inf_history q, arc_rrp o
 where q.rec = o.rec ;

PROMPT *** Create  grants  V_OBPC_PKKQUE ***
grant SELECT                                                                 on V_OBPC_PKKQUE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBPC_PKKQUE   to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_PKKQUE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_PKKQUE.sql =========*** End *** 
PROMPT ===================================================================================== 
