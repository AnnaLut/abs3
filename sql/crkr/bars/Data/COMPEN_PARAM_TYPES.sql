prompt Loading COMPEN_PARAM_TYPES...
begin
    execute immediate 'insert into COMPEN_PARAM_TYPES (id, discription)
values (1, ''˳���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into COMPEN_PARAM_TYPES (id, discription)
values (2, ''���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
