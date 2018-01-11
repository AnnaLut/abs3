

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS_LITE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_ACCOUNTS_LITE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_ACCOUNTS_LITE ("ACC", "NLS", "NLSALT", "KV", "LCV", "DIG", "DENOM", "KF", "BRANCH", "TOBO", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OST", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OB22", "NOTIFIER_REF", "BDATE", "OPT", "DAPPQ", "INTACCN", "FIO", "R011", "R013", "S180", "S240", "OKPO") AS 
  select s.acc,
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
       decode(s.dapp, d.bnk_dt, s.ostc + s.dos - s.kos, s.ostc) as ost, -- остаток входящий
       s.ostb,
       s.ostc,        -- остаток исходящий
       s.ostf,
       s.ostq,
       s.ostx,
       decode( s.dapp, d.bnk_dt, s.dos,  0 ) dos,
       decode( s.dapp, d.bnk_dt, s.kos,  0 ) kos,
       decode( s.dapp, d.bnk_dt, s.dosq, 0 ) dosq,
       decode( s.dapp, d.bnk_dt, s.kosq, 0 ) kosq,
       s.pap,
       s.tip,
       s.vid,
       decode( s.dapp, d.bnk_dt, s.trcn, 0 ) trcn,
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
       acrn.fprocn( s.acc, decode( s.pap,  1, 0,  2, 1,  1 ), d.bnk_dt ) intaccn,
       (select u.fio from staff$base u where u.id = s.isp) fio,
       p.r011,
       p.r013,
       p.s180,
       p.s240,
       c.okpo
from   saldo s
join   customer c on ( c.rnk = s.rnk )
join   tabval$global v on ( v.kv = s.kv )
left join specparam p on ( p.acc = s.acc )
cross join ( select bankdate_g as bnk_dt from dual ) d
where s.branch in (select b.branch from v_user_allowed_branches b);

PROMPT *** Create  grants  V_TOBO_ACCOUNTS_LITE ***
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to BARSREADER_ROLE;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TOBO_ACCOUNTS_LITE to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to WR_CUSTLIST;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS_LITE.sql =========*** E
PROMPT ===================================================================================== 
