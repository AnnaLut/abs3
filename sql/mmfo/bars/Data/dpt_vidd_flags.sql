begin
 insert into dpt_vidd_flags(ID, NAME, DESCRIPTION, MAIN_TT, ONLY_ONE, MOD_PROC, ACTIVITY, REQUEST_TYPECODE, USED_EBP)
 values (38, '������ ��� ²������� �������� ����� ���� 24/7', '��������� ��� ��������, �������� � ������ �������', null, 1, null, 1, null, 1);
exception when dup_val_on_index then
 update dpt_vidd_flags
    set NAME = '������ ��� ²������� �������� ����� ���� 24/7',
        DESCRIPTION='��������� ��� ��������, �������� � ������ �������', 
        MAIN_TT = null,
        ONLY_ONE = 1, 
        MOD_PROC = null, 
        ACTIVITY = 1, 
        REQUEST_TYPECODE = null, 
        USED_EBP = 1
  where id = 38;
end;
/  
 
begin
 insert into dpt_vidd_flags(ID, NAME, DESCRIPTION, MAIN_TT, ONLY_ONE, MOD_PROC, ACTIVITY, REQUEST_TYPECODE, USED_EBP)
 values (39, '������ ��� �̲�� ������� ������� Ҳ�� �� ²����ʲ� �� �������� ����� ���� 24/7', '��������� ��� ��������, �������� � ������ �������', null, 1, null, 1, null, 1);
exception when dup_val_on_index then
 update dpt_vidd_flags
    set NAME = '������ ��� �̲�� ������� ������� Ҳ�� �� ²����ʲ� �� �������� ����� ���� 24/7',
        DESCRIPTION='��������� ��� ��������, �������� � ������ �������', 
        MAIN_TT = null,
        ONLY_ONE = 1, 
        MOD_PROC = null, 
        ACTIVITY = 1, 
        REQUEST_TYPECODE = null, 
        USED_EBP = 1
  where id = 39;
end;
/  

begin
 insert into dpt_vidd_flags(ID, NAME, DESCRIPTION, MAIN_TT, ONLY_ONE, MOD_PROC, ACTIVITY, REQUEST_TYPECODE, USED_EBP)
 values (40, '������ ��� ²����� ²� ����������ί ����������ֲ� �������� ����� ���� 24/7', '��������� ��� ��������, �������� � ������ �������', null, 1, null, 1, null, 1);
exception when dup_val_on_index then
 update dpt_vidd_flags
    set NAME = '������ ��� ²����� ²� ����������ί ����������ֲ� �������� ����� ���� 24/7',
        DESCRIPTION='��������� ��� ��������, �������� � ������ �������', 
        MAIN_TT = null,
        ONLY_ONE = 1, 
        MOD_PROC = null, 
        ACTIVITY = 1, 
        REQUEST_TYPECODE = null, 
        USED_EBP = 1
  where id = 40;
end;
/  
commit;
/