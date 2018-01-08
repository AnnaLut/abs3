

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NADA7.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view NADA7 ***

  CREATE OR REPLACE FORCE VIEW BARS.NADA7 ("DAT1", "DAT2", "BRANCH", "RNK", "NLS", "KV", "O_ED", "O_ID", "O_EK", "O_IK", "OE", "OI", "OO", "PE", "PI") AS 
  SELECT dat1,
          dat2,
          branch,
          RNK,
          NLS,
          KV,
          o_ed / 100,
          o_id / 100,
          o_ek / 100,
          o_ik / 100,
          (o_ed + o_ek) / 100 OE,
          (o_id + o_ik) / 100 OI,
          (o_ed + o_ek + o_id + o_ik) / 100 OO,
          (o_ed + o_ek) * 100 / (o_ed + o_ek + o_id + o_ik) PE,
          (o_id + o_ik) * 100 / (o_ed + o_ek + o_id + o_ik) PI
     FROM (SELECT SDATE dat1,
                  WDATE dat2,
                  TOBO branch,
                  RNK,
                  NLS,
                  KV,
                  SUMG o_ed,
                  SUM_RATN o_id,
                  SG_OSTC o_ek,
                  SG_RATN o_ik
             FROM nada_nd7_web
            WHERE userid = user_id
           UNION ALL
             SELECT SDATE,
                    WDATE,
                    TO_CHAR (NULL),
                    RNK,
                    TO_CHAR (NULL),
                    TO_CHAR (NULL),
                    SUM (SUMG),
                    SUM (SUM_RATN),
                    SUM (SG_OSTC) k,
                    SUM (SG_RATN)
               FROM nada_nd7_web
              WHERE userid = user_id
           GROUP BY SDATE, WDATE, RNK);

PROMPT *** Create  grants  NADA7 ***
grant SELECT                                                                 on NADA7           to BARSREADER_ROLE;
grant SELECT                                                                 on NADA7           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NADA7           to SALGL;
grant SELECT                                                                 on NADA7           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NADA7.sql =========*** End *** ========
PROMPT ===================================================================================== 
