begin
    execute immediate 'insert into compen_benef_code(code, descr)
values (''D'', ''Довірена особа'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into compen_benef_code(code, descr)
values (''N'', ''Спадкоємець'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into compen_benef_code(code, descr)
values (''Z'', ''Заповідальне розпорядження'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

--це перейменування як вияснилось мало б бути
update compen_benef
   set code = 'N'
 where code = 'Z';

delete compen_benef_code where code = 'Z';
update compen_benef_code set descr = 'Заповідальне розпорядження' where code = 'N';
