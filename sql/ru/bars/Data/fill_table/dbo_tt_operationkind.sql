SET DEFINE OFF;

begin
	Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
		Values (4, 20, 'DP1', '������� � ����� �� �����');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (4, 20, 'DP1', '������� � ����� �� �����');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (1, 1, 'FO5', '������� ����� �������');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (2, 2, 'FO5', '������� 3�� ���� � �������� �����');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (3, 3, 'FO6', '���');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (6, 5, 'DP1', '���������� ������ (� ������., �����. ���.�볺���)');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (7, 6, 'FOA', '��������� ������ �� ����� (� ������., �����. ���.�볺���)');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (8, 7, 'FOR', '��������� �������');
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/
 
begin
Insert into BARS.DBO_TT_OPERATIONKIND (ID, OPERATION_KIND, TT, NAME_OPERATION)
 Values (9, 8, 'FOC', '���������� ������, ����. � ������ (� ������., �����. ���.�볺���)');
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
