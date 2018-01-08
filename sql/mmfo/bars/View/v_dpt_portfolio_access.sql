

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_ACCESS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PORTFOLIO_ACCESS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PORTFOLIO_ACCESS ("ID", "ND", "VIDD", "NAM", "DATN", "DATK", "RNK", "NMK", "ACC", "NLS", "KV", "ISP", "REAL_EXPIRE", "DOS", "KOS", "OST", "ACCN", "BR_ID", "PR", "SN", "FDAT", "BRANCH") AS 
  SELECT d.deposit_id, d.nd, v.vidd, v.type_name, d.dat_begin, d.dat_end,
          d.rnk, c.nmk, a.acc, a.nls, a.kv, a.isp, a.dazs,
          DECODE (s.fdat, b.fdat, s.dos, 0),
          DECODE (s.fdat, b.fdat, s.kos, 0), (s.ostf - s.dos + s.kos), i.acra,
          v.br_id, acrn.fproc (d.acc, b.fdat),
          DECODE (d.acc, i.acra, 0, fost (i.acra, b.fdat)), b.fdat, a.tobo
     FROM saldo a,
          saldoa s,
          fdat b,
          dpt_deposit_clos d,
          customer c,
          dpt_vidd v,
          int_accn i
    WHERE a.acc = s.acc
      AND d.acc = a.acc
      AND c.rnk = d.rnk
      AND d.vidd = v.vidd
      AND b.fdat <= NVL (a.dazs, b.fdat)
      AND b.fdat >= a.daos
      AND a.acc = i.acc
      AND i.ID = 1
      AND (a.acc, s.fdat) = (SELECT   c.acc, MAX (c.fdat)
                                 FROM saldoa c
                                WHERE a.acc = c.acc AND c.fdat <= b.fdat
                             GROUP BY c.acc)
      AND d.idupd =
             (SELECT MAX (d1.idupd)
                FROM dpt_deposit_clos d1
               WHERE (d1.deposit_id, d1.bdate) =
                        (SELECT   d2.deposit_id, MAX (d2.bdate)
                             FROM dpt_deposit_clos d2
                            WHERE d2.deposit_id = d.deposit_id
                              AND d2.bdate <= b.fdat
                         GROUP BY d2.deposit_id)) 
 ;

PROMPT *** Create  grants  V_DPT_PORTFOLIO_ACCESS ***
grant SELECT                                                                 on V_DPT_PORTFOLIO_ACCESS to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_DPT_PORTFOLIO_ACCESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_PORTFOLIO_ACCESS to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_PORTFOLIO_ACCESS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PORTFOLIO_ACCESS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_DPT_PORTFOLIO_ACCESS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_ACCESS.sql =========***
PROMPT ===================================================================================== 
