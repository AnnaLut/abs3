begin
    execute immediate 'insert into ow_params (PAR, VAL, COMM)
values (''ENABLEMKK'', ''0'', ''���������� ��� ��: 1- ��������, 0 ���������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 