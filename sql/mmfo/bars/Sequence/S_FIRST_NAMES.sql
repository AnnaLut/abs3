prompt -- ======================================================
prompt -- create sequence
prompt -- ======================================================

begin
  execute immediate 'CREATE SEQUENCE BARS.S_FIRST_NAMES START WITH 3000 INCREMENT BY 1 NOCACHE NOCYCLE ORDER';
  dbms_output.put_line('sequence S_FIRST_NAMES created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_FIRST_NAMES already exists.');
    else 
      raise; 
    end if;
end;  
/