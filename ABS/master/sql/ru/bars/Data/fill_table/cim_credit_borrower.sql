begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(1, '����', to_date('01042003','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(1, '����-���.�������� �� ����������,�� ��������� ��������', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(2, '�i��������� � i��������� i�������i���,��� �� ���i��', to_date('01042003','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(3, 'I��i ������������', to_date('01042003','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(4, '�i���������,�� �������-�� i������.i���������(���i��)', to_date('01042003','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(5, '�i����� ����� - ���''��� �i����������� �i�������i', to_date('01042003','DDMMYYYY'), to_date('01102005','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(6, '�i�.�����,��� �� �������-�� �� ���''��� �i���.����-�i', to_date('01102005','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(7, '����� �i������� ��������������', to_date('01032006','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(8, '������������ ���� ������� (����������� ����)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(9, '������ ������ ������� (����)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(10, 'Ԣ�.���.,����-��� ��.,�� �� ��������� ��������(���)', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_borrower(id, name, open_date, delete_date) values(11, '����������� ���-���,�� ������������ ����������-��', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
