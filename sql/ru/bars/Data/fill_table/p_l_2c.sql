begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('0', 'K����� �������� ������ �� ������ ����������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('1', '������ �������� ������ ��� ������ �� ������ ��������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('2', '������ �������� ������ � ����� ���������� ������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('3', '������� �������� ������ � ����� ���������� ������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('4', '������ �������� ������ � ����� ���������� ������ �� ������ ������ � ������������� ����������� ����� ���������� �������� �� ����, ���������� ��������� 2 ������ 1 ��������� �������� ��� �� 23 ������ 2015 ���� N 124 "��� ���������� ��������� ������ �������� ��������"');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('5', '������� �������� ������ �� ������ ����������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('6', '������������� ����� � ������� � ����� ���������� ������ �� ���������� �볺���-��������� �� ������� ����������� ����� ������������������������ �����-����������� � �������, �������� � �������������� �����');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('7', '������������� ����� � ������� �� ������ ���������� �� ���������� �볺���-��������� �� ������� ����������� ����� ����������������� ������� �����-����������� � �������, �������� � �������������� �����');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('8', '������������� �����, �� ����������� �� ������� ����������� ����� ��볿 ������������� �����, ������ �� ������� ����� ������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('9', '������/������������� �������� ������ � ����� ���������� �� ������ ���������� ��������� ��������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('A', '������/������������� ����� ��� ������ �������� �������� ��� �� ��������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
Insert into BARS.P_L_2C (ID, NAME)
 Values
   ('B', '������/������������� �������� ������ � ����� ���������� �� ������ ���������� ��������� �����, ��������� �� ������� ������ ������'
||' (��� ������� ��������� �������� ������ �� �������� ����� �� ���� �� ������, � ����� ������� ��������/���������� ������ ������ �� �������� �����),' 
||' ������������� ����, �����, ��������� �������� ��������� ��������� ������� ��������� ���, ������ � ������������� ��������� ��������� ���������');       
exception when dup_val_on_index then null;
          when others then raise;
end;
/

COMMIT;