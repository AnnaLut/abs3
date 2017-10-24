

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SEP_QDOCS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SEP_QDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SEP_QDOCS ("DK", "REC", "REF", "DATD", "ND", "VOB", "MFOA", "NLSA", "KV", "S", "NLSB", "NAM_B", "NAZN", "D_REC", "FN_A", "DAT_A", "NAM_A", "ID_A", "ID_B", "DATP", "NMS", "OSTC", "LIM", "PAP", "OTM") AS 
  select
  arc_rrp.dk,   tzapros.rec, arc_rrp.ref, arc_rrp.datd,arc_rrp.nd,  arc_rrp.vob,
  arc_rrp.mfoa, arc_rrp.nlsa, arc_rrp.kv,  arc_rrp.s/100 as s,
  arc_rrp.nlsb, arc_rrp.nam_b,arc_rrp.nazn,arc_rrp.d_rec, arc_rrp.fn_a,
  arc_rrp.dat_a,arc_rrp.nam_a,arc_rrp.id_a,arc_rrp.id_b,arc_rrp.datp,
  accounts.nms, accounts.ostc/100 as ostc, accounts.lim/100 as lim, accounts.pap, tzapros.otm
 from tzapros, arc_rrp, accounts
where tzapros.rec = arc_rrp.rec
  and arc_rrp.kf = accounts.kf
  and arc_rrp.nlsb  = accounts.nls
  and trunc(arc_rrp.dat_a) >= to_date(sysdate) - 30
  and arc_rrp.KV = accounts.KV
  and arc_rrp.d_rec like '#?%'
  and arc_rrp.s > 0
  and arc_rrp.dk > 1
  and tzapros.otm = 0
  and accounts.branch like sys_context('bars_context','user_branch_mask');

PROMPT *** Create  grants  V_SEP_QDOCS ***
grant SELECT                                                                 on V_SEP_QDOCS     to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SEP_QDOCS     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_SEP_QDOCS     to WR_QDOCS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SEP_QDOCS.sql =========*** End *** ==
PROMPT ===================================================================================== 
