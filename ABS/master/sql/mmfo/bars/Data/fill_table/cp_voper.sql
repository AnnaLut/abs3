begin insert into cp_voper values('01', '������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('02', '���� (���)'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('03', '�������� �����'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('04', '���������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('05', '���������� �������� ����� ��� ����� (�������� ����), ���������� �������� ��� �� ���������� ������� �������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('06', '���������/������������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('07', '�������� �ᒺ��� (������� �ᒺ���) ��������� ����������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('08', '�����'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('09', '��������� ������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('10', '���������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('11', '�����������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('12', '��������� ������ �� ���������� �������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('13', '������ ��������� ��� ��������� ������� ������'); exception when dup_val_on_index then null; end; 
/

begin insert into cp_voper values('14', '���������'); exception when dup_val_on_index then null; end; 
/

commit;