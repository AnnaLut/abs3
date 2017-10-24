begin
    declare 
        p_new_version varchar2(100) := '0.3.1';
    begin 
        execute immediate 
            'Insert into MBM_PARAMETERS
                (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
            Values
                (''Version'', ''' || p_new_version || ''', ''Версія модуля'')';
            exception when others then 
            if sqlcode = -1 then 
            execute immediate 
                'update MBM_PARAMETERS set
                    PARAMETER_VALUE = ''' || p_new_version || '''
                where 
                    PARAMETER_NAME = ''Version''';
            else raise; 
        end if; 
    end;
end;
/ 
