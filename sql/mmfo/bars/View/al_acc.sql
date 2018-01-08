

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AL_ACC.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view AL_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.AL_ACC ("OTD", "USERID", "KOL0", "KOL1", "KOL") AS 
  SELECT o.otd,
            a.isp,
            SUM (DECODE (a.kv, 980, 1, 0)),
            SUM (DECODE (a.kv, 980, 0, 1)),
            COUNT (*)
       FROM accounts a, otd_user o
      WHERE o.userid(+) = a.isp AND a.dazs IS NULL
   GROUP BY o.otd, a.isp
   UNION ALL
     SELECT o.otd,
            0,
            SUM (DECODE (a.kv, 980, 1, 0)),
            SUM (DECODE (a.kv, 980, 0, 1)),
            COUNT (*)
       FROM accounts a, otd_user o
      WHERE o.userid(+) = a.isp AND a.dazs IS NULL
   GROUP BY o.otd;

PROMPT *** Create  grants  AL_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on AL_ACC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AL_ACC          to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AL_ACC.sql =========*** End *** =======
PROMPT ===================================================================================== 
