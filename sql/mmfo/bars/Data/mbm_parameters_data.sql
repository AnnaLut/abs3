begin
    execute immediate 'insert into mbm_parameters (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
					   values (''Corp2.BaseApiUrl'', null, ''URL ��� ���������� �� Corp2'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;


