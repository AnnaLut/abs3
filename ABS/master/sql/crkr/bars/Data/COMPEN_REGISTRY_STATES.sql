prompt Loading COMPEN_REGISTRY_STATES...
begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (0, ''��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (1, ''³��������� � ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (2, ''³��������� � ���, �������� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (3, ''������ �����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_REGISTRY_STATES (state_id, state_name)
values (4, ''³������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_REGISTRY_STATES T (STATE_ID, STATE_NAME)
  VALUES (5, ''���������� ������� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO COMPEN_REGISTRY_STATES T (STATE_ID, STATE_NAME)
  VALUES (6, ''������� ��� ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO COMPEN_REGISTRY_STATES T (STATE_ID, STATE_NAME)
  VALUES (9, ''���������� �������� � ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


commit;
