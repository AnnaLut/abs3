begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (11, ''������� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (12, ''������� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (13, ''������� ��� �������� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (14, ''������� ��� �����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (1, ''����� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (2, ''ϳ���� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (3, ''��������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_REQUEST_STATE (ID, NAME)
values (4, ''��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
