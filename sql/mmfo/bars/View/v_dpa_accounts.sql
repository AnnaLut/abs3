

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPA_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPA_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPA_ACCOUNTS ("FN", "DAT", "N", "NLS", "KV", "ODATE", "OTYPE", "NMKK", "FN_R", "DATE_R", "ERR", "DAT_IN_DPA", "DAT_ACC_DPA", "ID_PR", "OKPO") AS 
  select l.fn, l.dat, l.n, l.nls, l.kv, l.odate, l.otype, l.nmkk,
       l.fn_r, l.date_r, l.err, l.dat_in_dpa, l.dat_acc_dpa, l.id_pr,
       c.OKPO
from  lines_f l, accounts a, customer c
where l.nls = a.nls and l.kv  = a.kv
  and a.RNK=c.RNK
  and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_DPA_ACCOUNTS ***
grant SELECT                                                                 on V_DPA_ACCOUNTS  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPA_ACCOUNTS  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPA_ACCOUNTS  to RPBN002;
grant SELECT                                                                 on V_DPA_ACCOUNTS  to UPLD;
grant FLASHBACK,SELECT                                                       on V_DPA_ACCOUNTS  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPA_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
