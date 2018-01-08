

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMP_DYNAMIC_LAYOUT_DETAIL.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMP_DYNAMIC_LAYOUT_DETAIL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMP_DYNAMIC_LAYOUT_DETAIL ("ID", "ND", "KV", "BRANCH", "BRANCH_NAME", "NLS_A", "NLS_B", "PERCENT", "SUMM_A", "SUMM_B", "NLS_COUNT", "USERID") AS 
  select
  v.id,
  v.nd,
  v.kv,
  v.branch,
  v.branch_name,
  v.nls_a,
  v.nls_b,
  v.percent,
  v.summ_a/100 summ_a,
  v.summ_b/100 summ_b,
  v.nls_count,
  v.userid
from bars.tmp_dynamic_layout_detail v
where  v.userid = bars.user_id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMP_DYNAMIC_LAYOUT_DETAIL.sql =======
PROMPT ===================================================================================== 
