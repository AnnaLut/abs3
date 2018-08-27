
begin
  execute immediate 'create sequence S_OVR_INTX_COUNT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache';
  dbms_output.put_line('sequence S_OVR_INTX_COUNT created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_OVR_INTX_COUNT already exists.');
    else 
      raise; 
    end if;
end;  
/