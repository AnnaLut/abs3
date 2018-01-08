

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_BAD_OST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_BAD_OST ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_BAD_OST ("BRANCH", "NMK", "NLS", "OST_PC", "OST_OB", "DELTA") AS 
  select t.branch, t.nmk, t.nls, a.ost_pc, t.ost, a.ost_pc-t.ost delta
  from ( select s.branch, c.nmk, s.acc, s.nls,
                ( s.ostc
                + decode (o.acc_ovr,  null, 0, a_ovr.ostc)
                + decode (o.acc_3570, null, 0, a_3570.ostc)
                + decode (o.acc_2208, null, 0, a_2208.ostc)
                + decode (o.acc_2207, null, 0, a_2207.ostc)
                + decode (o.acc_3579, null, 0, a_3579.ostc)
                + decode (o.acc_2209, null, 0, a_2209.ostc) ) / 100 ost
           from accounts s, bpk_acc o, customer c,
                accounts a_ovr,  accounts a_3570, accounts a_2208,
                accounts a_2207, accounts a_3579, accounts a_2209
          where s.acc = o.acc_pk
            and s.rnk = c.rnk
            and s.branch like sys_context ('bars_context', 'user_branch_mask')
            and o.acc_ovr  = a_ovr.acc(+)
            and o.acc_3570 = a_3570.acc(+)
            and o.acc_2208 = a_2208.acc(+)
            and o.acc_2207 = a_2207.acc(+)
            and o.acc_3579 = a_3579.acc(+)
            and o.acc_2209 = a_2209.acc(+) ) t,
       ( select acc, sum(end_bal) ost_pc
           from obpc_acct
          group by acc ) a
 where a.acc = t.acc
   and a.ost_pc <> t.ost;

PROMPT *** Create  grants  OBPC_BAD_OST ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_BAD_OST    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_BAD_OST    to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_BAD_OST    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_BAD_OST.sql =========*** End *** =
PROMPT ===================================================================================== 
