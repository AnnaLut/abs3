

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_DEB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_DEB ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_DEB ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  SELECT a.RNK,
          a.acc,
          a.mdate,
          a.nls,
          TO_NUMBER (a.nbs),
          q.FIN,
          q.OBS,
          q.KAT,
          q.K,
          a.tobo
     FROM v_gl a, ACC_DEB_23 q
    WHERE a.acc = q.acc(+) AND a.dazs IS NULL
          --   and not exists (select 1 from nd_acc where acc=a.acc)
          AND a.nbs IN
                 ('1811',
                  '1819',
                  '2800',
                  '2801',
                  '2809',
                  '3540',
                  '3541',
                  '3548',
                  '3570',
                  '3578',
                  '3579',
                  '3550',
                  '3551',
                  '3552',
                  '3559',
                  '3510',
                  '3519',
                  '3710');

PROMPT *** Create  grants  NBU23_DEB ***
grant SELECT                                                                 on NBU23_DEB       to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_DEB       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_DEB       to START1;
grant SELECT                                                                 on NBU23_DEB       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_DEB.sql =========*** End *** ====
PROMPT ===================================================================================== 
