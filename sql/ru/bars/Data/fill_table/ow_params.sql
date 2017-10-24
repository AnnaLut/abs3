begin
    execute immediate 'insert into ow_params (PAR, VAL, COMM)
values (''ENABLEMKK'', ''0'', ''Функціонал МКК ЮО: 1- включено, 0 виключено'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 