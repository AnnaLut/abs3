begin
  begin insert into f049(f049, txt, d_open) values('1', '��� ���', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/

begin
  begin insert into f049(f049, txt, d_open) values('2', '���� ���������� (�������������� �� �������)', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/

begin
  begin insert into f049(f049, txt, d_open) values('3', '���� ���� ���������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('4', '���� ���� ������������ ��� ����������� ����� � ��������� �� ������ ��������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('5', '������� �볿��� � ������ �������������� �����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('6', '���������� ������������� ��������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('7', '����', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('8', '���� ���������� ���� ������� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('9', '���� ���� �������������. ���� ������ ������������� �� ��������� �� ���������� ������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('A', '����������� ������ 䳿 ��������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('B', '���� ���������� ��������� ������������ (���������)', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('C', '�������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into f049(f049, txt, d_open) values('#', '����� �������', to_date('01012019','DDMMYYYY')); exception when dup_val_on_index then null; end;
end;
/



commit;