

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCOR_MAIN_QUESTIONS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCOR_MAIN_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCOR_MAIN_QUESTIONS ("BID_ID", "QUESTION_ID", "NAME", "SCORE", "VALUE", "SCORE_C", "VALUE_C", "ORD") AS 
  select distinct b.id as bid_id,
       sd.question_id,
       sd.name,
       to_char(nvl(round(wcs_utl.get_score(b.id, ss.scoring_id, sd.question_id), 3),0),'999990D999') as score,
       ltrim((case when sd.type_id = 'LIST' then nvl((select text from wcs_question_list_items where question_id = sd.question_id and ord = wcs_utl.get_answ_list(b.id,sd.question_id)),'<none>')
             else to_char(nvl(round(wcs_utl.get_answ(b.id,sd.question_id),3),0),'999990D999')
        end)) as value,
       (case when sd.ord <= (select ord from v_wcs_scoring_questions_disp sdc where sdc.question_id = 'MPK') and sd.question_id not in ('KPS','4PS','P4DS') then
       to_char(nvl(round(wcs_utl.get_score(b.id, ss.scoring_id, sd.question_id||'_C'), 3),0),'999990D999')
             when sd.question_id in ('KPS','4PS','P4DS') then 'X' end) as score_c,
       (case when sd.ord <= (select ord from v_wcs_scoring_questions_disp sdc where sdc.question_id = 'MPK') and sd.question_id not in ('KPS','4PS','P4DS') then
       ltrim((case when sd.type_id = 'LIST' then nvl((select text from wcs_question_list_items where question_id = sd.question_id||'_C' and ord = wcs_utl.get_answ_list(b.id,sd.question_id||'_C')),'<none>')
             else to_char(nvl(round(wcs_utl.get_answ(b.id,sd.question_id||'_C'),3),0),'999990D999')
        end))
             when sd.question_id in ('KPS','4PS','P4DS') then 'X' end) as value_c,
       sd.ord
  from wcs_bids b,
       wcs_subproduct_scoring ss,
       v_wcs_scoring_questions_disp sd
 where b.subproduct_id = ss.subproduct_id;

PROMPT *** Create  grants  V_WCS_SCOR_MAIN_QUESTIONS ***
grant SELECT                                                                 on V_WCS_SCOR_MAIN_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCOR_MAIN_QUESTIONS.sql =========
PROMPT ===================================================================================== 
