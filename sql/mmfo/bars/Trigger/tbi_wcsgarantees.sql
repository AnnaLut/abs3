

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_WCSGARANTEES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_WCSGARANTEES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_WCSGARANTEES 
  before insert on wcs_garantees
  for each row
declare
  l_ws_id   wcs_workspaces.id%type := 'GRT_' || :new.id;
  l_ws_name wcs_workspaces.name%type := '������������ "' || :new.name || '"';

  l_count_qid  wcs_questions.id%type;
  l_status_qid wcs_questions.id%type;
begin
  -- ������� ������������
  begin
    insert into wcs_workspaces (id, name) values (l_ws_id, l_ws_name);
  exception
    when dup_val_on_index then
      null;
  end;
  :new.ws_id := l_ws_id;

  -- ��������� ������ ���������� ��������� ����������� ������ ����
  l_count_qid := :new.id || wcs_pack.g_grt_count_prefix;
  wcs_pack.quest_set(l_count_qid,
                     '(���������) ���������� ��������� ����������� ���� ' ||
                     :new.id,
                     'NUMB',
                     0,
                     null);
  :new.count_qid := l_count_qid;

  -- ��������� ������ ��������� �������� ����������� ������ ����
  l_status_qid := :new.id || wcs_pack.g_grt_status_prefix;
  wcs_pack.quest_set(l_status_qid,
                     '(���������) ������ �������� ����������� ���� ' ||
                     :new.id,
                     'LIST',
                     0,
                     null);

  wcs_pack.quest_list_item_set(l_status_qid, 0, '�����', 1);
  wcs_pack.quest_list_item_set(l_status_qid, 1, '����������', 1);
  wcs_pack.quest_list_item_set(l_status_qid, 2, '���������� ������ (���������)', 1);
  wcs_pack.quest_list_item_set(l_status_qid, 3, '���������� ������ (���������)', 1);
  wcs_pack.quest_list_item_set(l_status_qid, 4, '������� ��������', 1);
  wcs_pack.quest_list_item_set(l_status_qid, 5, '��������', 1);
  :new.status_qid := l_status_qid;
end tbi_wcsgarantees;



/
ALTER TRIGGER BARS.TBI_WCSGARANTEES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_WCSGARANTEES.sql =========*** En
PROMPT ===================================================================================== 
