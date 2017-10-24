

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NONRESID_PARTNERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NONRESID_PARTNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NONRESID_PARTNERS ("RNK", "NMK", "NMKK", "BIC", "NUM_ND", "OKPO", "LIM", "DAT_ND", "BKI") AS 
  SELECT c.rnk,
            c.nmk,
            c.nmkk,
            u.bic,
            u.num_nd,
            c.okpo,
            c.lim / 100 lim,
            u.dat_nd,
            u.bki
       FROM customer C, custbank u
      WHERE     C.DATE_OFF IS NULL
            AND C.rnk = u.rnk
            AND C.codcagent = 2
            AND u.bic IS NOT NULL
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
   ORDER BY c.rnk;

PROMPT *** Create  grants  V_NONRESID_PARTNERS ***
grant SELECT                                                                 on V_NONRESID_PARTNERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NONRESID_PARTNERS.sql =========*** En
PROMPT ===================================================================================== 
