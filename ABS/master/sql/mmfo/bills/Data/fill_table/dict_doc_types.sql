prompt fill table dict_doc_types
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (1, 'Application', '����� �� �������');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (2, 'ApplScan', '��������� ����� � �������');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (3, 'Other', '���� ���������');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (4, 'CalcRequest', '���������� ���� ����');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (5, 'ScanCalc', '����-���� ����������');
exception
	when dup_val_on_index then null;
end;
/
commit;