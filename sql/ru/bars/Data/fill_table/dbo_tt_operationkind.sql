SET DEFINE OFF;

begin
	Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
		Values (4, 20, 'DP1', 'Перевод с счета на карту');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (4, 20, 'DP1', 'Перевод с счета на карту');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (1, 1, 'FO5', 'Перевод между счетами');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (2, 2, 'FO5', 'Перевод 3му лицу в пределах банка');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (3, 3, 'FO6', 'СЭП');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (6, 5, 'DP1', 'Поповнення вкладу (з поточн., картк. рах.клієнта)');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (7, 6, 'FOA', 'Первинний внесок на вклад (з поточн., картк. рах.клієнта)');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (8, 7, 'FOR', 'Погашення кредиту');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (9, 8, 'FOC', 'Поповнення вкладу, випл. зі вкладу (з поточн., картк. рах.клієнта)');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (10, 4, 'FOM', 'test');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
COMMIT;
