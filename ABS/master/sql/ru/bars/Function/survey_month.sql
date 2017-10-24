
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/survey_month.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SURVEY_MONTH (
  quest_id_ number, -- ид. вопроса
  date_     date    -- дата формировани€ отчета (за мес€ц, содерж.день)
) return number
-- кол-во ответов "да" на вопрос за мес€ц
is
  num_    number;
  days_   number;
begin
  select count(a.session_id) into num_
    from survey_answer a, survey_session s
   where a.quest_id=quest_id_ and a.answer_pos=1
     and a.answer_opt=1 and a.session_id=s.session_id and trunc(date_,'MONTH')=trunc(s.session_date,'MONTH');
  select extract(day from last_day(date_)) into days_ from dual;
  return num_/days_;
end Survey_Month;
/
 show err;
 
PROMPT *** Create  grants  SURVEY_MONTH ***
grant EXECUTE                                                                on SURVEY_MONTH    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/survey_month.sql =========*** End *
 PROMPT ===================================================================================== 
 