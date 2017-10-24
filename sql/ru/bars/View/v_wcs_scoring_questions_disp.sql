

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QUESTIONS_DISP.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORING_QUESTIONS_DISP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORING_QUESTIONS_DISP ("QUESTION_ID", "NAME", "TYPE_ID", "ORD") AS 
  select sq.question_id,
       q.name,
       q.type_id,
       sq.ord
  from wcs_scoring_questions sq,
       wcs_questions q
 where sq.question_id = q.id
   and sq.scoring_id not like '%BPK%'
   and not regexp_like(sq.question_id,'+(_C)')
union
select q.id as question_id,
       (case when q.id = 'S' then 'Ñ1'
             when q.id = 'S2' then 'Ñ2'
             when q.id in ('C1','C2','PVB','PVF','MPK','PRM') then q.name
        end) as name,
        q.type_id,
       (case when q.id = 'C1' then 18
             when q.id = 'C2' then 19
             when q.id = 'S' then 20
             when q.id = 'S2' then 21
             when q.id = 'PVB' then 22
             when q.id = 'PVF' then 23
             when q.id = 'MPK' then 7
             when q.id = 'PRM' then 24
        end) as ord
  from wcs_questions q
 where q.id in('C1','C2','S','S2','PVB','PVF','MPK','PRM');

PROMPT *** Create  grants  V_WCS_SCORING_QUESTIONS_DISP ***
grant SELECT                                                                 on V_WCS_SCORING_QUESTIONS_DISP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QUESTIONS_DISP.sql ======
PROMPT ===================================================================================== 
