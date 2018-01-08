

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_QUESTION_PARAMS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_QUESTION_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_QUESTION_PARAMS ("ID", "NAME", "TYPE_ID", "TYPE_NAME", "IS_CALCABLE", "CALC_PROC", "TEXT_LENG_MIN", "TEXT_LENG_MAX", "TEXT_VAL_DEFAULT", "TEXT_WIDTH", "TEXT_ROWS", "NMBDEC_VAL_MIN", "NMBDEC_VAL_MAX", "NMBDEC_VAL_DEFAULT", "DAT_VAL_MIN", "DAT_VAL_MAX", "DAT_VAL_DEFAULT", "LIST_SID_DEFAULT", "TAB_ID", "KEY_FIELD", "SEMANTIC_FIELD", "SHOW_FIELDS", "WHERE_CLAUSE", "REFER_SID_DEFAULT", "BOOL_VAL_DEFAULT") AS 
  select q.id,
       q.name,
       q.type_id,
       q.type_name,
       q.is_calcable,
       q.calc_proc,
       qp.text_leng_min,
       qp.text_leng_max,
       qp.text_val_default,
       qp.text_width,
       qp.text_rows,
       qp.nmbdec_val_min,
       qp.nmbdec_val_max,
       qp.nmbdec_val_default,
       qp.dat_val_min,
       qp.dat_val_max,
       qp.dat_val_default,
       qp.list_sid_default,
       qrp.tab_id,
       qrp.key_field,
       qrp.semantic_field,
       qrp.show_fields,
       qrp.where_clause,
       qp.refer_sid_default,
       qp.bool_val_default
  from v_wcs_questions q, wcs_question_params qp, wcs_question_refer_params qrp
 where q.id = qp.question_id(+)
 and q.id = qrp.question_id(+)
 order by q.id;

PROMPT *** Create  grants  V_WCS_QUESTION_PARAMS ***
grant SELECT                                                                 on V_WCS_QUESTION_PARAMS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_QUESTION_PARAMS.sql =========*** 
PROMPT ===================================================================================== 
