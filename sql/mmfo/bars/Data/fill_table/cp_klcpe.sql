begin insert into cp_klcpe values('1', '��������, ������� ������������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('2', '��������, ������� ��������� ��������� ���������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('3', '��������, ������� �������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('4', '��������, ������� �������� �������� �������������� '); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('5', '��������, ������� ������������� ����������� ����������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('6', 'ֳ�� ������ ������� ���'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('7', '��������, ������� �������� �������� ����� '); exception when dup_val_on_index then null; end; 
/

begin insert into cp_klcpe values('8', '�������'); exception when dup_val_on_index then null; end; 
/

commit;