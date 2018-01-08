

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_ACC_LIMIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_ACC_LIMIT ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_ACC_LIMIT ("BRANCH", "ACC", "NLS", "KV", "PAP", "NMK", "STATUS", "LIM", "PC_LIM", "FLAG") AS 
  select a.branch, a.acc, a.nls, a.kv,
       decode(a.pap,1,'À',2,'Ï','À/Ï') pap,
       c.nmk, b.status, a.lim/100 lim,
       decode(a.pap,2,decode(sign(b.crd), 1, b.crd, 0),
                     -decode(sign(b.crd), 1, b.crd, 0)) pc_lim, 0 flag
  from obpc_acct b, accounts a, customer c
 where b.id = ( select max(id) from obpc_files )
   and b.status in (0,1,3)
   and b.acc = a.acc
   and a.dazs is null
   and a.lim <> decode(a.pap,2,decode(sign(b.crd), 1, b.crd*100, 0),
                              -decode(sign(b.crd), 1, b.crd*100, 0))
   and a.rnk = c.rnk;

PROMPT *** Create  grants  OBPC_ACC_LIMIT ***
grant SELECT                                                                 on OBPC_ACC_LIMIT  to BARSREADER_ROLE;
grant SELECT                                                                 on OBPC_ACC_LIMIT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ACC_LIMIT  to OBPC;
grant SELECT                                                                 on OBPC_ACC_LIMIT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_ACC_LIMIT.sql =========*** End ***
PROMPT ===================================================================================== 
