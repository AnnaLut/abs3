

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE_WEB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINMON_QUE_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINMON_QUE_WEB ("ID", "REF", "REC", "DK", "TT", "ND", "DATD", "PDAT", "USERID", "SK", "NLSA", "S", "MFOA", "NAM_A", "NLSB", "S2", "MFOB", "NAM_B", "VDAT", "NAZN", "SOS", "ID_A", "ID_B", "KV", "KV2", "STATUS", "STATUS_NAME", "LCV", "DIG", "LCV2", "DIG2", "TOBO", "COMMENTS") AS 
  select f.id, a.ref, null rec, a.dk, a.tt, a.nd,
       a.datd, a.pdat, a.userid, a.sk,
       a.nlsa, a.s/power(10,t.dig) s, a.mfoa, a.nam_a,
       a.nlsb, a.s/power(10,t2.dig) s2, a.mfob, a.nam_b,
       a.vdat, a.nazn, a.sos, a.id_a, a.id_b,
       a.kv, a.kv2, nvl(upper(f.status),'-') status, s.name status_name,
       t.lcv, t.dig, t2.lcv lcv2, t2.dig dig2,
       a.tobo, f.comments
  from oper a, tabval$global t, tabval$global t2, finmon_que f, finmon_que_status s
 where a.sos > 0
   and a.kv  = t.kv and nvl(a.kv2,a.kv) = t2.kv
   and a.ref = f.ref(+)
   and f.status = s.status(+)
   and a.userid = user_id;

PROMPT *** Create  grants  V_FINMON_QUE_WEB ***
grant SELECT                                                                 on V_FINMON_QUE_WEB to BARSREADER_ROLE;
grant SELECT                                                                 on V_FINMON_QUE_WEB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FINMON_QUE_WEB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE_WEB.sql =========*** End *
PROMPT ===================================================================================== 
