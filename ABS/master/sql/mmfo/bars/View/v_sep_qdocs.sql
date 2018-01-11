

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SEP_QDOCS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SEP_QDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SEP_QDOCS ("DK", "REC", "REF", "DATD", "ND", "VOB", "MFOA", "NLSA", "KV", "S", "NLSB", "NAM_B", "NAZN", "D_REC", "FN_A", "DAT_A", "NAM_A", "ID_A", "ID_B", "DATP", "NMS", "OSTC", "LIM", "PAP", "OTM") AS 
  SELECT arc_rrp.dk,
          tzapros.rec,
          arc_rrp.REF,
          arc_rrp.datd,
          arc_rrp.nd,
          arc_rrp.vob,
          arc_rrp.mfoa,
          arc_rrp.nlsa,
          arc_rrp.kv,
          arc_rrp.s / 100 AS s,
          arc_rrp.nlsb,
          arc_rrp.nam_b,
          arc_rrp.nazn,
          arc_rrp.d_rec,
          arc_rrp.fn_a,
          arc_rrp.dat_a,
          arc_rrp.nam_a,
          arc_rrp.id_a,
          arc_rrp.id_b,
          arc_rrp.datp,
          accounts.nms,
          accounts.ostc / 100 AS ostc,
          accounts.lim / 100 AS lim,
          accounts.pap,
          tzapros.otm
     FROM tzapros, arc_rrp, accounts
    WHERE     tzapros.rec = arc_rrp.rec
          AND arc_rrp.kf = accounts.kf
          AND arc_rrp.nlsb = accounts.nls
          AND TRUNC (arc_rrp.dat_a) >= TO_DATE (SYSDATE) - 90
          AND arc_rrp.KV = accounts.KV
          AND arc_rrp.d_rec LIKE '#?%'
          AND arc_rrp.s > 0
          AND arc_rrp.dk > 1
          AND tzapros.otm = 0
          AND accounts.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_SEP_QDOCS ***
grant SELECT                                                                 on V_SEP_QDOCS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SEP_QDOCS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SEP_QDOCS     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_SEP_QDOCS     to WR_QDOCS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SEP_QDOCS.sql =========*** End *** ==
PROMPT ===================================================================================== 
