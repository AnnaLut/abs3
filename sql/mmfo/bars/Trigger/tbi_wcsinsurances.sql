

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_WCSINSURANCES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_WCSINSURANCES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_WCSINSURANCES 
  before insert on wcs_insurances
  for each row
declare
  l_count_qid  wcs_questions.id%type;
  l_status_qid wcs_questions.id%type;
begin
  -- добавляем вопрос количество договоров страховок даного типа
  l_count_qid := :new.id || wcs_pack.g_ins_count_prefix;
  wcs_pack.quest_set(l_count_qid,
                     '(Системный) Количество договоров страховок типа ' ||
                     :new.id,
                     'NUMB',
                     0,
                     null);
  :new.count_qid := l_count_qid;

  -- добавляем вопрос состояние договора обеспечения даного типа
  l_status_qid := :new.id || wcs_pack.g_ins_status_prefix;
  wcs_pack.quest_set(l_status_qid,
                     '(Системный) Статус договора страховки типа ' ||
                     :new.id,
                     'LIST',
                     0,
                     null);

  wcs_pack.quest_list_item_set(l_status_qid, 0, 'Новий', 1);
  wcs_pack.quest_list_item_set(l_status_qid,
                               1,
                               'Заповнення анкети',
                               1);
  wcs_pack.quest_list_item_set(l_status_qid, 2, 'Заведено', 1);
  :new.status_qid := l_status_qid;
end tbi_wcsinsurances;



/
ALTER TRIGGER BARS.TBI_WCSINSURANCES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_WCSINSURANCES.sql =========*** E
PROMPT ===================================================================================== 
