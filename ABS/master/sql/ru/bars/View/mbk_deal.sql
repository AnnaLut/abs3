

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK_DEAL ("USERID", "ND", "CC_ID", "VIDD", "VIDD_NAME", "TIPD", "DATE_B", "DATE_U", "DATE_V", "DATE_END", "S", "S_PR", "A_NLS", "A_OSTC", "A_OSTB", "A_OSTF", "A_MDATE", "A_ACC", "A_ACCC", "A_KV", "A_GRP", "A_TIP", "B_NLS", "B_OSTC", "B_OSTB", "B_OSTF", "B_MDATE", "B_ACC", "B_ACCC", "B_KV", "B_GRP", "RNK", "NMK", "NMKK", "OKPO", "COUNTRY", "NUM_ND", "DAT_ND", "MFO", "KOD_B", "BIC", "ACCKRED", "ACCPERC", "MFOKRED", "MFOPERC", "REFP", "KPROLOG", "SWI_ACC", "SWI_BIC", "SWI_REF", "SWO_ACC", "SWO_BIC", "SWO_REF", "ALT_PARTYB", "INTERM_B", "FIELD_58D", "INT_PARTYA", "INT_PARTYB", "INT_INTERMA", "INT_INTERMB", "INT_AMOUNT", "RAT", "ACRB", "ACR_DAT", "BASEY", "NLS_1819") AS 
  select d.user_id, d.nd nd, d.cc_id, d.vidd, v.name, v.tipd,
       d.sdate date_bd, ad.bdate date_u, ad.wdate date_v, d.wdate date_end,
       ad.s, acrn.fproc(a.acc,bankdate) s_pr,
       a.nls a_nls, a.ostc a_ostc, a.ostb+a.ostf a_ostb, a.ostf a_ostf, a.mdate a_mdate, a.acc a_acc, a.accc a_accc, a.kv, a.grp, a.tip,
       b.nls b_nls, b.ostc b_ostc, b.ostb+b.ostf b_ostb, b.ostf b_ostf, b.mdate b_mdate, b.acc b_acc, b.accc b_accc, b.kv, b.grp,
       c.rnk, c.nmk, c.nmkk, c.okpo, c.country, cb.num_nd, cb.dat_nd, cb.mfo, cb.kod_b, cb.bic,
       ad.acckred, ad.accperc, ad.mfokred, ad.mfoperc, ad.refp, d.kprolog,
       ad.swi_acc, ad.swi_bic, ad.swi_ref, ad.swo_acc, ad.swo_bic, ad.swo_ref,
       ad.alt_partyb, ad.interm_b, ad.field_58d, ad.int_partya, ad.int_partyb, ad.int_interma, ad.int_intermb, ad.int_amount,
       to_char(acrn.fproc(a.acc)) rat, nvl(i.acrb,0) acrb, i.acr_dat, i.basey, ad.nls_1819
  from cc_deal d, cc_add ad, cc_vidd v, accounts a, accounts b, int_accn i,
       customer c, custbank cb
 where d.nd    = ad.nd
   and d.vidd  = v.vidd
   and v.custtype = 1 and length(v.vidd) = 4
   and ad.accs = a.acc
   and d.wdate = a.mdate
   and a.acc   = i.acc and i.id = v.tipd-1
   and a.dazs is null
   and b.acc   = i.acra
   and d.rnk   = c.rnk and c.custtype = 1
   and c.rnk   = cb.rnk
   and ad.adds = 0
   and (a.ostc<>0 and (d.wdate >= bankdate or a.ostc<>0 or i.acr_dat is null or i.acr_dat < d.wdate-1)
       or (a.ostc=0 and a.dapp=bankdate )
       or (a.ostc=0 and a.dapp<bankdate  and d.sdate=bankdate)
       or (a.ostc=0 and d.wdate>=bankdate));

PROMPT *** Create  grants  MBK_DEAL ***
grant SELECT                                                                 on MBK_DEAL        to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
