prompt sequence S_SGNDATA

begin 
  execute immediate 'create sequence S_SGNDATA'; 
  dbms_output.put_line( 'Sequence created.' );
exception
  when others then
    if sqlcode = -955 
    then null;
    else raise;
    end if;
end;
/