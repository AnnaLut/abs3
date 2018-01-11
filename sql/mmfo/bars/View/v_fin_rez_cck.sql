

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_REZ_CCK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_REZ_CCK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_REZ_CCK ("DAT1", "DAT2", "BRANCH", "PROD2", "ND", "RNK", "OKPO", "NMK", "K110", "KV", "PROD6", "N1", "N2", "N3", "FIN", "OBS", "KAT", "K", "CC_ID", "SROK") AS 
  select
TO_DATE (SUBSTR(t.name1, 2,8),'yyyymmdd') DAT1,
TO_DATE (SUBSTR(t.name1,10,8),'yyyymmdd') DAT2,
                                      t.BRANCH,
                               t.NLSALT  PROD2,
                                          t.ND,
                                     t.reg RNK,
                                        c.OKPO,
                                         c.NMK,
                                    c.ved K110,
                                          t.KV,
                                   t.nls PROD6,
                                   t.n1/100 N1,
                                   t.n2/100 N2,
                            (t.n2-t.n1)/100 n3,
                                      t.UV fin,
                                     t.PRS obs,
                                      t.PR kat,
                                        t.n5 k,
                                       t.cc_id,
                                        t.SROK
FROM CCK_AN_TMP t, customer c where t.reg=c.rnk ;

PROMPT *** Create  grants  V_FIN_REZ_CCK ***
grant SELECT                                                                 on V_FIN_REZ_CCK   to BARSREADER_ROLE;
grant SELECT                                                                 on V_FIN_REZ_CCK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FIN_REZ_CCK   to START1;
grant SELECT                                                                 on V_FIN_REZ_CCK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_REZ_CCK.sql =========*** End *** 
PROMPT ===================================================================================== 
