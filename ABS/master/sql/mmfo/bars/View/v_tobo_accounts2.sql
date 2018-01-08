

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_ACCOUNTS2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_ACCOUNTS2 ("ACC", "NLS", "NLSALT", "KV", "KF", "BRANCH", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "TOBO", "LCV", "DIG", "DENOM", "OST", "OB22", "NOTIFIER_REF", "BDATE", "OPT", "DAPPQ", "FIO", "R011", "R013", "S180", "S240", "OKPO") AS 
  select a.acc,
       a.nls,
       a.nlsalt,
       a.kv,
       a.kf,
       a.branch,
       a.nbs,
       a.nbs2,
       a.daos,
       a.dapp,
       a.isp,
       a.rnk,
       a.nms,
       a.lim,
       a.ostb,
       s.ostf - s.dos + s.kos as ostc,    -- остаток исходящий
       decode (s.fdat, gl.bd(), s.ostf, s.ostf - s.dos + s.kos) ostf,
       a.ostq,
       a.ostx,
       decode (s.fdat, gl.bd(), s.dos, 0) dos,
       decode (s.fdat, gl.bd(), s.kos, 0) kos,
       a.dosq,
       a.kosq,
       a.pap,
       a.tip,
       a.vid,
       a.trcn,
       a.mdate,
       a.dazs,
       a.sec,
       a.accc,
       a.blkd,
       a.blkk,
       a.pos,
       a.seci,
       a.seco,
       a.grp,
       a.tobo,
       v.lcv,
       v.dig,
       v.denom,
       s.ostf as ost,
       a.ob22,
       a.notifier_ref,
       a.bdate,
       a.opt,
       a.dappq,
       u.fio,
       p.r011,
       p.r013,
       p.s180,
       p.s240,
       c.okpo
from   accounts a
join   tabval$global v on v.kv = a.kv
join   customer c on c.rnk = a.rnk
join   v_user_allowed_branches b on b.branch = a.branch
join   staff$base u on u.id = a.isp
cross join table(saldo_utl.pipe_saldo_line(a.acc, gl.bd)) s
left join specparam p on p.acc = a.acc
;

PROMPT *** Create  grants  V_TOBO_ACCOUNTS2 ***
grant SELECT                                                                 on V_TOBO_ACCOUNTS2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS2.sql =========*** End *
PROMPT ===================================================================================== 
