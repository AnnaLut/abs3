begin
  execute immediate 'create sequence S_SW_COMPARE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache';
  dbms_output.put_line('sequence S_SW_COMPARE created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_SW_COMPARE already exists.');
    else 
      raise; 
    end if;
end;  
/