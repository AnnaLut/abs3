begin
    execute immediate 'insert into compen_benef_code(code, descr)
values (''D'', ''������� �����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into compen_benef_code(code, descr)
values (''N'', ''����������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into compen_benef_code(code, descr)
values (''Z'', ''����������� �������������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

--�� �������������� �� ���������� ���� � ����
update compen_benef
   set code = 'N'
 where code = 'Z';

delete compen_benef_code where code = 'Z';
update compen_benef_code set descr = '����������� �������������' where code = 'N';
