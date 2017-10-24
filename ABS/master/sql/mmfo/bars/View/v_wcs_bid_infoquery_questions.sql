

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INFOQUERY_QUESTIONS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_INFOQUERY_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_INFOQUERY_QUESTIONS ("BID_ID", "IQUERY_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "TYPE_NAME", "IS_CALCABLE", "IS_REQUIRED", "IS_CHECKABLE", "CHECK_PROC", "ORD") AS 
  select b.id           as bid_id,
       iq.iquery_id,
       iq.question_id,
       q.name         as question_name,
       q.type_id,
       qt.name        as type_name,
       q.is_calcable,
       iq.is_required,
       iq.is_checkable,
       iq.check_proc,
       iq.ord
  from wcs_bids                   b,
       wcs_subproduct_infoqueries si,
       wcs_infoquery_questions    iq,
       wcs_questions              q,
       wcs_question_types         qt
 where b.subproduct_id = si.subproduct_id
   and si.iquery_id = iq.iquery_id
   and iq.question_id = q.id
   and q.type_id = qt.id
 order by b.id, iq.iquery_id, iq.ord;

PROMPT *** Create  grants  V_WCS_BID_INFOQUERY_QUESTIONS ***
grant SELECT                                                                 on V_WCS_BID_INFOQUERY_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INFOQUERY_QUESTIONS.sql =====
PROMPT ===================================================================================== 
