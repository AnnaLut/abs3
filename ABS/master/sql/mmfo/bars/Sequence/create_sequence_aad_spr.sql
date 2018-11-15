-- Create sequence 
declare

begin 
  begin 
    execute immediate  'delete EAD_GENSEQUENCEKF';
    commit;
    end;
  for rec in (select k.ru, k.mfo from banks_ru k)
 loop
   begin   
   execute immediate  'create sequence BARS.SEQ_EAD_PRINTNUMBER_'||rec.mfo||' minvalue 0 maxvalue 9999999 start with 1 increment by 1 cache 20';
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_ADR_CA_FILES already exists.');
    else 
      raise; 
    end if;
end;  
   begin   
  
   insert into EAD_GENSEQUENCEKF sq (sq.id  , sq.sequence                   , sq.kf , sq.date_update ) 
                             values (rec.ru , 'SEQ_EAD_PRINTNUMBER_'||rec.mfo, rec.mfo, sysdate      );
                             
exception when others then       
  if sqlcode= -00001 or sqlcode= -06512 then null; else raise; end if; 
end; 

end loop; 
commit;
end;
/
