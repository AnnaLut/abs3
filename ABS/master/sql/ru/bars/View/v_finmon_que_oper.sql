

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE_OPER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FINMON_QUE_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FINMON_QUE_OPER ("ID", "REF", "REC", "DK", "TT", "ND", "DATD", "PDAT", "USERID", "SK", "NLSA", "S", "MFOA", "NAM_A", "NLSB", "S2", "MFOB", "NAM_B", "VDAT", "NAZN", "SOS", "ID_A", "ID_B", "KV", "KV2", "STATUS", "STATUS_NAME", "OPR_VID1", "OPR_VID2", "COMM_VID2", "OPR_VID3", "COMM_VID3", "MONITOR_MODE", "AGENT_ID", "IN_DATE", "RNK_A", "RNK_B", "LCV", "DIG", "LCV2", "DIG2", "FIO", "OTM", "TOBO", "COMMENTS", "NMKA", "NMKB") AS 
  select f.id, o.ref, null rec, o.dk, o.tt, o.nd, o.datd, o.pdat, o.userid, o.sk,
       o.nlsa, o.s,  o.mfoa, o.nam_a,
       o.nlsb, o.s2, o.mfob, o.nam_b,
       o.vdat, o.nazn, o.sos, o.id_a, o.id_b,
       o.kv, o.kv2, upper(f.status) status,
       nvl2(f.status, (select name from finmon_que_status where status = f.status), null) status_name,
       f.opr_vid1, f.opr_vid2, f.comm_vid2,
       f.opr_vid3, f.comm_vid3, f.monitor_mode,
       f.agent_id, f.in_date, f.rnk_a, f.rnk_b,
       t.lcv, t.dig, t2.lcv, t2.dig, s.fio, q.otm, o.tobo, f.comments,
       decode(o.mfoa,o.kf,(select c.nmk from accounts n, customer c where o.nlsa = n.nls and o.kv = n.kv and n.rnk = c.rnk), o.nam_a) nmka,
       decode(o.mfob,o.kf,(select c.nmk from accounts n, customer c where o.nlsb = n.nls and nvl(o.kv2,o.kv) = n.kv and n.rnk = c.rnk), o.nam_b) nmkb
  from oper o, tabval t, tabval t2, finmon_que f, fm_ref_que q, staff s
 where o.kv  = t.kv and nvl(o.kv2,o.kv) = t2.kv
   and o.ref = f.ref(+) and f.agent_id = s.id(+)
   and o.ref = q.ref(+)
   and ( o.branch like sys_context ('bars_context', 'user_branch_mask')
      or o.mfoa = f_ourmfo and exists (select 1 from accounts where nls = o.nlsa and kv = o.kv and branch like sys_context ('bars_context', 'user_branch_mask'))
      or o.mfob = f_ourmfo and exists (select 1 from accounts where nls = o.nlsb and kv = nvl(o.kv2,o.kv) and branch like sys_context ('bars_context', 'user_branch_mask')) ) ;

PROMPT *** Create  grants  V_FINMON_QUE_OPER ***
grant SELECT                                                                 on V_FINMON_QUE_OPER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FINMON_QUE_OPER to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FINMON_QUE_OPER.sql =========*** End 
PROMPT ===================================================================================== 
