

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_TYPES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGREEMENTS_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGREEMENTS_TYPES ("DPT_ID", "DPT_NUM", "DPT_DAT", "BRANCH", "TYPE_ID", "TYPE_NAME", "TYPE_DESCRIPTION", "COMMISS_TT", "ONLY_ONE", "MOD_PROCEDURE", "REQUEST_TYPECODE", "USED_EBP") AS 
  SELECT d.deposit_id,
         d.nd,
         d.datz,
         d.branch,
         f.id,
         f.name,
         f.description,
         f.main_tt,
         f.only_one,
         f.mod_proc,
         f.request_typecode,
         f.used_ebp
    FROM dpt_vidd_flags  f,
         dpt_vidd_scheme s,
         dpt_deposit     d
   WHERE f.id NOT IN (1)
     AND f.id = s.flags
     AND s.vidd = d.vidd
     AND f.activity = 1
   UNION ALL
  SELECT chg.dpt_id,
         chg.dpt_nd,
         chg.dpt_date,
         chg.branch,
         f.id,
         f.name,
         f.description,
         f.main_tt,
         f.only_one,
         f.mod_proc,
         f.request_typecode,
         f.used_ebp
    FROM v_dpt_chgintreq_active chg,
         dpt_vidd_flags f,
         dpt_vidd_scheme s,
         dpt_deposit d
   WHERE f.id = 3
     AND f.id = s.flags
     AND s.vidd = d.vidd
     AND d.deposit_id = chg.dpt_id;

PROMPT *** Create  grants  V_DPT_AGREEMENTS_TYPES ***
grant SELECT                                                                 on V_DPT_AGREEMENTS_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_TYPES to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_AGREEMENTS_TYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_TYPES.sql =========***
PROMPT ===================================================================================== 
