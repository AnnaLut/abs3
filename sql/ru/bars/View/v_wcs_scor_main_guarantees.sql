

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCOR_MAIN_GUARANTEES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCOR_MAIN_GUARANTEES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCOR_MAIN_GUARANTEES ("BID_ID", "GARANTEE_NUM", "QUESTION_ID", "SCORE", "VALUE", "ORD") AS 
  select bg.bid_id,
       bg.garantee_num,
       sq.question_id,
       to_char(nvl(round(wcs_utl.get_score(b.id, ss.scoring_id, sq.question_id, bg.ws_id, bg.garantee_num), 3),0),'999990D999') as score,
       ltrim((case when sq.type_id = 'LIST' then nvl((select text from wcs_question_list_items where question_id = sq.question_id and ord = wcs_utl.get_answ_list(b.id,sq.question_id,bg.ws_id,bg.garantee_num)),'<none>')
             else to_char(nvl(round(wcs_utl.get_answ(b.id,sq.question_id,bg.ws_id,bg.garantee_num),3),0),'999990D999')
        end)) as value,
       sq.ord
  from v_wcs_bid_garantees bg,
       wcs_bids b,
       wcs_subproduct_scoring ss,
       v_wcs_scoring_questions_disp sq
 where bg.bid_id = b.id
   and b.subproduct_id = ss.subproduct_id
   and wcs_utl.get_answ_list(bid_id,'GRT_2_20',ws_id,garantee_num) = 0;

PROMPT *** Create  grants  V_WCS_SCOR_MAIN_GUARANTEES ***
grant SELECT                                                                 on V_WCS_SCOR_MAIN_GUARANTEES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCOR_MAIN_GUARANTEES.sql ========
PROMPT ===================================================================================== 
