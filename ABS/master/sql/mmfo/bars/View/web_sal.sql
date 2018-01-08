

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/WEB_SAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view WEB_SAL ***

  CREATE OR REPLACE FORCE VIEW BARS.WEB_SAL ("ACC", "NLS", "KV", "LCV", "DIG", "DENOM", "NMS", "OST", "DOS", "KOS", "OSTC", "OSTB", "OSTF", "DAPP", "DAOS", "DAZS", "TOBO", "TIP", "PAP", "BLKK", "BLKD", "MDATE", "POS", "NBS", "ISP", "RNK", "KF", "OB22", "NLSALT", "LIM", "OSTQ", "DOSQ", "KOSQ", "NBS2", "VID", "TRCN", "ACCC", "SEC", "BRANCH", "INTACCN", "FIO") AS 
  SELECT s.ACC,
          s.NLS,
          s.KV,
          v.LCV,
          v.DIG,
          v.DENOM,
          s.NMS,
          s.OSTF OST,
          s.DOS,
          s.KOS,
          s.OST OSTC,
          p.OSTB,
          p.OSTF,
          p.DAPP,
          p.DAOS,
          p.DAZS,
          s.TOBO,
          s.TIP,
          s.PAP,
          p.BLKK,
          p.BLKD,
          p.MDATE,
          p.POS,
          p.NBS,
          p.ISP,
          p.RNK,
          p.KF,
          p.OB22,
          p.NLSALT,
          p.LIM,
          p.OSTQ,
          p.DOSQ,
          p.KOSQ,
          p.NBS2,
          p.VID,
          p.TRCN,
          p.ACCC,
          p.SEC,
          p.branch,
          acrn.fprocn (p.acc, DECODE (p.pap,  1, 0,  2, 1,  1), gl.bd)
             intaccn, sb.fio
     FROM saldo p, tabval$global v, sal s,staff$base sb /* именно sal а не sal_branch, т.к. пользователь может видеть счета чужих бранчей */
    WHERE p.acc = s.acc AND s.kv = v.kv AND s.fdat = bankdate and p.ISP = sb.ID;

PROMPT *** Create  grants  WEB_SAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_SAL         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_SAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_SAL         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_SAL         to WR_ALL_RIGHTS;
grant SELECT                                                                 on WEB_SAL         to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on WEB_SAL         to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/WEB_SAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
