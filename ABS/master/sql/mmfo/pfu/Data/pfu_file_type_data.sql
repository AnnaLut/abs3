begin
    execute immediate 'insert into PFU_FILE_TYPE (ID, NAME)
values (''01'', ''�����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PFU_FILE_TYPE (ID, NAME)
values (''51'', ''�������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;