begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('1', '������������ ����������, �������������, ����������� �������, ��������� �ᒺ��� ����������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('2', '������������ ���������� � ����������� ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('3', '������� ��������� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('4', '������� ������� �� ������������, ������������ ��������, � ���� ���� ���������, �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('5', '�������������� �������� �������������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('6', '���������� ��������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('7', '��������� ������ ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('8', '������������ ���������� ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('9', '������������ ����� ���������� ������, ������ ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('10', '����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/


begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('11', '���������� ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('12', '�������������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name, d_open) values('#', '����� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
commit;

