begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(0, '������, ��������� �� ������� ��� ������������ �� ���������� ��������', to_date('01062009','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(1, '������, �� ���i��������� �� ������� ������� �������� �i���� �����i� �� �i����.�� i������.����.������', to_date('01072006','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(1, '������, �� ���i��������� �� ������� ������� �������� �i���� �����i� (������������)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(2, '������, �� ���������� �� ������ ��������������� �����', to_date('01072006','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(2, '������, ��������� �� ������ ��������������� ����� (��� �������������� ������������)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(3, '������������ ������', to_date('01072006','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(4, '����-���� i���� ������, �� �� �� ����� ������i�, ���������� ������ 1-3', to_date('01072006','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_type(id, name, open_date, delete_date) values(4, '����-���� i���� �������������� ������', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
