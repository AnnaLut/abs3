begin
    execute immediate 'insert into bars.sago_document_state (ID, NAME)
                       values (9999, ''�������� ��������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.sago_document_state (ID, NAME)
                       values (2, ''�������� �����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.sago_document_state (ID, NAME)
                       values (12, ''������� �������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
