begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (1, '������� ����������� ������', 1, '������� ����������� ������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (2, '������� ����������� ������ ��� ����� �� ������ � ������� ��� ���� �� ��� �� ������', 99, 'I���� ��������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (3, '��������� ���������� ����� ����������� ������', 15, '��������� ���������� �����');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (4, '�������� ��� ����������', 3, '�������� ���  ����������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (5, '���������� �������� ���������� �����������', 13, '������� �����������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (6, '������� �� ������� ����������', 17, '����������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (7, '���������� �������� ����� ��� ������������', 99, 'I���� ��������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (8, '���������� ������', 16, '���������� ������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (9, '������� ����������� ������ ��� ����� �� ������', 11, '������� ��.������ ��� ����� �� ������ ��� ������, �� ����. ������� ������. �� ��������');
exception when dup_val_on_index then 
    null;
end;
/
begin
Insert into BARS.CF_MAPPING_DOCTYPE
   (TYPE_CF, NAME_CF, TYPE_ABS, NAME_ABS)
 Values
   (10, '������� ����������� ������ � ������ ID-������', 7, '������� ID-������');
exception when dup_val_on_index then 
    null;
end;
/
COMMIT;
