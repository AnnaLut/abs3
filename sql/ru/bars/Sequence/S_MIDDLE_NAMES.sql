prompt -- ======================================================
prompt -- create sequence
prompt -- ======================================================

begin
  execute immediate 'CREATE SEQUENCE BARS.S_MIDDLE_NAMES START WITH 4000 INCREMENT BY 1 NOCACHE NOCYCLE ORDER';
  dbms_output.put_line('sequence S_MIDDLE_NAMES created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_MIDDLE_NAMES already exists.');
    else 
      raise; 
    end if;
end;  
/