begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(1, '���������� �� �������� ��������� ��������i �i����i��� �� ����i�� ��������� �������������i', to_date('04012008','DDMMYYYY'), to_date('31102016','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(1, '���������� �� �������� ���������', to_date('01112016','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(2, '���������� �� �������� �� ���������', to_date('04012008','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(3, '������ �� ��������, ����� �i� �������i� �������� �� ���i������', to_date('04012008','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(4, '���������� �� �������� ��������� �� ���������� ��������i', to_date('01062009','DDMMYYYY'), to_date('31102016','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(4, '���������� �� �������� ��������� ����������', to_date('01112016','DDMMYYYY'), null); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, '������ �����������,����� 䳿 ��������� �������� ���������', to_date('01082012','DDMMYYYY'), to_date('31012013','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'C���� 䳿 ��������� �������� ���������', to_date('01022013','DDMMYYYY'), to_date('30092013','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'C���� 䢕 ��������� �������� ���������, � ���� ���� ���������� ������������� ��������', to_date('01102013','DDMMYYYY'), to_date('31102016','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_state_calc(id, name, open_date, delete_date) values(5, 'C���� 䢕 �������� ���������, � ���� ���� ���������� ������������� ��������', to_date('01112016','DDMMYYYY'), to_date('30122017','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/


commit;

