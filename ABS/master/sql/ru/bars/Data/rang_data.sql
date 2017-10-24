begin
    execute immediate 'insert into rang (RANG, NAME)
values (88, ''Блоковано ВПО'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
