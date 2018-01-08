

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINT4INDIVIDUAL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_CHGINT4INDIVIDUAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_CHGINT4INDIVIDUAL ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "VIDD_CODE", "VIDD_NAME", "RATE", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "BRANCH", "BRANCH_NAME") AS 
  select d.deposit_id, d.nd, d.datz, d.dat_begin, d.dat_end,
       v.vidd, v.type_name,  acrn.fproc(d.acc, bankdate) rate,
       c.rnk, c.nmk, c.okpo, b.branch, b.name
  from dpt_deposit d, dpt_vidd v, customer c,
       dpt_vidd_flags f, dpt_vidd_scheme s, branch b
 where d.vidd = v.vidd
   and d.rnk = c.rnk
   and d.branch = b.branch
   and v.vidd = s.vidd
   and f.id = 3
   and f.id = s.flags
   and f.activity = 1
   and d.deposit_id not in (select dpt_id from v_dpt_chgintreq_active)
 ;

PROMPT *** Create  grants  V_DPT_CHGINT4INDIVIDUAL ***
grant SELECT                                                                 on V_DPT_CHGINT4INDIVIDUAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_CHGINT4INDIVIDUAL to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_CHGINT4INDIVIDUAL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINT4INDIVIDUAL.sql =========**
PROMPT ===================================================================================== 
