begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('0', '��� ������������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('1', '��������-�� ������ ��������� ������ ��������� � ���������� ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('2', '������������� ������ �������� �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('3', '������������� ������ ����������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('4', '������������� ������ ���� ������� ���������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('5', '������������� ������ �������������� �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('6', '�����-�� ������ �������� �������� �������� � ������-� ��������� �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('7', '������������� ������ ������� �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, D_OPEN) values('#', '����� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/



commit;

