-- Create sequence 

begin 
   execute immediate  'create sequence BARS.s_nettosslog minvalue 0 maxvalue 9999999 start with 1 increment by 1 cache 20';
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence s_nettosslog already exists.');
    else 
      raise; 
    end if;
end;
/

