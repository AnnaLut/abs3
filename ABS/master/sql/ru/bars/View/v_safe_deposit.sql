

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SAFE_DEPOSIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SAFE_DEPOSIT ***

CREATE OR REPLACE VIEW V_SAFE_DEPOSIT
(n_sk, snum, o_sk, type, keyused, keynumber, keycount, bail_sum, bail_sum_equiv, kv, lcv, acc, nls, ostc, ostb, mdate, acc_isp, acc_isp_name, safe_isp, safe_isp_name, bank_tr, bank_tr_name, nd, num, sos, tariff, nls3600, nmk, custtype, fio, jnmk, okpo, docnum, issued, address, datr, mr, tel, doc_date, dat_begin, dat_end, ndov, dov_fio, dov_okpo, dov_docnum, dov_issued, dov_address, dov_datr, dov_mr, dov_dat_begin, dov_dat_end, nlsk, mfok, nb, rent_sum, pdv, day_payment, discount, peny, amort_income, plan_pay, p_left, fact_pay, f_left, nds2, cur_income, f_income, branch, rnk)
AS
SELECT   s.n_sk, s.snum, s.o_sk, d.NAME,
     s.keyused, s.keynumber, n.KEYCOUNT,
     d.s, gl.p_icurval (a.kv, d.s, bankdate), a.kv, t.lcv, a.acc, a.nls,a.ostc, a.ostb, a.MDATE,
         st1.id,st1.fio,st2.id,st2.fio,st3.id,st3.fio,
     n.nd, n.NDOC, n.sos, n.TARIFF, sa.nls,
     DECODE (n.custtype, 2, n.nmk, n.fio),n.custtype,n.fio,n.nmk,n.okpo1,
     n.DOKUM,n.ISSUED,n.ADRES,n.datr,n.mr,safe_deposit.f_get_cust_tel(n.rnk) tel,
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
     n.rnk
    FROM skrynka s,
         skrynka_nd n,
     skrynka_nd_acc na,
     saldo sa,
         skrynka_tip d,
         skrynka_acc g,
         saldo a,
     tabval t,
     staff st1,
     staff st2,
     staff st3,
     banks b
   WHERE s.n_sk = n.n_sk(+)
     AND s.o_sk = d.o_sk
     AND s.n_sk = g.n_sk
     AND a.acc = g.acc and g.tip = 'M'
   AND a.kv = t.kv
   AND (n.sos(+) <> 15)
   AND (a.isp = st1.id(+))
   AND (s.isp_mo = st2.id(+))
   AND (n.isp_dov = st3.id(+))
   AND (n.mfok = b.mfo (+))
   AND n.nd = na.nd (+)
   AND na.tip(+) = 'D'
   AND sa.acc(+) = na.acc;

PROMPT *** Create  grants  V_SAFE_DEPOSIT ***
grant SELECT                                                                 on V_SAFE_DEPOSIT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SAFE_DEPOSIT  to DEP_SKRN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SAFE_DEPOSIT  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SAFE_DEPOSIT.sql =========*** End ***
PROMPT ===================================================================================== 

