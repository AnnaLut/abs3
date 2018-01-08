

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_BAD_TRAN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_BAD_TRAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_BAD_TRAN ("ID", "FILE_NAME", "FILE_DATE", "BRANCH", "TRAN_TYPE", "TRAN_NAME", "N") AS 
  select t.id, f.file_name, f.file_date, n.branch, t.tran_type, t.tran_russ, count(*)
  from obpc_tran t, obpc_acct a, accounts n, obpc_files f
 where t.card_acct = a.card_acct(+) and a.acc = n.acc(+)
   and t.id = f.id
   and f.arc = 0
   and ( sys_context('bars_context', 'user_branch') = '/' || sys_context('bars_context', 'user_mfo') || '/'
      or n.branch like sys_context ('bars_context', 'user_branch_mask') )
 group by t.id, file_name, file_date, n.branch, t.tran_type, t.tran_russ;

PROMPT *** Create  grants  V_OBPC_BAD_TRAN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_BAD_TRAN to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_BAD_TRAN to OBPC;
grant FLASHBACK,SELECT                                                       on V_OBPC_BAD_TRAN to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_BAD_TRAN.sql =========*** End **
PROMPT ===================================================================================== 
