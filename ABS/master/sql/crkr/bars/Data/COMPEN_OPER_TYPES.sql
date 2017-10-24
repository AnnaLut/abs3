prompt Loading COMPEN_OPER_TYPES...
begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (1, ''PAY_DEP'', ''������� ��������������� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (2, ''PAY_BUR'', ''������� ��������������� ������ �� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (8, ''ACT_HER'', ''���������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (7, ''DEACT'', ''³���� ����������� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (3, ''WDI'', ''���������� ������ � ������ ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (4, ''WDO'', ''�������� � ������ �� ����� �����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (5, ''ACT_DEP'', ''����������� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_TYPES (type_id, oper_code, text)
values (6, ''ACT_BUR'', ''����������� ������ �� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (11, ''CHANGE_D'', ''���� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (12, ''CHANGE_DA'', ''���� ���������(����������� �� dbcode)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (13, ''CHANGE_DB'', ''���� ���������(����������� �� rnk)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (21, ''REBRANCH'', ''����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

update COMPEN_OPER_TYPES t set t.oper_code = 'DEACT_DEP' where t.type_id = 7;
update COMPEN_OPER_TYPES t set t.oper_code = 'DEACT_BUR', t.text = '³���� ����������� ������ �� ���������' where t.type_id = 8;

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (17, ''ACT_HER'', ''����������� ������ �� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (31, ''BEN_ADD'', ''��������� ����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (32, ''BEN_MOD'', ''����������� ����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (33, ''BEN_DEL'', ''��������� ����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (9, ''REQ_DEACT_DEP'', ''����� �� ����� �����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'INSERT INTO COMPEN_OPER_TYPES T (TYPE_ID, OPER_CODE, TEXT)
  VALUES (10, ''REQ_DEACT_BUR'', ''����� �� ����� ����������� �� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



commit;
