

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KLBX_ACTIVE_BRANCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KLBX_ACTIVE_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KLBX_ACTIVE_BRANCH ("BRANCH", "RNK", "NAME", "SAB", "TECH_KEY", "ISACTIVE") AS 
  select bp.branch, c.rnk, c.nmk, sab, tech_key, isactive
    from branch_parameters bp,
         kl_customer_params k,
	 customer c
   where tag = 'RNK' and k.rnk = bp.val and k.rnk = c.rnk and isactive = 1;

PROMPT *** Create  grants  V_KLBX_ACTIVE_BRANCH ***
grant REFERENCES,SELECT                                                      on V_KLBX_ACTIVE_BRANCH to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on V_KLBX_ACTIVE_BRANCH to BARSAQ_ADM with grant option;
grant SELECT                                                                 on V_KLBX_ACTIVE_BRANCH to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_KLBX_ACTIVE_BRANCH to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KLBX_ACTIVE_BRANCH.sql =========*** E
PROMPT ===================================================================================== 
