create or replace view v_tobo_accounts_lite as
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

show err

grant select on bars.v_tobo_accounts_lite to bars_access_defrole;
grant select on bars.v_tobo_accounts_lite to wr_all_rights;
grant select on bars.v_tobo_accounts_lite to wr_custlist;
grant select on bars.v_tobo_accounts_lite to wr_tobo_accounts_list;
grant select on bars.v_tobo_accounts_lite to wr_viewacc;

