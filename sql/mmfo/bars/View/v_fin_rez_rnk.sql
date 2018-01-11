

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_REZ_RNK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_REZ_RNK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_REZ_RNK ("PROD", "RNK", "OKPO", "NMK", "N1", "N2", "DAT1", "DAT2") AS 
  SELECT t.nls, t.ND, c.okpo, c.nmk, t.n1/100 N1,  t.n2/100 N2,
       TO_DATE (SUBSTR(t.name1,2,8),'yyyymmdd') DAT1,  TO_DATE(SUBSTR(t.name1,10,8),'yyyymmdd') DAT2
FROM CCK_AN_TMP t, customer c
where t.nd=c.rnk ;

PROMPT *** Create  grants  V_FIN_REZ_RNK ***
grant SELECT                                                                 on V_FIN_REZ_RNK   to BARSREADER_ROLE;
grant SELECT                                                                 on V_FIN_REZ_RNK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FIN_REZ_RNK   to START1;
grant SELECT                                                                 on V_FIN_REZ_RNK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_REZ_RNK.sql =========*** End *** 
PROMPT ===================================================================================== 
