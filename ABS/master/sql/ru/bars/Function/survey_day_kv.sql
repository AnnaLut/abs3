
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/survey_day_kv.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SURVEY_DAY_KV (
  quest_id_ number, -- ��. �������, ���������� ������� �������
  date_     date,   -- ���� ������������ ������
  restrict_ number, -- ��. �������, ������� ������ � �������
  ans_id_   number  -- ��. ������ �� ������ � �������
) return number
-- ���-�� ������� "��" �� ������ quest_id_ �� ���� � �������, � ������� ����� ans_id_ �� ������ restrict_
is
  num_    number;
begin
  if ans_id_ is not null -- ���������� ������
  then
     select count(s.session_id) into num_
       from survey_answer a, survey_session s
      where a.quest_id=quest_id_ and a.answer_pos=1
        and a.answer_opt=1 and a.session_id=s.session_id and trunc(date_)=trunc(s.session_date)
        and exists (select * from survey_answer a2 where a2.session_id=a.session_id
                              and quest_id=restrict_ and answer_id=ans_id_);
  else -- ��������, ������ ������ ���� �� ������
     select count(a.session_id) into num_
       from survey_answer a, survey_session s
      where a.quest_id=quest_id_ and a.answer_pos=1
        and a.answer_opt=1 and a.session_id=s.session_id and trunc(date_)=trunc(s.session_date)
        and not exists (select * from survey_answer a2 where a2.session_id=a.session_id
                                  and quest_id=restrict_);
  end if;
  return num_;
end Survey_Day_Kv;
/
 show err;
 
PROMPT *** Create  grants  SURVEY_DAY_KV ***
grant EXECUTE                                                                on SURVEY_DAY_KV   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/survey_day_kv.sql =========*** End 
 PROMPT ===================================================================================== 
 