

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/INT_GL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view INT_GL ***

  CREATE OR REPLACE FORCE VIEW BARS.INT_GL ("KV", "NLS", "NMS", "NBS", "ACCC", "TIP", "ACC", "RNK", "ID", "ACR_DAT", "ACRA", "ACRB", "STP_DAT", "METR", "BASEY", "BASEM", "TT", "NLSA", "NMSA", "KVA", "NLSB", "NMSB", "KVB", "OB22", "OSTC", "DAPP", "BRANCH") AS 
  SELECT x.kv,
          x.nls,
          x.nms,
          x.nbs,
          x.ACCC,
          x.tip,
          x.acc,
          x.rnk,
          x.id,
          x.ACR_DAT,
          x.acra,
          x.acrb,
          x.stp_DAT,
          x.METR,
          x.BASEY,
          x.BASEM,
          x.tt,
          aa.nls NLSA,
          aa.nms NMSA,
          aa.kv KVA,
          bb.nls NLSb,
          bb.nms NMSb,
          bb.kv KVb,
          x.ob22,
          x.ostc / 100 ostc,
          x.dapp,
          x.branch
     FROM accounts aa,
          accounts bb,
          (SELECT a.kv,
                  a.nls,
                  a.nms,
                  a.nbs,
                  a.ACCC,
                  a.tip,
                  a.acc,
                  a.rnk,
                  a.ob22,
                  a.ostc,
                  a.dapp,
                  i.id,
                  GREATEST (a.daos - 1, i.acr_dat) ACR_DAT,
                  i.acra,
                  i.acrb,
                  i.stp_DAT,
                  i.METR,
                  i.BASEY,
                  i.BASEM,
                  i.tt,
                  a.branch
             FROM int_accn i, accounts a
            WHERE     a.acc = i.acc
                  AND a.dazs IS NULL
                  AND (   i.metr IN (0,
                                     1,
                                     2,
                                     3,
                                     4,
                                     5,
                                     7,
                                     8,
                                     10,
                                     12,
                                     23,
                                     515)
                       OR i.metr > 90)
                  AND id NOT IN (10, 11)) x
    WHERE x.acra = aa.acc AND x.acrb = bb.acc;

PROMPT *** Create  grants  INT_GL ***
grant SELECT                                                                 on INT_GL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_GL          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/INT_GL.sql =========*** End *** =======
PROMPT ===================================================================================== 
