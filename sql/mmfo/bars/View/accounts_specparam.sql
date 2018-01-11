

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACCOUNTS_SPECPARAM.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view ACCOUNTS_SPECPARAM ***

  CREATE OR REPLACE FORCE VIEW BARS.ACCOUNTS_SPECPARAM ("ACC", "NLS", "KV", "LCV", "NMS", "FDAT", "OSTC", "OSTQ", "NBS", "BRATE", "RNK", "DAOS", "DAZS", "ISP", "FIO", "OB22", "S031", "S240", "R013", "S080", "R011", "S180", "S181", "S182", "S190", "S200", "S230", "S260", "S270", "S580", "INSIDER", "NKD", "MDATE", "NMK", "OKPO", "DAPP", "R014", "K051") AS 
  SELECT   a.acc,
            a.nls,
            a.kv,
            t.lcv,
            a.nms,
            s4.fdat,
            s4.ost / 100,
            p_icurval (s4.kv, s4.ost, s4.fdat) / 100,
            a.nbs,
            acrn.fproc (a.acc, s4.fdat),
            a.rnk,
            a.daos,
            a.dazs,
            a.isp,
            s3.fio,
            si.ob22,
            s2.s031,
            s2.s240,
            s2.r013,
            s2.s080,
            s2.r011,
            s2.s180,
            s2.s181,
            s2.s182,
            s2.s190,
            s2.s200,
            s2.s230,
            s2.s260,
            s2.s270,
            s2.s580,
            c.prinsider,
            s2.nkd,
            a.mdate,
            c.nmk,
            c.okpo,
            a.dapp,
            s2.r014,
            c.sed
     FROM   SPECPARAM s2,
            STAFF s3,
            SAL s4,
            SPECPARAM_INT si,
            TABVAL t,
            CUSTOMER c,
            ACCOUNTS a
    WHERE       a.acc = s2.acc(+)
            AND a.acc = si.acc(+)
            AND a.kv = t.kv
            AND a.isp = s3.ID
            AND a.kv = s4.kv
            AND a.nls = s4.nls
            AND a.rnk = c.rnk
            AND a.acc = s4.acc;

PROMPT *** Create  grants  ACCOUNTS_SPECPARAM ***
grant SELECT                                                                 on ACCOUNTS_SPECPARAM to BARSREADER_ROLE;
grant SELECT                                                                 on ACCOUNTS_SPECPARAM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_SPECPARAM to START1;
grant SELECT                                                                 on ACCOUNTS_SPECPARAM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACCOUNTS_SPECPARAM.sql =========*** End
PROMPT ===================================================================================== 
