begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(0, '��� ������������', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(1, '��������-�� ������ ��������� ������ ��������� � ���������� ������', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(2, '������������� ������ �������� �����', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(3, '������������� ������ ����������', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(4, '������������� ������ ���� ������� ���������', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(5, '������������� ������ �������������� �����', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(6, '�����-�� ������ �������� �������� �������� � ������-� ��������� �����', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_reorganization(id, name, open_date) values(7, '������������� ������ ������� �����', to_date('31122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/



commit;

