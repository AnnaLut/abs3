begin
  execute immediate 'create sequence S_NBU_CREDIT_INSURANCE_FILES
minvalue 0
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache
';
  dbms_output.put_line('sequence S_NBU_CREDIT_INSURANCE_FILES created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_NBU_CREDIT_INSURANCE_FILES already exists.');
    else 
      null;
    end if;
end;  
/