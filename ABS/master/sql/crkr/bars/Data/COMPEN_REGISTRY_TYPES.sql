prompt Loading COMPEN_REGISTRY_TYPES...
begin
    execute immediate 'insert into COMPEN_REGISTRY_TYPES (type_id, reg_code, type_name)
values (1, ''PAY_DEP'', ''������� ��������������� ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_TYPES (type_id, reg_code, type_name)
values (2, ''PAY_BUR'', ''������� ��������������� ������ �� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
