-- rename table ADDRESS_HOME_TYPE
--
begin
  execute immediate 'rename ADDRESS_HOME_TYPE to ADR_HOME_TYPE';
  dbms_output.put_line('Rename complete.');
exception
  when OTHERS then
    if ( sqlcode in ( -04043, - 00955))
    then dbms_output.put_line('Object "ADDRESS_HOME_TYPE" does not exist or ADR_HOME_TYPE allready exist.');
    else raise;
    end if;
end;
/

create or replace synonym BARS.ADDRESS_HOME_TYPE for BARS.ADR_HOME_TYPE;


begin
  begin
      execute immediate 'drop synonym BARS.ADDRESS_HOMEPART_TYPE';
  exception when OTHERS then null;
  end;    
      execute immediate 'rename ADDRESS_HOMEPART_TYPE to ADR_HOMEPART_TYPE';
      dbms_output.put_line('Rename complete.');
exception
  when OTHERS then
    if ( sqlcode in ( -04043))  then dbms_output.put_line('Object "ADDRESS_HOMEPART_TYPE" does not exist ');
    elsif ( sqlcode in (  - 00955)) then
    execute immediate 'drop table ADR_HOMEPART_TYPE';
      execute immediate 'rename ADDRESS_HOMEPART_TYPE to ADR_HOMEPART_TYPE';
      dbms_output.put_line('Rename complete.');
    end if;   
end;
/
create or replace synonym BARS.ADDRESS_HOMEPART_TYPE for BARS.ADR_HOMEPART_TYPE;

--
-- rename table ADDRESS_ROOM_TYPE
--
begin
  execute immediate 'rename ADDRESS_ROOM_TYPE to ADR_ROOM_TYPE';
  dbms_output.put_line('Rename complete.');
exception
  when OTHERS then
    if ( sqlcode in ( -04043, - 00955))
    then dbms_output.put_line('Object "ADDRESS_ROOM_TYPE" does not exist or allready exist ADR_ROOM_TYPE.');
    else raise;
    end if;
end;
/

create or replace synonym BARS.ADDRESS_ROOM_TYPE for BARS.ADR_ROOM_TYPE;



