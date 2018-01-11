

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINMON_QUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINMON_QUE ("ID", "REF", "REC", "DK", "TT", "ND", "DATD", "PDAT", "USERID", "SK", "NLSA", "S", "MFOA", "NAM_A", "NLSB", "S2", "MFOB", "NAM_B", "VDAT", "NAZN", "SOS", "ID_A", "ID_B", "KV", "KV2", "STATUS", "OPR_VID1", "OPR_VID2", "COMM_VID2", "OPR_VID3", "COMM_VID3", "MONITOR_MODE", "AGENT_ID", "IN_DATE", "RNK_A", "RNK_B", "BLK", "LCV", "DIG", "LCV2", "DIG2", "FIO", "OTM", "TOBO", "COMMENTS", "NMKA", "NMKB") AS 
  select f.id, a.ref, null rec, a.dk, a.tt, a.nd, a.datd, a.pdat, a.userid, a.sk,
       a.nlsa, a.s,  a.mfoa, a.nam_a,
       a.nlsb, a.s2, a.mfob, a.nam_b,
       a.vdat, a.nazn, a.sos, a.id_a, a.id_b,
       a.kv, a.kv2, upper(f.status) status,
       f.opr_vid1, f.opr_vid2, f.comm_vid2,
       f.opr_vid3, f.comm_vid3, f.monitor_mode,
       f.agent_id, f.in_date, f.rnk_a, f.rnk_b, 0 blk,
       t.lcv, t.dig, t2.lcv, t2.dig, s.fio, q.otm, a.tobo, f.comments,
       decode(a.mfoa,a.kf,(select c.nmk from accounts n, customer c where a.nlsa = n.nls and a.kv = n.kv and n.rnk = c.rnk), a.nam_a) nmka,
       decode(a.mfob,a.kf,(select c.nmk from accounts n, customer c where a.nlsb = n.nls and nvl(a.kv2,a.kv) = n.kv and n.rnk = c.rnk), a.nam_b) nmkb
  from oper a, tabval t, tabval t2, finmon_que f, fm_ref_que q, staff s
 where a.kv  = t.kv and nvl(a.kv2,a.kv) = t2.kv
   and a.ref = f.ref(+) and f.agent_id = s.id(+)
   and a.ref = q.ref(+)
union all
-- входящие
select f.id, a.ref, a.rec, a.dk, null, a.nd, a.datd, a.dat_a, null, null,
       a.nlsa, a.s, a.mfoa, a.nam_a,
       a.nlsb, a.s, a.mfob, a.nam_b,
       a.dat_a, a.nazn, a.sos, a.id_a, a.id_b,
       a.kv, a.kv, upper(f.status),
       f.opr_vid1, f.opr_vid2, f.comm_vid2,
       f.opr_vid3, f.comm_vid3, f.monitor_mode,
       f.agent_id, f.in_date, f.rnk_a, f.rnk_b, a.blk,
       t.lcv, t.dig, t.lcv, t.dig, s.fio, q.otm, null, f.comments, a.nam_a, a.nam_b
  from arc_rrp a, tabval t, finmon_que f, fm_rec_que q, staff s
 where a.ref is null and a.s <> 0
   and a.kv  = t.kv
   and a.rec = f.rec(+) and f.agent_id = s.id(+)
   and a.rec = q.rec(+);

PROMPT *** Create  grants  V_FINMON_QUE ***
grant SELECT                                                                 on V_FINMON_QUE    to BARSREADER_ROLE;
grant SELECT                                                                 on V_FINMON_QUE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FINMON_QUE    to FINMON01;
grant SELECT                                                                 on V_FINMON_QUE    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FINMON_QUE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE.sql =========*** End *** =
PROMPT ===================================================================================== 
