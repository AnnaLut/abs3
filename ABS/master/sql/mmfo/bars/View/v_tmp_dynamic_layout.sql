

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMP_DYNAMIC_LAYOUT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMP_DYNAMIC_LAYOUT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMP_DYNAMIC_LAYOUT ("ND", "DATD", "DK", "SUMM", "KV_A", "NLS_A", "OSTC", "NMS", "NAZN", "DATE_FROM", "DATE_TO", "DATES_TO_NAZN", "CORRECTION", "REF", "TYPED_PERCENT", "TYPED_SUMM", "BRANCH_COUNT", "USERID") AS 
  select
  v.nd,
  v.datd,
  v.dk,
  v.summ/100 summ,
  v.kv_a,
  v.nls_a,
  v.ostc/100 ostc,
  v.nms,
  v.nazn,
  v.date_from,
  v.date_to,
  v.dates_to_nazn,
  v.correction,
  v.ref,
  v.typed_percent,
  v.typed_summ/100 typed_summ,
  v.branch_count,
  v.userid
from bars.tmp_dynamic_layout v
where  v.userid = bars.user_id;

PROMPT *** Create  grants  V_TMP_DYNAMIC_LAYOUT ***
grant SELECT                                                                 on V_TMP_DYNAMIC_LAYOUT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMP_DYNAMIC_LAYOUT.sql =========*** E
PROMPT ===================================================================================== 
