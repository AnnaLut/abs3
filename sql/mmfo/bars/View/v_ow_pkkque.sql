

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_PKKQUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_PKKQUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_PKKQUE ("REF", "DK", "PKK_SOS", "F_N", "F_D", "ACC", "NLS", "KV", "NMS", "RNK", "TT", "S", "VDAT", "NAZN", "BRANCH", "OPER_SOS", "RESP_CLASS", "RESP_CODE", "RESP_TEXT", "UNFORM_FLAG", "UNFORM_USER", "UNFORM_FIO", "UNFORM_DATE") AS 
  SELECT q.REF,
          q.dk,
          q.sos,
          q.f_n,
          f.file_date,
          q.acc,
          a.nls,
          a.kv,
          a.nms,
          a.rnk,
          o.tt,
          DECODE (q.dk, o.dk, NVL (o.s2, o.s), o.s) / 100 s,
          o.vdat,
          o.nazn,
          o.branch,
          o.sos,
          q.resp_class,
          q.resp_code,
          q.resp_text,
          q.unform_flag,
          q.unform_user,
          s.fio,
          q.unform_date
     FROM ow_pkk_que q,
          accounts a,
          oper o,
          ow_iicfiles f,
          staff$base s
    WHERE     q.acc = a.acc
          AND q.REF = o.REF
          AND UPPER (q.f_n) = UPPER (f.file_name(+))
          AND q.unform_user = s.id(+)
          AND o.sos > 0
   UNION ALL
   -- документы, инициированные третьей системой
   SELECT q.ref_tr REF,
          t.dk,
          1 sos,
          NULL f_n,
          q.date_tr file_date,
          a.acc,
          a.nls,
          a.kv,
          a.nms,
          a.rnk,
          o.tt,
          q.sum_tr / 100 s,
          o.vdat,
          o.nazn,
          o.branch,
          o.sos,
          NULL resp_class,
          NULL resp_code,
          NULL resp_text,
          NULL unform_flag,
          NULL unform_user,
          NULL fio,
          NULL unform_date
     FROM mway_match q,
          accounts a,
          oper o,
          ow_match_tt t,
          tabval$global v
    WHERE     q.nls_tr = a.nls
          AND q.lcv_tr = v.lcv
          AND v.kv = a.kv
          AND q.ref_tr = o.REF
          AND o.tt = t.tt
          AND q.state = 0
          AND o.sos > 0;

PROMPT *** Create  grants  V_OW_PKKQUE ***
grant SELECT                                                                 on V_OW_PKKQUE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_PKKQUE     to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_PKKQUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
