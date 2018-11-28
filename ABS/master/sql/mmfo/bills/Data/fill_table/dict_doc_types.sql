prompt fill table dict_doc_types
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (1, 'Application', 'Заява на виплату');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (2, 'ApplScan', 'Сканована заява з підписом');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (3, 'Other', 'Інші документи');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (4, 'CalcRequest', 'Розрахунок суми комісії');
exception
	when dup_val_on_index then null;
end;
/
begin
	insert into dict_doc_types (ID, CODE, DESCRIPTION)
	values (5, 'ScanCalc', 'Скан-копія розрахунку');
exception
	when dup_val_on_index then null;
end;
/
commit;