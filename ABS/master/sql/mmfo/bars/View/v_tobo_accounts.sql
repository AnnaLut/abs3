create or replace force view V_TOBO_ACCOUNTS
( ACC, NLS, NLSALT, KV, KF, BRANCH, NBS, NBS2, DAOS, DAPP, ISP, RNK, NMS
, LIM, OSTB, OSTC, OSTF, OSTQ, OSTX, DOS, KOS, DOSQ, KOSQ, PAP, TIP, VID
, TRCN, MDATE, DAZS, SEC, ACCC, BLKD, BLKK, POS, SECI, SECO, GRP, TOBO, LCV
, DIG, DENOM, OST, OB22, NOTIFIER_REF, BDATE, OPT, DAPPQ
, INTACCN
, FIO
, R011
, R013
, S180
, S240
, OKPO
) AS
SELECT a.acc,
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
       decode (s.fdat, gl.bd(), s.ostf, s.ostf - s.dos + s.kos) as ostc,    -- остаток исходящий
       a.ostf,
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
       s.ostf - s.dos + s.kos as ost, -- вхідний залишок
       a.ob22,
       a.notifier_ref,
       a.bdate,
       a.opt,
       a.DAPPQ,
       cast( null as number ) as INTACCN,
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
cross join table(account_utl.pipe_saldo_line(a.acc, gl.bd)) s
left join specparam p on p.acc = a.acc;


show err

grant SELECT on V_TOBO_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT on V_TOBO_ACCOUNTS to WR_ALL_RIGHTS;
grant SELECT on V_TOBO_ACCOUNTS to WR_CUSTLIST;
grant SELECT on V_TOBO_ACCOUNTS to WR_TOBO_ACCOUNTS_LIST;
grant SELECT on V_TOBO_ACCOUNTS to WR_VIEWACC;
