

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RESID_PARTNERS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RESID_PARTNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RESID_PARTNERS ("RNK", "NMK", "NMKK", "MFO", "BIC", "NUM_ND", "OKPO", "KOD_B", "LIM", "DAT_ND", "NB", "BKI") AS 
  SELECT c.rnk,
            c.nmk,
            c.nmkk,
            u.mfo,
            u.bic,
            u.num_nd,
            c.okpo,
            u.kod_b,
            c.lim / 100 lim,
            u.dat_nd,
            b.nb,
            u.bki
       FROM customer c, custbank u, banks b
      WHERE     c.date_off IS NULL
            AND c.rnk = u.rnk
            AND c.codcagent = 1
            AND c.okpo <> f_ourokpo
            AND u.mfo <> f_ourmfo
            AND u.mfo = b.mfo
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
   ORDER BY u.mfo, c.rnk;

PROMPT *** Create  grants  V_RESID_PARTNERS ***
grant SELECT                                                                 on V_RESID_PARTNERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RESID_PARTNERS.sql =========*** End *
PROMPT ===================================================================================== 
