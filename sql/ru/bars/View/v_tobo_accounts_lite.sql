

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS_LITE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_ACCOUNTS_LITE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_ACCOUNTS_LITE ("ACC", "NLS", "NLSALT", "KV", "LCV", "DIG", "DENOM", "KF", "BRANCH", "TOBO", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "RNK", "NMS", "LIM", "OST", "OSTB", "OSTC", "OSTF", "OSTQ", "OSTX", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OB22", "NOTIFIER_REF", "BDATE", "OPT") AS 
  select 	/*+index(a i5_accounts)*/
			a.acc,
			a.nls,
			a.nlsalt,
			a.kv,
            v.lcv,
			v.dig,
            v.denom,
            a.kf,
            a.branch,
            a.tobo,
			a.nbs,
			a.nbs2,
			a.daos,
			a.dapp,
			a.isp,
			a.rnk,
			a.nms,
			a.lim,
            decode(a.dapp, b.bd, a.ostc+a.dos-a.kos, a.ostc) as ost, -- остаток входящий
			a.ostb,
			a.ostc, -- остаток исходящий
			a.ostf,
			a.ostq,
			a.ostx,
            decode(a.dapp, b.bd, a.dos, 0) dos,
			decode(a.dapp, b.bd, a.kos, 0) kos,
			decode(a.dapp, b.bd, a.dosq, 0) dosq,
			decode(a.dapp, b.bd, a.kosq, 0) kosq,
			a.pap,
			a.tip,
			a.vid,
			decode(a.dapp, b.bd, a.trcn, 0) trcn,
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
			a.ob22,
			a.notifier_ref,
			a.bdate,
			a.opt
	from accounts a, (select bankdate_g bd from dual) b, saldo s,
        tabval$global v
	where a.kv = v.kv and a.acc=s.acc and
          a.branch like sys_context('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_TOBO_ACCOUNTS_LITE ***
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TOBO_ACCOUNTS_LITE to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to WR_CUSTLIST;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on V_TOBO_ACCOUNTS_LITE to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_ACCOUNTS_LITE.sql =========*** E
PROMPT ===================================================================================== 
