prompt Loading COMPEN_OPER_STATES...
begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (0, ''���� ������������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (10, ''����� ������������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (20, ''ϳ���������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (30, ''�������� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into COMPEN_OPER_STATES (state_id, state_name)
values (40, ''�������� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

update COMPEN_OPER_STATES set state_name = '�������� ������� ��/��� ������� �������� ��-�����' where state_id = 40;


commit;
