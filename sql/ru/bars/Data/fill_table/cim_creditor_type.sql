begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(1, 'I���� ���� ��� �i�������   ��������', to_date('01042002','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(1, 'I���� ����', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(2, 'I������� �����������       ������i�', to_date('01042002','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(3, '��i�i���� ��������', to_date('01042002','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(3, '��������� ���� ��� �������� ��������', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(4, 'I���� ��������� ��������', to_date('01042002','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(5, 'I���� ������ i�������', to_date('01042002','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(6, '������������ ����', to_date('01062009','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(7, 'I���, �����������, ��������� ��������', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_creditor_type(id, name, open_date, delete_date) values(8, '̢�������� ��������� ����������', to_date('31122017','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/


commit;
