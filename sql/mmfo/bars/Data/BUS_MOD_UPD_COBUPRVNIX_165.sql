--COBUPRVNIX-165 BUS_MOD_update.sql
begin
  Insert into BARS.BUS_MOD  (BUS_MOD_ID, BUS_MOD_NAME)
   Values (16, '��� ����� �� ����� ����������� �������');
exception when dup_val_on_index then null;
end;
/

begin
  Insert into BARS.BUS_MOD  (BUS_MOD_ID, BUS_MOD_NAME)
   Values (17, '���������� ��� �������� �������� ����� �� ��������� ������� ��������, �� �������������� ��� ������� ������������ ������ ������');
exception when dup_val_on_index then null;
end;
/

begin
  Insert into BARS.BUS_MOD  (BUS_MOD_ID, BUS_MOD_NAME)
   Values (18, '���������� ��� �������� �������� ����� �� ���������  �������������� ������� ��������');
exception when dup_val_on_index then null;
end;
/

commit;

update BUS_MOD set BUS_MOD_NAME = '���������� ��� �������� �������� ����� �� ��������� ������� ��������, �� �������������� ��� ������� ������������ ������ ������, �� �� ������� �� ��� �������� ���������� ������' where BUS_MOD_ID = 3;
update BUS_MOD set BUS_MOD_NAME = '�� ������������ ������� �� ������������ ���������� � ����� �������� ��� ������ ��� �������� �� �� ����.��������� ���.�������������, �������� ������������� �� �� ��� �������� ���������� ������ ' where BUS_MOD_ID = 4;
update BUS_MOD set BUS_MOD_NAME = '���������� ��� �������� �������� ����� �� ���������  �������������� ������� �������� �� ��� ��  �������' where BUS_MOD_ID = 5;

commit;
   
update BUS_MOD set BUS_MOD_ID_IFRS = '1' where BUS_MOD_ID = 1;   
update BUS_MOD set BUS_MOD_ID_IFRS = '2' where BUS_MOD_ID = 2;
update BUS_MOD set BUS_MOD_ID_IFRS = '3.1' where BUS_MOD_ID = 3; 
update BUS_MOD set BUS_MOD_ID_IFRS = '4' where BUS_MOD_ID = 4; 
update BUS_MOD set BUS_MOD_ID_IFRS = '5.1' where BUS_MOD_ID = 5; 
update BUS_MOD set BUS_MOD_ID_IFRS = '6' where BUS_MOD_ID = 6; 
update BUS_MOD set BUS_MOD_ID_IFRS = '7' where BUS_MOD_ID = 7; 
update BUS_MOD set BUS_MOD_ID_IFRS = '8' where BUS_MOD_ID = 8; 
update BUS_MOD set BUS_MOD_ID_IFRS = '9' where BUS_MOD_ID = 9; 
update BUS_MOD set BUS_MOD_ID_IFRS = '10' where BUS_MOD_ID = 10; 
update BUS_MOD set BUS_MOD_ID_IFRS = '11' where BUS_MOD_ID = 11; 
update BUS_MOD set BUS_MOD_ID_IFRS = '12' where BUS_MOD_ID = 12; 
update BUS_MOD set BUS_MOD_ID_IFRS = '13' where BUS_MOD_ID = 13; 
update BUS_MOD set BUS_MOD_ID_IFRS = '14' where BUS_MOD_ID = 14; 
update BUS_MOD set BUS_MOD_ID_IFRS = '15' where BUS_MOD_ID = 15; 
update BUS_MOD set BUS_MOD_ID_IFRS = '16' where BUS_MOD_ID = 16; 
update BUS_MOD set BUS_MOD_ID_IFRS = '3.2' where BUS_MOD_ID = 17; 
update BUS_MOD set BUS_MOD_ID_IFRS = '5.2' where BUS_MOD_ID = 18;  
   
commit;
