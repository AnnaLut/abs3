

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_DT_SS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_DT_SS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_DT_SS ("REF", "TT", "VDAT", "DATD", "NMK", "OKPO", "CC_ID", "SDATE", "ND", "NLS", "NAM_B", "ID_B", "MFOB", "NLSB", "S", "KV", "NAZN", "SOS") AS 
  (SELECT o.REF,
           o.tt,
           o.vdat,
           o.datd,
           c.nmk,
           c.okpo,
           d.cc_id,
           d.sdate,
           o.nd,
           a.nls,
           o.nam_b,
           o.id_b,
           o.mfob,
           o.nlsb,
           o.s / 100,
           o.kv,
           o.nazn,
           o.sos
      FROM oper o,
           opldok op,
           customer c,
           cc_deal d,
           nd_acc na,
           accounts a
     WHERE      SUBSTR (a.nls, 1, 2) IN ('20', '22')
           AND op.acc = a.acc
           AND a.tip = 'SS '
           AND op.dk = 0
           AND op.fdat >= bankdate - 10
           AND op.sos >= 0
           and op.ref = o.ref
           AND o.nlsa = a.nls
           AND a.rnk = c.rnk
           AND a.acc = na.acc
           AND na.nd = d.nd
  /*  UNION ALL
    SELECT o.REF,
           o.tt,
           o.vdat,
           o.datd,
           c.nmk,
           c.okpo,
           d.cc_id,
           d.sdate,
           o.nd,
           a.nls,
           o.nam_a,
           o.id_a,
           o.mfoa,
           o.nlsa,
           o.s / 100,
           o.kv2,
           o.nazn,
           o.sos
      FROM oper o,
           opldok op,
           customer c,
           cc_deal d,
           nd_acc na,
           accounts a
     WHERE     SUBSTR (a.nls, 1, 2) IN ('20', '22')
           AND a.tip = 'SS '
           AND op.acc = a.acc
           and op.dk = 1
           AND op.fdat >= bankdate - 10
           AND op.sos >= 0
           and op.ref = o.ref
           AND o.nlsb = a.nls
           AND a.rnk = c.rnk
           AND a.acc = na.acc
           AND na.nd = d.nd*/);

PROMPT *** Create  grants  V_CCK_DT_SS ***
grant SELECT                                                                 on V_CCK_DT_SS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_DT_SS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_DT_SS     to RCC_DEAL;
grant SELECT                                                                 on V_CCK_DT_SS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_DT_SS.sql =========*** End *** ==
PROMPT ===================================================================================== 
