begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('1', '����� - ��������� �������� �� ����������, �� ��������� ��������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('2', 'ϳ��������� � ���������� ������������, ��� �� �������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('3', '���� ������������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('4', 'ϳ���������, �� ������������� ��������� ���������� (�������)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('5', 'Գ����� ����� - ���''��� ������������ ��������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('6', 'Գ����� �����, ��� �� ������������ �� ���''��� ������������ ��������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('7', '����� �������� ��������������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('8', '������������ ���� ������ (����������� ����)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('9', '������ ������ ������ (����)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('A', 'Գ������ ��������, ����������  ����, �� �� ��������� �������� (���������� �����������)', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('B', '����������� ����������, �� ������������ ����������������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values('#', '����� �������', to_date('01012019','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
