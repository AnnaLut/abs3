

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/A_CCK_DU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view A_CCK_DU ***

  CREATE OR REPLACE FORCE VIEW BARS.A_CCK_DU ("ND", "ARJK", "KV", "NOM", "TOBO", "CC_ID", "SDATE", "WDATE", "OKPO", "RNK", "NAZN", "DAT1", "DAT2", "S", "DAT_ARJK", "REF1", "REF2") AS 
  SELECT ROW_NUM,
          COUNT_DAY,
          KV,
          S_OSTC,
          TOBO,
          CC_ID,
          SDATE,
          WDATE,
          NLS,
          RNK,
          NAME || vidd,
          IN_DAT,
          OUT_DAT,
          S,
          TO_DATE (TO_CHAR (dat_pog), 'yyyymmdd'),
          SG_OSTC,
          SG_RATN
     FROM CCK_AN_TMP_UPB;

PROMPT *** Create  grants  A_CCK_DU ***
grant SELECT                                                                 on A_CCK_DU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on A_CCK_DU        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/A_CCK_DU.sql =========*** End *** =====
PROMPT ===================================================================================== 
