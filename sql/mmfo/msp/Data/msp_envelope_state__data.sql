PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_envelope_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_envelope_state (id, name, state)
  values (-1, '����� �������', 'ENVLIST_RECEIVED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (0, '������� ���������', 'PARSED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (1, '������� ��� ��� �����', 'ERROR_ECP_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (2, '������� ������������� ����� ��������', 'ERROR_DECRYPT_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (3, '������� � �������� xml', 'ERROR_XML_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (4, '������� ��� ������������� �����', 'ERROR_UNPACK_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (9, '��������� 1 � ������ ����������', 'MATCH1_PROCESSING');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (10, '��������� 2 � ������ ����������', 'MATCH2_PROCESSING');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (11, '��������� 1 ����������', 'MATCH1_CREATED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (12, '������� ��������� 1 ������� �� ���������', 'MATCH1_SIGN_WAIT');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (13, '������� ���������� ��������� 1', 'MATCH1_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (14, '��������� 1 ����������', 'MATCH1_SEND');
exception 
  when dup_val_on_index then 
    null;
end;
/


begin
  insert into msp_envelope_state (id, name, state)
  values (15, '������� ���������� �������� ��������� 1', 'MATCH1_ENV_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (16, '��������� 2 ����������', 'MATCH2_CREATED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (17, '������� ��������� 2 ������� �� ���������', 'MATCH2_SIGN_WAIT');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (18, '������� ���������� ��������� 2', 'MATCH2_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (19, '��������� 2 ����������', 'MATCH2_SEND');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (20, '������� ���������� �������� ��������� 2', 'MATCH2_ENV_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_envelope_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
