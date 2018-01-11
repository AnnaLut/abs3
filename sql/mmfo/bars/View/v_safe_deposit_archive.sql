

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SAFE_DEPOSIT_ARCHIVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SAFE_DEPOSIT_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SAFE_DEPOSIT_ARCHIVE ("N_SK", "SNUM", "O_SK", "TYPE", "KEYUSED", "KEYNUMBER", "KEYCOUNT", "BAIL_SUM", "BAIL_SUM_EQUIV", "KV", "LCV", "ACC", "NLS", "OSTC", "OSTB", "MDATE", "ACC_ISP", "ACC_ISP_NAME", "SAFE_ISP", "SAFE_ISP_NAME", "BANK_TR", "BANK_TR_NAME", "ND", "NUM", "SOS", "TARIFF", "NLS3600", "NMK", "CUSTTYPE", "FIO", "JNMK", "OKPO", "DOCNUM", "ISSUED", "ADDRESS", "DATR", "MR", "TEL", "DOC_DATE", "DAT_BEGIN", "DAT_END", "NDOV", "DOV_FIO", "DOV_OKPO", "DOV_DOCNUM", "DOV_ISSUED", "DOV_ADDRESS", "DOV_DATR", "DOV_MR", "DOV_DAT_BEGIN", "DOV_DAT_END", "NLSK", "MFOK", "NB", "RENT_SUM", "PDV", "DAY_PAYMENT", "DISCOUNT", "PENY", "AMORT_INCOME", "PLAN_PAY", "P_LEFT", "FACT_PAY", "F_LEFT", "NDS2", "CUR_INCOME", "F_INCOME", "BRANCH", "RNK") AS 
  SELECT   s.n_sk, s.snum, s.o_sk, d.NAME,
		 s.keyused, s.keynumber, n.KEYCOUNT,
		 d.s, gl.p_icurval (a.kv, d.s, bankdate), a.kv, t.lcv, a.acc, a.nls,a.ostc, a.ostb, a.MDATE,
         st1.id,st1.fio,st2.id,st2.fio,st3.id,st3.fio,
		 n.nd, n.NDOC, n.sos, n.TARIFF, sa.nls,
		 DECODE (n.custtype, 2, n.nmk, n.fio),n.custtype,n.fio,n.nmk,n.okpo1,
		 n.DOKUM,n.ISSUED,n.ADRES,n.datr,n.mr,n.tel,
         n.docdate, n.dat_begin, n.dat_end,
		 n.ndov, n.fio2,n.OKPO2,n.PASP2,n.ISSUED2,n.ADRES2,n.DATR2,n.mr2,
		 n.dov_dat1,n.dov_dat2,
		 n.nlsk, n.mfok, b.nb,
		 n.s_arenda, n.s_nds,
		 n.sd, n.prskidka, n.peny,
         skrn.f_get_amort3600_sum(n.nd),
		 skrn.f_get_oplplan_sum(n.nd),
		 skrn.f_get_oplplan_sum(n.nd) - skrn.f_get_opl_sum(n.nd),
         skrn.f_get_opl_sum(n.nd),
		 n.s_arenda - skrn.f_get_opl_sum(n.nd),
		 skrn.f_get_nds_sum(n.nd),
         skrn.f_get_curdoh_sum(n.nd),
         skrn.f_get_3600_sum(n.nd),
		 s.branch,
		 na.rnk
    FROM v_skrynka s,
         v_skrynka_nd n,
		 skrynka_nd_acc na,
		 saldo sa,
         skrynka_tip d,
         v_skrynka_acc g,
         saldo a,
		 tabval t,
		 staff st1,
		 staff st2,
		 staff st3,
		 banks b
   WHERE s.n_sk = n.n_sk(+)
     AND s.o_sk = d.o_sk
     AND s.n_sk = g.n_sk
     AND a.acc = g.acc
	 AND a.kv = t.kv
	 AND (a.isp = st1.id(+))
	 AND (s.isp_mo = st2.id(+))
	 AND (n.isp_dov = st3.id(+))
	 AND (n.mfok = b.mfo (+))
 	 AND n.nd = na.nd (+)
	 AND na.tip(+) = 'D'
	 AND sa.acc(+) = na.acc;

PROMPT *** Create  grants  V_SAFE_DEPOSIT_ARCHIVE ***
grant SELECT                                                                 on V_SAFE_DEPOSIT_ARCHIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_SAFE_DEPOSIT_ARCHIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SAFE_DEPOSIT_ARCHIVE to DEP_SKRN;
grant SELECT                                                                 on V_SAFE_DEPOSIT_ARCHIVE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SAFE_DEPOSIT_ARCHIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SAFE_DEPOSIT_ARCHIVE.sql =========***
PROMPT ===================================================================================== 
