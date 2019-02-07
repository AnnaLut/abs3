
prompt -- ======================================================
prompt -- create sequence
prompt -- ======================================================

begin
  execute immediate 'CREATE SEQUENCE BARS.S_STATWORKFLOWOPERATIONS START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE ORDER';
  dbms_output.put_line('sequence S_STATWORKFLOWOPERATIONS created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_STATWORKFLOWOPERATIONS already exists.');
    else 
      raise; 
    end if;
end;  
/