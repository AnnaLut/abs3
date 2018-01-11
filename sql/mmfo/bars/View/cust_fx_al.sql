

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_FX_AL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_FX_AL ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_FX_AL ("RNK", "NAME", "CODCAGENT", "ID", "BIC", "MFO", "OKPO", "KOD_B", "KOD_G", "KV", "NLS", "BICK", "NLSK", "ALT_PARTYB", "INTERM_B", "FIELD_58D", "AGRMNT_NUM", "AGRMNT_DATE", "TELEXNUM", "TXT", "KF") AS 
  SELECT x1.RNK,
          x1.nmk NAME,
          x1.CODCAGENT,
          x2.id,
          NVL (x1.bic, x2.bic) bic,
          NVL (x1.mfo, x2.mfo) mfo,
          NVL (x1.OKPO, x2.okpo) okpo,
          NVL (x1.KOD_B, x2.kod_b) kod_b,
          SUBSTR ('000' || NVL (x1.COUNTRY, TRIM (x2.kod_G)), -3) kod_G,
          x2.KV,
          x2.NLS,
          x2.BICK,
          x2.NLSK,
          x2.ALT_PARTYB,
          x2.INTERM_B,
          x2.FIELD_58D,
          x2.AGRMNT_NUM,
          x2.AGRMNT_DATE,
          x2.TELEXNUM,
          x2.TXT,
          x1.kf
     FROM forex_alien x2,
          (SELECT c.rnk,
                  b.mfo,
                  b.bic,
                  c.COUNTRY,
                  b.KOD_B,
                  c.OKPO,
                  SUBSTR (c.nmk, 1, 35) nmk,
                  c.codcagent,
                  c.kf
             FROM customer c, custbank b
            WHERE c.rnk = b.rnk    and c.kf=   sys_context('bars_context','user_mfo')
                   and c.date_off is null
                               ) x1
    WHERE (   x1.mfo = x2.mfo
           OR x1.bic = x2.bic
           OR x1.okpo = x2.okpo
           OR x1.KOD_B = x2.KOD_B);

PROMPT *** Create  grants  CUST_FX_AL ***
grant SELECT                                                                 on CUST_FX_AL      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_FX_AL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_FX_AL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_FX_AL.sql =========*** End *** ===
PROMPT ===================================================================================== 
