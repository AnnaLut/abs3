

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LIST_TAR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LIST_TAR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LIST_TAR ("RNK", "NMK", "OKPO", "NLS", "KV", "NMS", "BRANCH_K", "BRANCH_R", "DAT_VKL", "DAT_VYKL") AS 
  SELECT e.rnk,
            c.nmk,
            c.okpo,
            a2.nls,
            a2.kv,
            SUBSTR (a2.NMS, 1, 38) NMS,                         --e.acc26 acc,
            --e.ND, e.CC_ID, e.SDATE,   e.WDATE,
            c.branch BRANCH_K,
            a2.branch BRANCH_R,
            D.DAT_BEG dat_vkl,
            d.dat_end dat_vykl                                             --,
       --                           d.id, t.name
       FROM e_deal e,
            accounts a2,
            customer c,
            e_tar_ND D,
            E_TARIF T
      WHERE     e.rnk = c.rnk
            AND e.acc26 = a2.acc
            AND a2.dazs IS NULL
            AND e.nd = d.nd
            AND d.id = t.id
   --   and e.sos<>15  -- без закритих угод
   ORDER BY e.rnk, a2.nls;

PROMPT *** Create  grants  V_LIST_TAR ***
grant SELECT                                                                 on V_LIST_TAR      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_LIST_TAR      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LIST_TAR.sql =========*** End *** ===
PROMPT ===================================================================================== 
