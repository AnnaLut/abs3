PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_file_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_file_state (id, name, state)
  values (-1, '����� ����', 'NEW');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (1, '���������� �������', 'IN_PARSE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (2, '������� ��������', 'PARSE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (3, '���� ���������', 'PARSED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (4, '���������� ��������', 'IN_CHECK');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (5, '�������� ������� ��������', 'CHECK_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (0, '���������', 'CHECKED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (6, '����� ������', 'CHECKING_PAY');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (7, '���������', 'CHECKED2');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (8, '� ������ ������', 'IN_PAY');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (9, '��������', 'PAYED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (10, '�������', 'ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/


commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_file_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
