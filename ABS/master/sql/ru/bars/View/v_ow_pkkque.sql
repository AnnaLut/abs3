

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_PKKQUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_PKKQUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_PKKQUE ("REF", "DK", "PKK_SOS", "F_N", "F_D", "ACC", "NLS", "KV", "NMS", "RNK", "TT", "S", "VDAT", "NAZN", "BRANCH", "OPER_SOS", "RESP_CLASS", "RESP_CODE", "RESP_TEXT", "UNFORM_FLAG", "UNFORM_USER", "UNFORM_FIO", "UNFORM_DATE") AS 
  select q.ref, q.dk, q.sos, q.f_n, f.file_date,
       q.acc, a.nls, a.kv, a.nms, a.rnk,
       o.tt, decode(q.dk,o.dk,nvl(o.s2,o.s),o.s)/100 s, o.vdat, o.nazn, o.branch, o.sos,
       q.resp_class, q.resp_code, q.resp_text,
       q.unform_flag, q.unform_user, s.fio, q.unform_date
  from ow_pkk_que q, accounts a, oper o, ow_iicfiles f, staff$base s
 where q.acc = a.acc
   and q.ref = o.ref
   and upper(q.f_n) = upper(f.file_name(+))
   and q.unform_user = s.id(+)
   and o.sos > 0
 union all
-- документы, инициированные третьей системой
select q.ref_tr ref, t.dk, 1 sos, null f_n, q.date_tr file_date,
       a.acc, a.nls, a.kv, a.nms, a.rnk,
       o.tt, q.sum_tr/100 s, o.vdat, o.nazn, o.branch, o.sos,
       null resp_class, null resp_code, null resp_text,
       null unform_flag, null unform_user, null fio, null unform_date
  from mway_match q, accounts a, oper o, ow_match_tt t, tabval$global v
 where q.nls_tr = a.nls
   and q.lcv_tr = v.lcv and v.kv = a.kv
   and q.ref_tr = o.ref
   and o.tt = t.tt
   and q.state = 0
   and o.sos > 0;

PROMPT *** Create  grants  V_OW_PKKQUE ***
grant SELECT                                                                 on V_OW_PKKQUE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_PKKQUE     to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_PKKQUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
