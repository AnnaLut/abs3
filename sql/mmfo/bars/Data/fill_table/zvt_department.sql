prompt Importing table zvt_department...

begin
  begin insert into zvt_department (DEPARTMENT_ID, NAME)
values (1, '����������� ���-�����'); exception when dup_val_on_index then null; end;

  begin insert into zvt_department (DEPARTMENT_ID, NAME)
values (2, '����������� ��������������� �����'); exception when dup_val_on_index then null; end;

end;
/
commit;
prompt Done.