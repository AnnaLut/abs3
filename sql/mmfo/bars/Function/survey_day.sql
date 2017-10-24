
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/survey_day.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SURVEY_DAY (
  quest_id_ number, -- ид. вопроса
  date_     date    -- дата формирования отчета
) return number
-- кол-во ответов "да" на вопрос за день
is
  num_    number;
begin
  select count(a.session_id) into num_
    from survey_answer a, survey_session s
   where a.quest_id=quest_id_ and a.answer_pos=1
     and a.answer_opt=1 and a.session_id=s.session_id and trunc(date_)=trunc(s.session_date);
  return num_;
end Survey_Day;
 
/
 show err;
 
PROMPT *** Create  grants  SURVEY_DAY ***
grant EXECUTE                                                                on SURVEY_DAY      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/survey_day.sql =========*** End ***
 PROMPT ===================================================================================== 
 