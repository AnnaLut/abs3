

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLKLBCUST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLKLBCUST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLKLBCUST ("RNK", "CUSTYPE", "NMK", "BRANCH") AS 
  select unique c.rnk, custtype, nmk, branch
 from (
       select unique rnk from bars.accounts
       where branch = sys_context('bars_context','user_branch')
       union all
       select rnk_tr from bars.dpt_trustee
       where  dpt_id in ( select deposit_id from dpt_deposit
                          where branch = sys_context('bars_context','user_branch')
                        )
       union all
       select cust_id from bars.dpt_agreements
       where branch = sys_context('bars_context','user_branch')
       union all
       select rnk from bars.customer
       where branch = sys_context('bars_context','user_branch')
      ) a, customer c
 where a.rnk  = c.rnk
 ;

PROMPT *** Create  grants  V_XMLKLBCUST ***
grant SELECT                                                                 on V_XMLKLBCUST    to KLBX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLKLBCUST.sql =========*** End *** =
PROMPT ===================================================================================== 
