

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/WEB_SAL_LITE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view WEB_SAL_LITE ***

  CREATE OR REPLACE FORCE VIEW BARS.WEB_SAL_LITE ("ACC", "NLS", "KV", "LCV", "DIG", "DENOM", "NMS", "OST", "DOS", "KOS", "OSTC", "OSTB", "OSTF", "DAPP", "DAOS", "DAZS", "TOBO", "TIP", "PAP", "BLKK", "BLKD", "MDATE", "POS", "NBS", "ISP", "RNK", "KF", "OB22", "NLSALT", "LIM", "OSTQ", "DOSQ", "KOSQ", "NBS2", "VID", "TRCN", "ACCC", "SEC", "BRANCH") AS 
  select a.acc,
       a.nls,
       a.kv,
       v.lcv,
       v.dig,
       v.denom,
       a.nms,
       decode(a.dapp, b.bd, a.ostc+a.dos-a.kos, a.ostc) as ost,  -- вхідний
       decode(a.dapp, b.bd, a.dos, 0) dos,
       decode(a.dapp, b.bd, a.kos, 0) kos,
       a.ostc ostc,  -- вихідний
       a.ostb,
       a.ostf,
       a.dapp,
       a.daos,
       a.dazs,
       a.tobo,
       a.tip,
       a.pap,
       a.blkk,a.blkd,a.mdate,a.pos,a.nbs,a.isp,a.rnk,
       a.KF,
       a.OB22,
       a.NLSALT,
       a.LIM,
       a.OSTQ,
       a.DOSQ,
       a.KOSQ,
       a.NBS2,
       a.VID,
       a.TRCN,
       a.ACCC,
       a.SEC
       , a.branch
from saldo a, (select bankdate_g bd from dual) b,
    tabval$global v
where a.kv=v.kv;

PROMPT *** Create  grants  WEB_SAL_LITE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL_LITE    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL_LITE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_SAL_LITE    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL_LITE    to WR_ALL_RIGHTS;
grant SELECT                                                                 on WEB_SAL_LITE    to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on WEB_SAL_LITE    to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/WEB_SAL_LITE.sql =========*** End *** =
PROMPT ===================================================================================== 
