begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('0', '������������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('2', '�������� (��������)', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('3', '�i�������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('4', '�������� ������� �� ������� ����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into CIM_CREDIT_PERCENT(id, name, d_open) values('#', '����� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
