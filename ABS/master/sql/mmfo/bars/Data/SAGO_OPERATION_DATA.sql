begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN01'', ''��������� ������ � �� �� �� ������ ������ �� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN02'', ''������������� ������ �� ������ ������ �� �������� �� �� ��'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN03'', ''�������� ������ �� ���/��'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BN04'', ''³��������� ������ �� ���/��'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into SAGO_OPERATION (ID, NAME)
values (''BNZ2'', null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
