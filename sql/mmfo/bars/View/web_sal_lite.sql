

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/WEB_SAL_LITE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view WEB_SAL_LITE ***

  CREATE OR REPLACE FORCE VIEW BARS.WEB_SAL_LITE ("ACC", "NLS", "KV", "LCV", "DIG", "DENOM", "NMS", "OST", "DOS", "KOS", "OSTC", "OSTB", "OSTF", "DAPP", "DAOS", "DAZS", "TOBO", "TIP", "PAP", "BLKK", "BLKD", "MDATE", "POS", "NBS", "ISP", "RNK", "KF", "OB22", "NLSALT", "LIM", "OSTQ", "DOSQ", "KOSQ", "NBS2", "VID", "TRCN", "ACCC", "SEC", "BRANCH", "INTACCN", "FIO") AS 
  SELECT a.acc,
       a.nls,
       a.kv,
       v.lcv,
       v.dig,
       v.denom,
       a.nms,
       DECODE (a.dapp, b.bd, a.ostc + a.dos - a.kos, a.ostc) AS ost, -- вхідний
       DECODE (a.dapp, b.bd, a.dos, 0) dos,
       DECODE (a.dapp, b.bd, a.kos, 0) kos,
       a.OSTC, -- вихідний
       a.OSTB,
       a.OSTF,
       a.DAPP,
       a.DAOS,
       a.DAZS,
       a.TOBO,
       a.TIP,
       a.PAP,
       a.BLKK,
       a.BLKD,
       a.MDATE,
       a.POS,
       a.NBS,
       a.ISP,
       a.RNK,
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
       a.SEC,
       a.BRANCH,
       acrn.fprocn( a.acc, DECODE( a.pap,  1, 0,  2, 1,  1 ), gl.bd ) as intaccn,
       sb.fio
  FROM saldo a,
       (SELECT bankdate_g bd FROM DUAL) b,
       tabval$global v,
       staff$base sb
 WHERE a.kv = v.kv AND a.isp = sb.id;

PROMPT *** Create  grants  WEB_SAL_LITE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL_LITE    to ABS_ADMIN;
grant SELECT                                                                 on WEB_SAL_LITE    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL_LITE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_SAL_LITE    to START1;
grant SELECT                                                                 on WEB_SAL_LITE    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL_LITE    to WR_ALL_RIGHTS;
grant SELECT                                                                 on WEB_SAL_LITE    to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on WEB_SAL_LITE    to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/WEB_SAL_LITE.sql =========*** End *** =
PROMPT ===================================================================================== 
