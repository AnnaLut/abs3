

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_BAD_ODB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_BAD_ODB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_BAD_ODB ("BRANCH", "RNK", "ID_A", "CLIENT_N", "DAOS", "LACCT", "CURR", "ACC_TYPE", "COND_SET", "BRN", "KK", "WORK", "PCODE", "CITY", "STREET", "OFFICE", "NAME", "M_NAME") AS 
  select branch, rnk, ID_A, CLIENT_N, daos, LACCT, CURR,
       ACC_TYPE, COND_SET, BRN, KK,
       WORK, PCODE, CITY, STREET, OFFICE,
       NAME, M_NAME
  from v_bpk_odb v
 where flag_odb = 0
   and (   cond_set is null
        or brn      is null
        or kk       is null
        or work     is null
        or pcode    is null
        or city     is null
        or street   is null
        or office   is null
        or name     is null
        or m_name   is null )
   and branch like sys_context ('bars_context', 'user_branch_mask')
   and not exists (select 1 from obpc_acct where acc = v.acc);

PROMPT *** Create  grants  V_BPK_BAD_ODB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_BAD_ODB   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BPK_BAD_ODB   to OBPC;
grant FLASHBACK,SELECT                                                       on V_BPK_BAD_ODB   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_BAD_ODB.sql =========*** End *** 
PROMPT ===================================================================================== 
