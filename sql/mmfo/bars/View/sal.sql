

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SAL.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view SAL ***

  CREATE OR REPLACE FORCE VIEW BARS.SAL ("DAPP", "ACCC", "ACC", "NLS", "KV", "NMS", "GRP", "FDAT", "OSTF", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "APP", "TIP", "DAOS", "PAP", "RNK", "TOBO", "BRANCH", "KF") AS 
  select decode (b.fdat, s.fdat, s.pdat, s.fdat), a.accc, a.acc, a.nls, a.kv,
          a.nms, a.grp, b.fdat,
          decode (s.fdat, b.fdat, s.ostf, s.ostf - s.dos + s.kos), -- входящий остаток
          decode (s.fdat, b.fdat, s.dos, 0),
          decode (s.fdat, b.fdat, s.kos, 0),
          s.ostf - s.dos + s.kos, -- исходящий остаток
          a.nbs, a.isp, a.nlsalt, a.dazs, s.fdat, a.tip, a.daos, a.pap, a.rnk,
          a.tobo, a.branch, a.kf
     from accounts a, saldoa s, fdat b
    where a.acc = s.acc
      and (a.acc, s.fdat) = (select   c.acc, max (c.fdat)
                                 from saldoa c
                                where a.acc = c.acc and c.fdat <= b.fdat
                             group by c.acc);

PROMPT *** Create  grants  SAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL             to ABS_ADMIN;
grant SELECT                                                                 on SAL             to BARSAQ with grant option;
grant SELECT                                                                 on SAL             to BARSAQ_ADM with grant option;
grant SELECT                                                                 on SAL             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SAL             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SAL             to JBOSS_USR;
grant DELETE,INSERT,SELECT,UPDATE                                            on SAL             to RCC_DEAL;
grant SELECT                                                                 on SAL             to RPBN001;
grant SELECT                                                                 on SAL             to RPBN002;
grant SELECT                                                                 on SAL             to SALGL;
grant SELECT                                                                 on SAL             to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SAL             to WR_ALL_RIGHTS;
grant SELECT                                                                 on SAL             to WR_CUSTLIST;
grant FLASHBACK,SELECT                                                       on SAL             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SAL.sql =========*** End *** ==========
PROMPT ===================================================================================== 
