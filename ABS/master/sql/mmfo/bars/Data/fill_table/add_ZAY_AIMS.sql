begin 
  execute immediate     '
	insert into ZAY_AIMS (AIM,NAME,TYPE,DESCRIPTION,DESCRIPTION_ENG)
	values (9,''����������'',1,''������� ��� ���������� �� �������� ���������'',''Credit for return on trade'')
';
exception when dup_val_on_index then 
  null;
end;
/
commit;
