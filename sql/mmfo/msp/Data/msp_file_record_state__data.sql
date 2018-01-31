PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_file_record_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_file_record_state (id, name)
  values (-1, '����� ����');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (0, '����� �����������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (1, '������� �� ������� ��������� ���������� �� ID-���� ��� ���� �� ����� ��������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (2, '������� �� ������� ��������� ��������� �� ϲ�');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (3, '������� �������� �� ������ ��������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (4, '������� �� ��������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (5, '�� �������� ��������� �� ������ ��� ���� �� ����� ��������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (6, '�� �������� ����� �� ������� ���');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (10, '���������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (14, '����������� ����� �������� ������ ������ ��������� ����� ��� ������ �����');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (17, '������� ��������� ��������� ���������');
exception 
  when dup_val_on_index then 
    null;
end;
/


begin
  insert into msp_file_record_state (id, name)
  values (19, '����� ������');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (20, '��������� �����');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (99, '������� ��� �����');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_file_record_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
