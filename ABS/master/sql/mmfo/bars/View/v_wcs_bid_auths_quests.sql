

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_AUTHS_QUESTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_AUTHS_QUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_AUTHS_QUESTS ("BID_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "SCOPY_QID", "IS_REQUIRED", "IS_CHECKABLE", "CHECK_PROC", "IS_CALCABLE") AS 
  select b.id            as bid_id,
       aq.question_id,
       q.name          as question_name,
       q.type_id,
       aq.scopy_qid,
       aq.is_required,
       aq.is_checkable,
       aq.check_proc,
       q.is_calcable
  from wcs_bids                      b,
       wcs_subproduct_authorizations sa,
       wcs_authorization_questions   aq,
       wcs_questions                 q
 where b.subproduct_id = sa.subproduct_id
   and sa.auth_id = aq.auth_id
   and aq.question_id = q.id
 order by b.id, aq.ord;

PROMPT *** Create  grants  V_WCS_BID_AUTHS_QUESTS ***
grant SELECT                                                                 on V_WCS_BID_AUTHS_QUESTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_AUTHS_QUESTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_AUTHS_QUESTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_AUTHS_QUESTS.sql =========***
PROMPT ===================================================================================== 
