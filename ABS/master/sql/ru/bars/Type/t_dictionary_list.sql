declare
  e_obj_exists exception;
  pragma exception_init( e_obj_exists, -00955 );
begin
  execute immediate 'create type T_DICTIONARY_LIST as table of T_DICTIONARY';
exception
  when e_obj_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
end;
/

grant execute on T_DICTIONARY_LIST to BARS_ACCESS_DEFROLE;
