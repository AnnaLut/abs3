
begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''URL'', ''http://10.10.10.44:18000/barsroot/api/nbuintegration/'', ''URL ���-������� ����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''MethodUrl'', ''nbuservice/GetDataFromNbu'', ''������ URL-����� �� ��� ������ ����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''UserName'', ''ILP26TEX'', ''���� ��������� ����������� ���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''password'', ''123456'', ''������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into BARS.SAGO_PARAMETERS (NAME, VALUE, COMM)
values (''Domain'', ''EXTERN'', ''������� ��''''�'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
