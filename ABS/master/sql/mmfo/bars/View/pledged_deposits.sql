

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PLEDGED_DEPOSITS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view PLEDGED_DEPOSITS ***

  CREATE OR REPLACE FORCE VIEW BARS.PLEDGED_DEPOSITS ("ND", "ACCS", "RNK", "DPT_ID") AS 
  select c.nd, c.accs, a.rnk, pa.deposit_id
  from accounts a,
       cc_accp  c,
       pawn_acc pa,
       cc_pawn  pc
 where a.nbs = '9500'
   and a.dazs is null
   and c.acc = a.acc
   and c.acc = pa.acc
   and pc.pawn = pa.pawn
   and pc.s031 in ('15','18');

PROMPT *** Create  grants  PLEDGED_DEPOSITS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PLEDGED_DEPOSITS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PLEDGED_DEPOSITS to DPT_ROLE;
grant SELECT                                                                 on PLEDGED_DEPOSITS to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PLEDGED_DEPOSITS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PLEDGED_DEPOSITS.sql =========*** End *
PROMPT ===================================================================================== 
