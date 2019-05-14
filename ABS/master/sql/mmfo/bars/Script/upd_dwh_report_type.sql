prompt ===================================== 
prompt == ADD XLS-Format to DWH_REPORT_TYPE
prompt ===================================== 

begin
  insert into DWH_REPORT_TYPE (ID, VALUE, NAME, DESCRIPTION)
       values (3, 'XLS', 'XLS', 'XLS Формат');
  exception
    WHEN DUP_VAL_ON_INDEX
    THEN UPDATE DWH_REPORT_TYPE
            SET ID             = 3
                , VALUE        = 'XLS'
                , NAME         = 'XLS'
                , DESCRIPTION  = 'XLS Формат'
          WHERE ID = 3;
    WHEN OTHERS THEN NULL;
end;
/
COMMIT;
/