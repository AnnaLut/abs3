

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_QUESTION_LIST_ITEMS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_QUESTION_LIST_ITEMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_QUESTION_LIST_ITEMS ("QUESTION_ID", "ORD", "TEXT", "DESCR", "VISIBLE", "VISIBLE_ORD", "IS_DEF") AS 
  select qli.question_id,
       qli.ord,
       qli.text,
       qli.ord || ' - ' || qli.text as descr,
       qli.visible,
       qli.visible_ord,
       (select count(*)
          from wcs_question_params qp
         where qp.question_id = qli.question_id
           and qp.list_sid_default = qli.ord) is_def
  from wcs_question_list_items qli
 order by qli.question_id, qli.visible_ord;

PROMPT *** Create  grants  V_WCS_QUESTION_LIST_ITEMS ***
grant SELECT                                                                 on V_WCS_QUESTION_LIST_ITEMS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_QUESTION_LIST_ITEMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_QUESTION_LIST_ITEMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_QUESTION_LIST_ITEMS.sql =========
PROMPT ===================================================================================== 
