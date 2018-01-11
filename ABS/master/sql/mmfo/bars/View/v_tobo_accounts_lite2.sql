

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS_LITE2.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_ACCOUNTS_LITE2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_ACCOUNTS_LITE2 ("ACC", "NLS", "NLSALT", "KV", "LCV", "DIG", "DENOM", "KF", "BRANCH", "TOBO", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OST", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OB22", "NOTIFIER_REF", "BDATE", "OPT", "DAPPQ", "INTACC", "FIO", "R011", "R013", "S180", "S240", "OKPO") AS 
  select /*+ index( s xak_accounts_branch )*/
          s.acc,
          s.nls,
          s.nlsalt,
          s.kv,
          v.lcv,
          v.dig,
          v.denom,
          s.kf,
          s.branch,
          s.tobo,
          s.nbs,
          s.nbs2,
          s.daos,
          s.dapp,
          s.isp,
          s.rnk,
          s.nms,
          s.lim,
          decode(s.dapp, d.bnk_dt, s.ostc + s.dos - s.kos, s.ostc) as ost,
          s.ostb,                                          -- остаток входящий
          s.ostc,                                          -- остаток исходящий
          s.ostf,
          s.ostq,
          s.ostx,
          decode( s.dapp, d.bnk_dt, s.dos,  0) dos,
          decode( s.dapp, d.bnk_dt, s.kos,  0) kos,
          decode( s.dapp, d.bnk_dt, s.dosq, 0) dosq,
          decode( s.dapp, d.bnk_dt, s.kosq, 0) kosq,
          s.pap,
          s.tip,
          s.vid,
          decode(s.dapp, d.bnk_dt, s.trcn, 0) trcn,
          s.mdate,
          s.dazs,
          s.sec,
          s.accc,
          s.blkd,
          s.blkk,
          s.pos,
          s.seci,
          s.seco,
          s.grp,
          s.ob22,
          s.notifier_ref,
          s.bdate,
          s.opt,
          s.dappq,
          acrn.fprocn( s.acc, decode( s.pap,  1, 0,  2, 1,  1), d.bnk_dt ) intacc,
          u.fio,
          p.r011,
          p.r013,
          p.s180,
          p.s240,
          c.okpo
from saldo s
join tabval$global v on v.kv = s.kv
join customer c on c.rnk = s.rnk
join v_user_allowed_branches b on b.branch = s.branch
join staff$base u on u.id = s.isp
left join specparam p on p.acc = s.acc
cross join ( select bankdate_g as bnk_dt from dual ) d
;

PROMPT *** Create  grants  V_TOBO_ACCOUNTS_LITE2 ***
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS_LITE2.sql =========*** 
PROMPT ===================================================================================== 
