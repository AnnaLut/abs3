

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBD_K.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view MBD_K ***

  CREATE OR REPLACE FORCE VIEW BARS.MBD_K ("RNK", "OKPO", "NMK", "NMKK", "KV", "NLS", "ACC", "ACCC", "ND", "CC_ID", "DK", "OSTC", "OSTB", "OSTF", "NLS_N", "GRP_N", "MDATE_N", "OSTC_N", "OSTB_N", "OSTF_N", "ACR_DAT", "ZDATE", "SDATE", "WDATE", "LIMIT", "SROK", "USERID", "KPROLOG", "VIDD", "TIPD", "BIC", "SWI_REF", "SWO_REF", "ACCKRED", "MFOKRED", "ACCPERC", "MFOPERC", "NLS_1819") AS 
  SELECT
  rnk, okpo, nmk, nmkk, a_kv, a_nls, a_acc, a_accc, nd, cc_id,
  tipd-1, a_ostc, a_ostb, a_ostf,
  b_nls, b_grp, b_mdate, b_ostc, b_ostb, b_ostf, acr_dat,
  date_u, date_v, date_end,
  s, date_end-date_u, userid, kprolog,
  vidd, tipd, bic, swi_ref, swo_ref,
  acckred, mfokred, accperc, mfoperc, nls_1819
FROM mbk_deal;

PROMPT *** Create  grants  MBD_K ***
grant SELECT                                                                 on MBD_K           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBD_K           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBD_K.sql =========*** End *** ========
PROMPT ===================================================================================== 
