

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_ZAY.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_ZAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_ZAY ("OSTC", "RNK", "NLS29", "NLS26", "MFOP", "NLSP", "KOM", "MFO26", "OKPOP", "OKPO26", "DK", "NAL_NOTE", "NAL_DATE", "TEL", "FIO", "NAZN_PF", "RNK_PF", "KOM2", "FL_PF", "MFOV", "NLSV", "NLS_KOM", "NLS_KOM2", "KF", "CUSTACC4CMS", "KOM3", "BRANCH", "RNKC", "NMK", "OKPO") AS 
  SELECT a.ostc / 100 ostc,
          c."RNK",
          c."NLS29",
          c."NLS26",
          c."MFOP",
          c."NLSP",
          c."KOM",
          c."MFO26",
          c."OKPOP",
          c."OKPO26",
          c."DK",
          c."NAL_NOTE",
          c."NAL_DATE",
          c."TEL",
          c."FIO",
          c."NAZN_PF",
          c."RNK_PF",
          c."KOM2",
          c."FL_PF",
          c."MFOV",
          c."NLSV",
          c."NLS_KOM",
          c."NLS_KOM2",
          c."KF",
          c."CUSTACC4CMS",
          c."KOM3",
          cc.branch,
          cc.rnk rnkc,
          cc.nmk,
          cc.okpo
     --INTO :NLS0,:S0,:NLSV,:MFOV, :NLS1, :CUST_BRANCH
     FROM accounts a, cust_zay c, customer cc
    WHERE     a.kv(+) = 980
          AND a.nls(+) = c.nls29
          AND c.rnk(+) = cc.rnk
          AND cc.date_off IS NULL
          AND cc.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
          AND C.kf = SYS_CONTEXT ('bars_context', 'user_mfo');

PROMPT *** Create  grants  V_CUST_ZAY ***
grant SELECT                                                                 on V_CUST_ZAY      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_ZAY.sql =========*** End *** ===
PROMPT ===================================================================================== 
