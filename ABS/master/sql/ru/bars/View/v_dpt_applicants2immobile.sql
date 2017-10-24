

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_APPLICANTS2IMMOBILE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_APPLICANTS2IMMOBILE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_APPLICANTS2IMMOBILE ("DPT_ID", "DPT_NUM", "DPT_SUM", "DPT_CUR", "CUST_NAME", "DPT_DAT", "DAT_BEGIN", "DAT_END", "BRANCH", "COMMENTS", "DAPP") AS 
  select d.deposit_id, d.nd, a.ostc/100, d.kv, c.nmk, d.datz, d.dat_begin, d.dat_end, d.branch, comments, a.dapp
    from DPT_DEPOSIT d,
         ( select max(fdat) as dat from fdat where fdat <= add_months(bankdate, -36) ) f,
         CUSTOMER c,
         ACCOUNTS a
   where d.branch like sys_context('bars_context', 'user_branch_mask')
     and not exists( select 1 from DPT_IMMOBILE n where n.dpt_id = d.deposit_id )
     and ( ( d.dat_end < f.dat )
        or ( d.datZ <= f.dat
       and d.dat_end is null
       and d.kv not in (959, 961, 962) -- не банк.метали
       and Not exists ( select 1 from SALDOA s
                         where s.acc = d.acc
                           and s.fdat > f.dat
                           and (s.kos > 0 or s.dos > 0) ) ) )
     and c.rnk = d.rnk
     and a.acc = d.acc
     and a.blkD = 0;

PROMPT *** Create  grants  V_DPT_APPLICANTS2IMMOBILE ***
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to START1;
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_APPLICANTS2IMMOBILE.sql =========
PROMPT ===================================================================================== 
