

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_XACLOSE_ACCOUNTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_XACLOSE_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_XACLOSE_ACCOUNTS ("BRANCH", "ACC", "NLS", "RNK", "NMK", "DATEEXPIRY", "FILE_NAME") AS 
  select a.branch, a.acc, a.nls,
       c.rnk, upper(c.nmk) nmk,
       to_char(w.dat,'yyyy-MM-dd') dateexpiry, w.file_name
  from ow_crvacc_close w, accounts a, customer c
 where w.file_name is null
   and w.acc = a.acc
   and a.rnk = c.rnk;

PROMPT *** Create  grants  V_OW_XACLOSE_ACCOUNTS ***
grant SELECT                                                                 on V_OW_XACLOSE_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_XACLOSE_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_XACLOSE_ACCOUNTS to OW;
grant SELECT                                                                 on V_OW_XACLOSE_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_XACLOSE_ACCOUNTS.sql =========*** 
PROMPT ===================================================================================== 
