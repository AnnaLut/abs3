

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_SBP_DETAILS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_MGR_SBP_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_MGR_SBP_DETAILS ("PRODUCT_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUM_MIN", "SUM_MAX", "SUM_INITIAL_MIN", "SUM_INITIAL_MAX", "TERM_MIN", "TERM_MAX", "CURRENCY", "INTEREST_RATE_MIN", "INTEREST_RATE_MAX", "GARANTEES", "DESCRIPTION", "DOCS", "ICO", "PRT_TPL") AS 
  select sbp."PRODUCT_ID",sbp."SUBPRODUCT_ID",sbp."SUBPRODUCT_NAME",sbp."SUM_MIN",sbp."SUM_MAX",sbp."SUM_INITIAL_MIN",sbp."SUM_INITIAL_MAX",sbp."TERM_MIN",sbp."TERM_MAX",sbp."CURRENCY",sbp."INTEREST_RATE_MIN",sbp."INTEREST_RATE_MAX",sbp."GARANTEES",sbp."DESCRIPTION",sbp."DOCS",sbp."ICO",sbp."PRT_TPL"
  from v_wcs_sbp_details sbp,
       (select distinct subproduct_id as subproduct_id
          from wcs_subproduct_branches
         where start_date <= trunc(sysdate)
           and trunc(sysdate) <= nvl(end_date, sysdate)
           and sys_context('bars_context', 'user_branch') like
               branch || decode(apply_hierarchy, 1, '%', '')) sb
 where sbp.subproduct_id = sb.subproduct_id
 order by sbp.subproduct_id;

PROMPT *** Create  grants  V_WCS_MGR_SBP_DETAILS ***
grant SELECT                                                                 on V_WCS_MGR_SBP_DETAILS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_SBP_DETAILS.sql =========*** 
PROMPT ===================================================================================== 
