prompt -- ======================================================
prompt -- create sequence
prompt -- ======================================================

begin
  execute immediate 'CREATE SEQUENCE BARS.S_STAT_FILE_OPERATIONS_HIST START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE ORDER';
  dbms_output.put_line('sequence S_STAT_FILE_OPERATIONS_HIST created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_STAT_FILE_OPERATIONS_HIST already exists.');
    else 
      raise; 
    end if;
end;  
/