
begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''URL'', ''http://10.10.10.44:18000/barsroot/api/nbuintegration/'', ''URL веб-сервера САГО'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''MethodUrl'', ''nbuservice/GetDataFromNbu'', ''Секція URL-шляху до веб методу САГО'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''UserName'', ''ILP26TEX'', ''Логін технічного користувача НБУ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''password'', ''123456'', ''Пароль'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''Domain'', ''EXTERN'', ''Доменне ім''''я'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
